using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Net.Mail;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtisanXChange
{
    public partial class LocalFeedbackReview : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringLocal"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in as admin
                // If needed, uncomment and adjust this code according to your authentication system
                /*
                if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                */

                // Load feedback data
                LoadFeedbackData();

                // Load feedback count statistics
                LoadFeedbackStatistics();
            }
        }

        private void LoadFeedbackStatistics()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Total count
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM LocalFeedback", conn))
                    {
                        int totalCount = Convert.ToInt32(cmd.ExecuteScalar());
                        lblTotalCount.Text = totalCount.ToString();
                    }

                    // Today count
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM LocalFeedback WHERE CONVERT(date, LocalFeedbackDate) = CONVERT(date, GETDATE())", conn))
                    {
                        int todayCount = Convert.ToInt32(cmd.ExecuteScalar());
                        lblTodayCount.Text = todayCount.ToString();
                    }

                    // Week count
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM LocalFeedback WHERE LocalFeedbackDate >= DATEADD(day, -7, GETDATE())", conn))
                    {
                        int weekCount = Convert.ToInt32(cmd.ExecuteScalar());
                        lblWeekCount.Text = weekCount.ToString();
                    }

                    // Month count
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM LocalFeedback WHERE LocalFeedbackDate >= DATEADD(month, -1, GETDATE())", conn))
                    {
                        int monthCount = Convert.ToInt32(cmd.ExecuteScalar());
                        lblMonthCount.Text = monthCount.ToString();
                    }
                }
                catch (Exception ex)
                {
                    DisplayMessage("Error loading statistics: " + ex.Message, false);
                }
            }
        }

        private void LoadFeedbackData()
        {
            string whereClause = BuildFilterWhereClause();
            string query = "SELECT LocalFeedbackID, UserID, LocalFeedbackText, LocalContactEmail, LocalCustomerName, LocalContactNumber, LocalFeedbackDate FROM LocalFeedback " + whereClause + " ORDER BY LocalFeedbackDate DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters if search is enabled
                    if (!string.IsNullOrEmpty(txtSearch.Text))
                    {
                        cmd.Parameters.AddWithValue("@SearchTerm", "%" + txtSearch.Text.Trim() + "%");
                    }

                    try
                    {
                        conn.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        gvFeedback.DataSource = dt;
                        gvFeedback.DataBind();

                        // Hide feedback details panel when loading new data
                        pnlFeedbackDetails.Style["display"] = "none";
                    }
                    catch (Exception ex)
                    {
                        // Log error and show message
                        DisplayMessage("Error loading feedback: " + ex.Message, false);
                    }
                }
            }
        }

        private string BuildFilterWhereClause()
        {
            StringBuilder whereClause = new StringBuilder();
            whereClause.Append("WHERE 1=1"); // Always true condition to simplify building the query

            // Date filtering
            if (ddlDateFilter.SelectedValue != "all")
            {
                string dateCondition = "";

                switch (ddlDateFilter.SelectedValue)
                {
                    case "today":
                        dateCondition = "CONVERT(date, LocalFeedbackDate) = CONVERT(date, GETDATE())";
                        break;
                    case "week":
                        dateCondition = "LocalFeedbackDate >= DATEADD(day, -7, GETDATE())";
                        break;
                    case "month":
                        dateCondition = "LocalFeedbackDate >= DATEADD(month, -1, GETDATE())";
                        break;
                }

                if (!string.IsNullOrEmpty(dateCondition))
                {
                    whereClause.Append(" AND " + dateCondition);
                }
            }

            // Search filtering
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                whereClause.Append(" AND (LocalCustomerName LIKE @SearchTerm OR LocalContactEmail LIKE @SearchTerm)");
            }

            return whereClause.ToString();
        }

        protected void ddlDateFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadFeedbackData();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadFeedbackData();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlDateFilter.SelectedValue = "all";
            LoadFeedbackData();
        }

        protected void gvFeedback_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFeedback.PageIndex = e.NewPageIndex;
            LoadFeedbackData();
        }

        protected void gvFeedback_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int feedbackId = Convert.ToInt32(e.CommandArgument);
                DisplayFeedbackDetails(feedbackId);
            }
        }

        private void DisplayFeedbackDetails(int feedbackId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM LocalFeedback WHERE LocalFeedbackID = @FeedbackID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FeedbackID", feedbackId);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // Populate details panel
                            lblDetailName.Text = reader["LocalCustomerName"].ToString();
                            lblDetailEmail.Text = reader["LocalContactEmail"].ToString();
                            lblDetailContact.Text = reader["LocalContactNumber"].ToString();
                            lblDetailMessage.Text = reader["LocalFeedbackText"].ToString();

                            // Format date if exists
                            if (reader["LocalFeedbackDate"] != DBNull.Value)
                            {
                                lblDetailDate.Text = Convert.ToDateTime(reader["LocalFeedbackDate"]).ToString("dd/MM/yyyy HH:mm");
                            }
                            else
                            {
                                lblDetailDate.Text = "No date recorded";
                            }

                            // Store the feedback ID for actions
                            hdnSelectedFeedbackID.Value = feedbackId.ToString();

                            // Show the details panel
                            pnlFeedbackDetails.Style["display"] = "block";
                        }
                    }
                    catch (Exception ex)
                    {
                        DisplayMessage("Error retrieving feedback details: " + ex.Message, false);
                    }
                }
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            // Get the email address from the detail view
            string recipientEmail = lblDetailEmail.Text.Trim();
            string customerName = lblDetailName.Text.Trim();

            // This is where you would typically implement the email sending functionality
            // For demo purposes, we'll just show a success message

            DisplayMessage("Reply email prepared for: " + recipientEmail + ". Use your email client to send the response.", true);

            // In a real implementation, you might redirect to a compose email page or use SMTP to send email
            /*
            try
            {
                // Example SMTP code (would need configuration in web.config)
                SmtpClient smtpClient = new SmtpClient();
                MailMessage mail = new MailMessage();
                
                mail.From = new MailAddress("theartisanxchangeart@gmail.com", "ArtisanXChange Support");
                mail.To.Add(new MailAddress(recipientEmail, customerName));
                mail.Subject = "Response to Your Feedback - ArtisanXChange";
                mail.Body = "Dear " + customerName + ",\n\nThank you for your feedback...\n\nBest regards,\nArtisanXChange Support Team";
                
                smtpClient.Send(mail);
                
                DisplayMessage("Reply sent successfully to " + recipientEmail, true);
            }
            catch (Exception ex)
            {
                DisplayMessage("Error sending reply: " + ex.Message, false);
            }
            */
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int feedbackId;
            if (int.TryParse(hdnSelectedFeedbackID.Value, out feedbackId))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM LocalFeedback WHERE LocalFeedbackID = @FeedbackID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FeedbackID", feedbackId);

                        try
                        {
                            conn.Open();
                            int result = cmd.ExecuteNonQuery();

                            if (result > 0)
                            {
                                // Hide the details panel
                                pnlFeedbackDetails.Style["display"] = "none";

                                // Reload the feedback grid
                                LoadFeedbackData();

                                // Reload statistics
                                LoadFeedbackStatistics();

                                DisplayMessage("Feedback has been successfully deleted.", true);
                            }
                            else
                            {
                                DisplayMessage("Unable to delete feedback. Record may no longer exist.", false);
                            }
                        }
                        catch (Exception ex)
                        {
                            DisplayMessage("Error deleting feedback: " + ex.Message, false);
                        }
                    }
                }
            }
        }

        private void DisplayMessage(string message, bool isSuccess)
        {
            pnlMessage.CssClass = isSuccess ? "message-panel message-success" : "message-panel message-error";
            lblMessage.Text = message;
            pnlMessage.Visible = true;
            pnlMessage.Style["display"] = "block";
        }
    }
}