using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtisanXChange
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text;
            Response.Redirect("~/LocalSearch.aspx?query=" + Server.UrlEncode(searchQuery));
        }



        protected void Cart_Click(object sender, ImageClickEventArgs e)
        {
            // Any processing you need to do

            // Then redirect
            Response.Redirect("~/ArtisanCart.aspx");
        }
    }
}
