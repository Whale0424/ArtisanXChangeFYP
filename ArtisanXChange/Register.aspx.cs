using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;



    namespace ArtisanXChange
{
        public partial class Register : System.Web.UI.Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    // Any initialization code if needed
                }
            }

            protected void btnRegister_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    // Get connection string from web.config
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        try
                        {
                            // Create SQL command
                            SqlCommand cmd = new SqlCommand("INSERT INTO Users (Username, Password, Email, ContactNo, UserType) VALUES (@Username, @Password, @Email, @ContactNo, @UserType)", con);

                            // Add parameters
                            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            cmd.Parameters.AddWithValue("@ContactNo", txtContactNo.Text.Trim());
                            cmd.Parameters.AddWithValue("@UserType", ddlUserType.SelectedValue);

                            // Open connection and execute command
                            con.Open();
                            int result = cmd.ExecuteNonQuery();

                            if (result > 0)
                            {
                                // Clear form fields after successful registration
                                ClearForm();

                                // Display success message
                                lblMessage.Text = "Registration successful! Redirecting to login page in 3 seconds...";
                                lblMessage.ForeColor = System.Drawing.Color.Green;

                                // JavaScript to redirect after 3 seconds
                                string redirectScript = "setTimeout(function(){ window.location.href = 'Login.aspx'; }, 3000);";
                                ClientScript.RegisterStartupScript(this.GetType(), "RedirectScript", redirectScript, true);
                            }
                        }
                        catch (Exception ex)
                        {
                            lblMessage.Text = "Error: " + ex.Message;
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                        finally
                        {
                            // Ensure connection is closed even if an exception occurs
                            if (con.State == ConnectionState.Open)
                            {
                                con.Close();
                            }
                        }
                    }
                }
            }

            private void ClearForm()
            {
                txtUsername.Text = string.Empty;
                txtPassword.Text = string.Empty;
                txtConfirmPassword.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtContactNo.Text = string.Empty;
                ddlUserType.SelectedIndex = 0;
            }
        }
    }

