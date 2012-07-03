using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSaveMyImage_Click(object sender, EventArgs e)
    {
        //This is where we save the binary data.
        //We need to make following convert.
        byte[] bytes = Convert.FromBase64String(txtImgBinary.Text);
        //You can store it to an SQL column in IMAGE type, I'll just store to the session.
        Session["capturedImgBinary"] = bytes;
        //Now let's go to preview page in order to see if it works.
        Response.Redirect("~/Preview.aspx");
    }
}