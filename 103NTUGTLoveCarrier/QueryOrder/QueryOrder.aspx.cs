using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.QueryOrder
{
    public partial class QueryOrder: System.Web.UI.Page
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
            Session["QueryOrderName"] = null;
            Session["QueryOrderPhone"] = null;
            Session["QueryOrderRIDList"] = null;
            FormsAuthentication.SignOut();
        }

        protected void SubmitTime_Click(object sender, EventArgs e)
        {
            Session["QueryOrderName"] = NameTextBox.Text;
            Session["QueryOrderPhone"] = PhoneTextBox.Text;
            FormsAuthentication.SetAuthCookie("QueryNotFound", false);
            Response.Redirect("/querylist");
        }
    }
}