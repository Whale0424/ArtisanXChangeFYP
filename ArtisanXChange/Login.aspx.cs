
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;


namespace ArtisanXChange
{
   

        public partial class Login : System.Web.UI.Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    // Clear any existing session
                    Session.Clear();
                }
            }

            protected void btnLogin_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    // Get connection string from web.config
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        try
                        {
                            // Create SQL command to check user credentials
                            SqlCommand cmd = new SqlCommand("SELECT UserId, Username, UserType FROM Users WHERE Username = @Username AND Password = @Password", con);

                            // Add parameters
                            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                            // Create data adapter and fill dataset
                            SqlDataAdapter sda = new SqlDataAdapter(cmd);
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            // Check if user exists
                            if (dt.Rows.Count > 0)
                            {
                                // Store user information in session
                                Session["UserId"] = dt.Rows[0]["UserId"].ToString();
                                Session["Username"] = dt.Rows[0]["Username"].ToString();
                                Session["UserType"] = dt.Rows[0]["UserType"].ToString();

                                // Redirect to home page
                                Response.Redirect("HomepageLocal.aspx");
                            }
                            else
                            {
                                // Display error message for invalid credentials
                                lblMessage.Text = "Invalid username or password";
                            }
                        }
                        catch (Exception ex)
                        {
                            lblMessage.Text = "Error: " + ex.Message;
                        }
                    }
                }
            }
        }
    }