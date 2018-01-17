using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.RestrictPages.OrderSystem
{
    public partial class DetailListAuthenticate : System.Web.UI.Page
    {
        protected override void OnError(EventArgs e)
        {
            base.OnError(e);

            Exception ex = Server.GetLastError();

            if(ex is HttpRequestValidationException)
            {
                Server.ClearError();

                string js = "<script type='text/javascript'>" +
                            "alert('發生錯誤，可能其中包含危險字元，若問題持續發生，請洽吉他社工作人員！');" +
                            "window.location='/';" +
                            "</script>";

                Response.Write(js);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["authenticated"] = null;
            Session["QueryOrderRIDList"] = null;
            FormsAuthentication.SignOut();
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if(pwd.Text == "103love")
            {
                Session["authenticated"] = "true";
                FormsAuthentication.SetAuthCookie("103staff", false);
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('登入成功！');window.location='/staff/secretlist'</script>");
                //Response.Redirect("/staff/secretlist");
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('密碼錯誤！');</script>");
                Session["authenticated"] = null;
                FormsAuthentication.SignOut();
            }
        }
    }
}