using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ArtisanXChange
{
    public partial class LocalUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page no longer automatically loads product details
            // This method is now empty since we're using manual loading
        }

        protected void LoadButton_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ProductID.Text))
            {
                lblMessage.Text = "Please enter a Product ID.";
                lblMessage.CssClass = "error-message";
                return;
            }

            int productId;
            if (int.TryParse(ProductID.Text, out productId))
            {
                LoadProductDetails(productId);
            }
            else
            {
                lblMessage.Text = "Invalid Product ID. Please enter a numeric value.";
                lblMessage.CssClass = "error-message";
            }
        }

        private void LoadProductDetails(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM LocalProducts WHERE LocalProdID = @LocalProdID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@LocalProdID", productId);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // No need to update the ProductID field since user already entered it
                        LocalCatID.SelectedValue = reader["LocalCatID"].ToString();
                        LocalProdName.Text = reader["LocalProdName"].ToString();
                        LocalProdDesc.Text = reader["LocalProdDesc"].ToString();
                        LocalProdPrice.Text = reader["LocalProdPrice"].ToString();
                        LocalProdQuantity.Text = reader["LocalProdQuantity"].ToString();
                        LocalProdImageURL.Text = reader["LocalProdImageURL"].ToString();

                        lblMessage.Text = "Product loaded successfully!";
                        lblMessage.CssClass = "success-message";
                    }
                    else
                    {
                        ClearFields(); // Clear form fields if product not found
                        lblMessage.Text = "Product not found.";
                        lblMessage.CssClass = "error-message";
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error loading product: " + ex.Message;
                    lblMessage.CssClass = "error-message";
                }
            }
        }

        private void ClearFields()
        {
            // Keep ProductID as is, but clear other fields
            LocalProdName.Text = string.Empty;
            LocalProdDesc.Text = string.Empty;
            LocalProdPrice.Text = string.Empty;
            LocalProdQuantity.Text = string.Empty;
            LocalProdImageURL.Text = string.Empty;
            // Don't reset category since it might be useful to keep
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            int productId;
            if (!int.TryParse(ProductID.Text, out productId))
            {
                lblMessage.Text = "Invalid Product ID.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (string.IsNullOrEmpty(LocalCatID.SelectedValue))
            {
                lblMessage.Text = "Please select a valid category.";
                lblMessage.CssClass = "error-message";
                return;
            }

            int categoryId;
            if (!int.TryParse(LocalCatID.SelectedValue, out categoryId))
            {
                lblMessage.Text = "Invalid Category.";
                lblMessage.CssClass = "error-message";
                return;
            }

            // Add validation for price and quantity
            decimal price;
            if (!decimal.TryParse(LocalProdPrice.Text, out price))
            {
                lblMessage.Text = "Invalid price format.";
                lblMessage.CssClass = "error-message";
                return;
            }

            int quantity;
            if (!int.TryParse(LocalProdQuantity.Text, out quantity))
            {
                lblMessage.Text = "Invalid quantity format.";
                lblMessage.CssClass = "error-message";
                return;
            }

            // Validate required fields
            if (string.IsNullOrEmpty(LocalProdName.Text) ||
                string.IsNullOrEmpty(LocalProdDesc.Text) ||
                string.IsNullOrEmpty(LocalProdImageURL.Text))
            {
                lblMessage.Text = "All fields are required.";
                lblMessage.CssClass = "error-message";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string updateQuery = @"
            UPDATE LocalProducts 
            SET LocalCatID = @LocalCatID,
                LocalProdName = @LocalProdName,
                LocalProdDesc = @LocalProdDesc,
                LocalProdPrice = @LocalProdPrice,
                LocalProdQuantity = @LocalProdQuantity,
                LocalProdImageURL = @LocalProdImageURL
            WHERE LocalProdID = @LocalProdID";

                SqlCommand cmd = new SqlCommand(updateQuery, conn);
                cmd.Parameters.AddWithValue("@LocalProdID", productId);
                cmd.Parameters.AddWithValue("@LocalCatID", categoryId);
                cmd.Parameters.AddWithValue("@LocalProdName", LocalProdName.Text);
                cmd.Parameters.AddWithValue("@LocalProdDesc", LocalProdDesc.Text);
                cmd.Parameters.AddWithValue("@LocalProdPrice", price);
                cmd.Parameters.AddWithValue("@LocalProdQuantity", quantity);
                cmd.Parameters.AddWithValue("@LocalProdImageURL", LocalProdImageURL.Text);

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Product updated successfully!";
                        lblMessage.CssClass = "success-message";
                    }
                    else
                    {
                        lblMessage.Text = "Product update failed. Product ID may not exist.";
                        lblMessage.CssClass = "error-message";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error updating product: " + ex.Message;
                    lblMessage.CssClass = "error-message";
                }
            }
        }
    }
}
