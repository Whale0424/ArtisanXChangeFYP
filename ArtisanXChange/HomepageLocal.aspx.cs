using System;
using System.Web.UI;

namespace ArtisanXChange
{
    public partial class HomepageLocal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] generalImages = {
            ResolveUrl("/Image/ImageBook.jpg"),
            ResolveUrl("/Image/ImageSticker.jpg"),
            ResolveUrl("/Image/ImagePostcard.jpg"),
            ResolveUrl("/Image/ImageOthers.jpg")
        };
                SetImages(generalImages);
            }
        }




        protected void btnVisit_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }

        private void SetImages(string[] imagePaths)
        {
            if (imagePaths.Length >= 4)
            {
                ImageBook.ImageUrl = imagePaths[0];
                ImageSticker.ImageUrl = imagePaths[1];
                ImagePostcard.ImageUrl = imagePaths[2];
                ImageOthers.ImageUrl = imagePaths[3];
            }
        }
    }
}
