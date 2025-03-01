using System;
using System.Configuration;
using System.Data.SqlClient;

namespace ArtisanXChange
{
    public partial class LocalCreate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "INSERT INTO LocalProducts (LocalCatID, LocalProdName, LocalProdDesc, LocalProdPrice, LocalProdQuantity, LocalProdImageURL) " +
                                   "VALUES (@LocalCatID, @LocalProdName, @LocalProdDesc, @LocalProdPrice, @LocalProdQuantity, @LocalProdImageURL)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@LocalCatID", LocalCatID.SelectedValue);
                        cmd.Parameters.AddWithValue("@LocalProdName", ProductName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LocalProdDesc", ProductDesc.Text.Trim());
                        cmd.Parameters.AddWithValue("@LocalProdPrice", Convert.ToDecimal(ProductPrice.Text));
                        cmd.Parameters.AddWithValue("@LocalProdQuantity", Convert.ToInt32(ProductQuantity.Text));
                        cmd.Parameters.AddWithValue("@LocalProdImageURL", ProductURL.Text.Trim());

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "<span class='success-message'>Product added successfully!</span>";
                            ClearForm();
                        }
                        else
                        {
                            lblMessage.Text = "<span class='error-message'>Error adding product.</span>";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = $"<span class='error-message'>Error: {ex.Message}</span>";
                }
            }
        }

        private void ClearForm()
        {
            ProductName.Text = "";
            ProductDesc.Text = "";
            ProductPrice.Text = "";
            ProductQuantity.Text = "";
            ProductURL.Text = "";
            LocalCatID.SelectedIndex = 0;
        }
    }
}
