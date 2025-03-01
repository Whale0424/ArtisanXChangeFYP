using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ArtisanXChange
{
    public partial class ArtisanCheckout : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx?returnUrl=ArtisanCheckout.aspx");
                    return;
                }

                // Load cart items
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            DataTable cart = Session["Cart"] as DataTable;

            if (cart == null || cart.Rows.Count == 0)
            {
                Response.Redirect("ArtisanCart.aspx");
                return;
            }

            // Bind cart items to repeater
            rptCartItems.DataSource = cart;
            rptCartItems.DataBind();

            // Calculate totals
            decimal subtotal = CalculateSubtotal(cart);
            decimal shipping = CalculateShipping(subtotal);
            decimal total = subtotal + shipping;

            // Display values
            lblSubtotal.Text = subtotal.ToString("0.00");
            lblShipping.Text = shipping.ToString("0.00");
            lblTotal.Text = total.ToString("0.00");
        }

        private decimal CalculateSubtotal(DataTable cart)
        {
            decimal subtotal = 0;
            foreach (DataRow row in cart.Rows)
            {
                decimal price = Convert.ToDecimal(row["Price"]);
                int quantity = Convert.ToInt32(row["Quantity"]);
                subtotal += price * quantity;
            }
            return subtotal;
        }

        private decimal CalculateShipping(decimal subtotal)
        {
            if (subtotal >= 100)
                return 0; // Free shipping

            string region = Session["ShippingRegion"]?.ToString() ?? "West";
            return region == "East" ? 15.00M : 8.00M;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            try
            {
                // Basic validation
                if (string.IsNullOrEmpty(txtFullName.Text) ||
                    string.IsNullOrEmpty(txtAddress.Text) ||
                    string.IsNullOrEmpty(txtCity.Text) ||
                    string.IsNullOrEmpty(txtState.Text) ||
                    string.IsNullOrEmpty(txtPostcode.Text) ||
                    string.IsNullOrEmpty(txtPhone.Text))
                {
                    ShowMessage("Please fill in all required fields", true);
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);
                DataTable cart = Session["Cart"] as DataTable;

                if (cart == null || cart.Rows.Count == 0)
                {
                    ShowMessage("Your cart is empty", true);
                    return;
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlTransaction transaction = connection.BeginTransaction();

                    try
                    {
                        // 1. Create cart record
                        int cartId = CreateCart(connection, transaction, userId);

                        // 2. Add cart items
                        AddCartItems(connection, transaction, cartId, cart);

                        // 3. Create order in LocalOrder table
                        CreateOrder(connection, transaction, userId, cartId);

                        // 4. Update product inventory
                        UpdateInventory(connection, transaction, cart);

                        // Commit transaction
                        transaction.Commit();

                        // Clear cart
                        Session["Cart"] = null;

                        // Redirect to confirmation
                        Response.Redirect("HomepageLocal.aspx?order=success");
                    }
                    catch (Exception ex)
                    {
                        // Rollback transaction on error
                        transaction.Rollback();
                        ShowMessage("Error placing order: " + ex.Message, true);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, true);
            }
        }

        private int CreateCart(SqlConnection connection, SqlTransaction transaction, int userId)
        {
            string query = @"
                INSERT INTO LocalCart (UserID, LocalCreatedDate, LocalCheckoutStatus)
                VALUES (@UserID, @CreatedDate, @CheckoutStatus);
                SELECT SCOPE_IDENTITY();";

            SqlCommand command = new SqlCommand(query, connection, transaction);
            command.Parameters.AddWithValue("@UserID", userId);
            command.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
            command.Parameters.AddWithValue("@CheckoutStatus", true);

            // Execute and get the new auto-generated cart ID
            return Convert.ToInt32(command.ExecuteScalar());
        }

        private void AddCartItems(SqlConnection connection, SqlTransaction transaction, int cartId, DataTable cart)
        {
            foreach (DataRow row in cart.Rows)
            {
                string query = @"
                    INSERT INTO LocalCartItem (LocalCartID, LocalProdID, Quantity)
                    VALUES (@CartID, @ProductID, @Quantity)";

                SqlCommand command = new SqlCommand(query, connection, transaction);
                command.Parameters.AddWithValue("@CartID", cartId);
                command.Parameters.AddWithValue("@ProductID", Convert.ToInt32(row["ProductId"]));
                command.Parameters.AddWithValue("@Quantity", Convert.ToInt32(row["Quantity"]));

                command.ExecuteNonQuery();
            }
        }

        private void CreateOrder(SqlConnection connection, SqlTransaction transaction, int userId, int cartId)
        {
            string query = @"
                INSERT INTO LocalOrder (UserID, LocalPaymentStatus, LocalOrderDate, 
                                       LocalReceiverName, LocalReceiverPhoneNo, 
                                       LocalReceiverAddress, LocalReceiverState, LocalReceiverPostcode)
                VALUES (@UserID, @PaymentStatus, @OrderDate, 
                       @ReceiverName, @ReceiverPhoneNo, 
                       @ReceiverAddress, @ReceiverState, @ReceiverPostcode)";

            SqlCommand command = new SqlCommand(query, connection, transaction);
            command.Parameters.AddWithValue("@UserID", userId);
            command.Parameters.AddWithValue("@PaymentStatus", "Paid");
            command.Parameters.AddWithValue("@OrderDate", DateTime.Now);
            command.Parameters.AddWithValue("@ReceiverName", txtFullName.Text);
            command.Parameters.AddWithValue("@ReceiverPhoneNo", txtPhone.Text);
            command.Parameters.AddWithValue("@ReceiverAddress", txtAddress.Text);
            command.Parameters.AddWithValue("@ReceiverState", txtState.Text);
            command.Parameters.AddWithValue("@ReceiverPostcode", txtPostcode.Text);

            command.ExecuteNonQuery();
        }

        private void UpdateInventory(SqlConnection connection, SqlTransaction transaction, DataTable cart)
        {
            foreach (DataRow row in cart.Rows)
            {
                string query = @"
                    UPDATE LocalProducts
                    SET LocalProdQuantity = LocalProdQuantity - @Quantity
                    WHERE LocalProdID = @ProductID AND LocalProdQuantity >= @Quantity";

                SqlCommand command = new SqlCommand(query, connection, transaction);
                command.Parameters.AddWithValue("@ProductID", Convert.ToInt32(row["ProductId"]));
                command.Parameters.AddWithValue("@Quantity", Convert.ToInt32(row["Quantity"]));

                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    throw new Exception($"Not enough stock for product: {row["ProductName"]}");
                }
            }
        }

        private void ShowMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isError ? "message error" : "message success";
            lblMessage.Visible = true;
        }
    }
}