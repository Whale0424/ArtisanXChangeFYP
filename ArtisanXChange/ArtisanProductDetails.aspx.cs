using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace ArtisanXChange
{
    public partial class ArtisanProductDetails : System.Web.UI.Page
    {
        private string prodID;
        private readonly string strCon = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            prodID = Request.QueryString["LocalProdID"];
            if (!IsPostBack && !string.IsNullOrEmpty(prodID))
            {
                LoadProductDetails(prodID);
            }
        }

        private void LoadProductDetails(string localProdID)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = "SELECT LocalProdName, LocalProdDesc, LocalProdPrice, LocalProdImageURL, LocalProdQuantity FROM LocalProducts WHERE LocalProdID = @LocalProdID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LocalProdID", localProdID);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblLocalProdName.Text = reader["LocalProdName"].ToString();
                        lblProductDescription.Text = reader["LocalProdDesc"].ToString();
                        lblProductPrice.Text = "RM " + Convert.ToDecimal(reader["LocalProdPrice"]).ToString("0.00");
                        imgProduct.ImageUrl = reader["LocalProdImageURL"].ToString().Trim();

                        // Simply display the database stock without subtracting cart quantity
                        int dbStock = Convert.ToInt32(reader["LocalProdQuantity"]);

                        if (dbStock > 0)
                        {
                            lblStock.Text = dbStock + " Stocks Available";
                            AddToCartButton.Enabled = true;
                            txtQuantity.Text = "1";
                        }
                        else
                        {
                            lblStock.Text = "Out of Stock!";
                            AddToCartButton.Enabled = false;
                            txtQuantity.Text = "0";
                        }
                    }
                    else
                    {
                        lblLocalProdName.Text = "Product not found.";
                        AddToCartButton.Enabled = false;
                    }
                }
                catch (Exception ex)
                {
                    DisplayMessage("Error: " + ex.Message, true);
                }
            }
        }

        protected void AddToCartButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(prodID))
            {
                DisplayMessage("Product ID is missing.", true);
                return;
            }

            int quantity = GetQuantity();
            if (quantity <= 0)
            {
                DisplayMessage("Please enter a valid quantity.", true);
                return;
            }

            // Get current database stock (always fetch the latest)
            int currentStock = GetCurrentStock(prodID);
            if (currentStock < quantity)
            {
                DisplayMessage($"Cannot add more. Only {currentStock} items available.", true);
                return;
            }

            // Create or get the cart
            DataTable dtCart = Session["Cart"] as DataTable ?? CreateCartTable();

            // Add to cart or update quantity
            DataRow existingRow = dtCart.AsEnumerable().FirstOrDefault(row => row.Field<int>("ProductId").ToString() == prodID);
            if (existingRow != null)
            {
                existingRow["Quantity"] = Convert.ToInt32(existingRow["Quantity"]) + quantity;
            }
            else
            {
                DataRow newRow = dtCart.NewRow();
                newRow["ProductId"] = Convert.ToInt32(prodID);
                newRow["ProductName"] = lblLocalProdName.Text;
                newRow["ProductImage"] = imgProduct.ImageUrl;
                newRow["Price"] = decimal.Parse(lblProductPrice.Text.Replace("RM", "").Trim());
                newRow["Quantity"] = quantity;
                dtCart.Rows.Add(newRow);
            }

            Session["Cart"] = dtCart;
            DisplayMessage("Item added to cart!", false);
            LoadProductDetails(prodID);
        }

        private int GetCurrentStock(string productId)
        {
            int stock = 0;
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = "SELECT LocalProdQuantity FROM LocalProducts WHERE LocalProdID = @LocalProdID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LocalProdID", productId);

                try
                {
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        stock = Convert.ToInt32(result);
                    }
                }
                catch (Exception ex)
                {
                    DisplayMessage("Error checking stock: " + ex.Message, true);
                }
            }
            return stock;
        }

        private DataTable CreateCartTable()
        {
            DataTable dtCart = new DataTable();
            dtCart.Columns.Add("ProductId", typeof(int));
            dtCart.Columns.Add("ProductName", typeof(string));
            dtCart.Columns.Add("ProductImage", typeof(string));
            dtCart.Columns.Add("Price", typeof(decimal));
            dtCart.Columns.Add("Quantity", typeof(int));
            return dtCart;
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            int quantity = GetQuantity();
            if (quantity > 1)
            {
                txtQuantity.Text = (quantity - 1).ToString();
            }
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            int quantity = GetQuantity();
            txtQuantity.Text = (quantity + 1).ToString();
        }

        private int GetQuantity()
        {
            return int.TryParse(txtQuantity.Text, out int quantity) ? quantity : 1;
        }

        private void DisplayMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
        }
    }
}