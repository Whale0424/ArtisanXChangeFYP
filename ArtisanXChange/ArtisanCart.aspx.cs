using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace ArtisanXChange
{
    public partial class ArtisanCart : System.Web.UI.Page
    {
        // Shipping cost constants
        private const decimal WEST_MALAYSIA_SHIPPING = 8.00M;
        private const decimal EAST_MALAYSIA_SHIPPING = 15.00M;
        private const decimal FREE_SHIPPING_THRESHOLD = 100.00M;

        private readonly string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserId"] == null)
                {
                    // Redirect to login page
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Initialize shipping region selection
                if (Session["ShippingRegion"] == null)
                {
                    Session["ShippingRegion"] = "West"; // Default to West Malaysia
                }

                // Set the selected region in the dropdown
                ddlShippingRegion.SelectedValue = Session["ShippingRegion"].ToString();

                // Load cart items
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            // Get cart from session
            DataTable dtCart = GetCartFromSession();

            if (dtCart != null && dtCart.Rows.Count > 0)
            {
                pnlCart.Visible = true;
                pnlEmptyCart.Visible = false;

                gvCart.DataSource = dtCart;
                gvCart.DataBind();

                // Calculate and display totals
                CalculateCartTotals();
            }
            else
            {
                pnlCart.Visible = false;
                pnlEmptyCart.Visible = true;
            }
        }

        private DataTable GetCartFromSession()
        {
            if (Session["Cart"] != null)
            {
                return (DataTable)Session["Cart"];
            }
            else
            {
                // Create new cart if it doesn't exist
                DataTable dtCart = new DataTable();
                dtCart.Columns.Add("ProductId", typeof(int));
                dtCart.Columns.Add("ProductName", typeof(string));
                dtCart.Columns.Add("ProductImage", typeof(string));
                dtCart.Columns.Add("Price", typeof(decimal));
                dtCart.Columns.Add("Quantity", typeof(int));
                Session["Cart"] = dtCart;
                return dtCart;
            }
        }

        private void SaveCartToSession(DataTable dtCart)
        {
            Session["Cart"] = dtCart;
        }

        private void CalculateCartTotals()
        {
            DataTable dtCart = GetCartFromSession();
            decimal subtotal = 0;

            foreach (DataRow row in dtCart.Rows)
            {
                decimal price = Convert.ToDecimal(row["Price"]);
                int quantity = Convert.ToInt32(row["Quantity"]);
                subtotal += price * quantity;
            }

            // Display subtotal
            lblSubtotal.Text = subtotal.ToString("F2");

            // Calculate shipping based on region and order value
            decimal shippingCost = CalculateShippingCost(subtotal);

            // Display shipping cost
            lblShipping.Text = shippingCost.ToString("F2");

            // Calculate and display total
            decimal total = subtotal + shippingCost;
            lblTotal.Text = total.ToString("F2");

            // Update shipping information message
            UpdateShippingMessage(subtotal, shippingCost);
        }

        private decimal CalculateShippingCost(decimal subtotal)
        {
            // Free shipping for purchases of RM100 and above
            if (subtotal >= FREE_SHIPPING_THRESHOLD)
            {
                return 0.00M;
            }

            // Otherwise, charge based on region
            string region = ddlShippingRegion.SelectedValue;
            return region == "East" ? EAST_MALAYSIA_SHIPPING : WEST_MALAYSIA_SHIPPING;
        }

        private void UpdateShippingMessage(decimal subtotal, decimal shippingCost)
        {
            if (shippingCost == 0)
            {
                lblShippingMessage.Text = "You qualify for FREE shipping!";
                lblShippingMessage.CssClass = "text-success font-weight-bold";
            }
            else
            {
                decimal amountForFreeShipping = FREE_SHIPPING_THRESHOLD - subtotal;
                if (amountForFreeShipping > 0)
                {
                    lblShippingMessage.Text = $"Add RM {amountForFreeShipping:F2} more to qualify for FREE shipping!";
                    lblShippingMessage.CssClass = "text-info";
                }
                else
                {
                    lblShippingMessage.Text = "";
                }
            }
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "IncreaseQty" || e.CommandName == "DecreaseQty" || e.CommandName == "RemoveItem")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                DataTable dtCart = GetCartFromSession();
                DataRow[] rows = dtCart.Select("ProductId = " + productId);

                if (rows.Length > 0)
                {
                    DataRow row = rows[0];

                    if (e.CommandName == "IncreaseQty")
                    {
                        int currentQty = Convert.ToInt32(row["Quantity"]);

                        // Check stock availability
                        int availableStock = GetAvailableStock(productId);

                        if (currentQty < availableStock)
                        {
                            row["Quantity"] = currentQty + 1;
                        }
                        else
                        {
                            lblMessage.Text = "Cannot add more. Maximum available quantity reached.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else if (e.CommandName == "DecreaseQty")
                    {
                        int currentQty = Convert.ToInt32(row["Quantity"]);
                        if (currentQty > 1)
                        {
                            row["Quantity"] = currentQty - 1;
                        }
                    }
                    else if (e.CommandName == "RemoveItem")
                    {
                        row.Delete();
                    }

                    SaveCartToSession(dtCart);
                    LoadCartItems();
                }
            }
        }

        private int GetAvailableStock(int productId)
        {
            int stock = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT LocalProdQuantity FROM LocalProducts WHERE LocalProdID = @ProductId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ProductId", productId);

                try
                {
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        stock = Convert.ToInt32(result);
                    }
                }
                catch (Exception ex)
                {
                    // Log error
                    System.Diagnostics.Debug.WriteLine("Error getting stock: " + ex.Message);
                }
            }

            return stock;
        }

        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get product ID for current row
                int productId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ProductId"));

                // Get current quantity in cart
                int currentQty = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Quantity"));

                // Get available stock
                int availableStock = GetAvailableStock(productId);

                // Find increase button and disable if at max stock
                Button btnIncrease = e.Row.FindControl("btnIncrease") as Button;
                if (btnIncrease != null)
                {
                    btnIncrease.Enabled = currentQty < availableStock;
                }
            }
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            // Redirect to products page or home page
            Response.Redirect("HomepageLocal.aspx");
        }

        protected void btnProceedCheckout_Click(object sender, EventArgs e)
        {
            // Check if cart has items
            DataTable dtCart = GetCartFromSession();
            if (dtCart != null && dtCart.Rows.Count > 0)
            {
                // Save shipping region to session
                Session["ShippingRegion"] = ddlShippingRegion.SelectedValue;

                // Redirect to checkout page - UPDATED TO USE ARTISANCHECKOUT
                Response.Redirect("ArtisanCheckout.aspx");
            }
            else
            {
                lblMessage.Text = "Your cart is empty. Please add items before proceeding to checkout.";
            }
        }

        protected void ddlShippingRegion_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Save selection to session
            Session["ShippingRegion"] = ddlShippingRegion.SelectedValue;

            // Recalculate totals with new shipping cost
            CalculateCartTotals();
        }
    }
}