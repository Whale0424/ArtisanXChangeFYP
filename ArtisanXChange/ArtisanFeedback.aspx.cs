using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtisanXChange
{
    public partial class ArtisanFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize page if needed
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Validate input
            if (string.IsNullOrEmpty(txtName.Text) ||
                string.IsNullOrEmpty(txtContactNumber.Text) ||
                string.IsNullOrEmpty(txtEmail.Text) ||
                string.IsNullOrEmpty(txtFeedback.Text))
            {
                lblMessage.Text = "Please fill in all fields.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Get form data
            string name = txtName.Text.Trim();
            string contactNumber = txtContactNumber.Text.Trim();
            string email = txtEmail.Text.Trim();
            string feedback = txtFeedback.Text.Trim();

            // Get connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Open connection
                    conn.Open();

                    // Create command for inserting feedback
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO LocalFeedback (UserID, LocalFeedbackText, LocalContactEmail, LocalCustomerName, LocalContactNumber) " +
                        "VALUES (@UserID, @FeedbackText, @Email, @Name, @ContactNumber)", conn))
                    {
                        // Add parameters
                        cmd.Parameters.AddWithValue("@UserID", 1); // Default UserID (modify as needed)
                        cmd.Parameters.AddWithValue("@FeedbackText", feedback);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);

                        // Execute command
                        cmd.ExecuteNonQuery();
                    }
                }

                // Display success message
                lblMessage.Text = "Thank you for your feedback! We will get back to you soon.";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Clear form fields
                txtName.Text = string.Empty;
                txtContactNumber.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtFeedback.Text = string.Empty;
            }
            catch (Exception ex)
            {
                // Display error message
                lblMessage.Text = "An error occurred. Please try again later.";
                lblMessage.ForeColor = System.Drawing.Color.Red;

                // Log the error (in a production environment)
                System.Diagnostics.Debug.WriteLine("Error saving feedback: " + ex.Message);
            }
        }
    }
}