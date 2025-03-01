using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace ArtisanXChange
{
    public partial class LocalDelete : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No special logic needed on page load
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            string productId = LocalProdID.Text.Trim();

            if (string.IsNullOrEmpty(productId))
            {
                lblMessage.Text = "Please enter a Product ID.";
                lblMessage.CssClass = "error-message";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // First, delete related records from LocalCartItem (if ON DELETE CASCADE is NOT enabled)
                    SqlCommand cmd1 = new SqlCommand("DELETE FROM LocalCartItem WHERE LocalProdID = @ProductID", conn);
                    cmd1.Parameters.AddWithValue("@ProductID", productId);
                    cmd1.ExecuteNonQuery();

                    // Then, delete the product itself
                    SqlCommand cmd2 = new SqlCommand("DELETE FROM LocalProducts WHERE LocalProdID = @ProductID", conn);
                    cmd2.Parameters.AddWithValue("@ProductID", productId);

                    int rowsAffected = cmd2.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Product deleted permanently!";
                        lblMessage.CssClass = "success-message";
                    }
                    else
                    {
                        lblMessage.Text = "Product not found.";
                        lblMessage.CssClass = "error-message";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "error-message";
                }
            }
        }
    }
}
