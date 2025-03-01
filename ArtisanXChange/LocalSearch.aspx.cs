using System;
using System.Web.UI.WebControls;

namespace ArtisanXChange
{
    public partial class LocalSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string searchQuery = Request.QueryString["query"];
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    lblSearchResult.Text = '"' + searchQuery + '"';

                    // Ensure the parameter exists before setting it
                    if (SqlDataSource1.SelectParameters["SearchQuery"] != null)
                    {
                        SqlDataSource1.SelectParameters["SearchQuery"].DefaultValue = searchQuery;
                        // Don't call Repeater1.DataBind(); because SqlDataSource auto-binds
                    }
                }
                else
                {
                    lblSearchResult.Text = "No search query provided.";
                }
            }
        }
    }
}
