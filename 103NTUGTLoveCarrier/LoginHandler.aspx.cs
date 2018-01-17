using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier
{
    public partial class LoginHandler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            char[] character = { '/' };

            if (Request["ReturnUrl"] != null)
            {
                string[] strs = Request["ReturnUrl"].Split(character);

                if (strs[1] == "staff")
                {
                    Response.Redirect(@"/staff/secret");
                }
                else if (strs[1] == "API")
                {
                    Response.Redirect(@"/");
                }
                else if (strs[1] == "querylist" || strs[1] == "query")
                {
                    Response.Redirect(@"/query");
                }
                else if (strs[1] == "teamquerylist" || strs[1] == "teamquery")
                {
                    Response.Redirect(@"/teamquery");
                }
                else
                {
                    Response.Redirect(@"/");
                }
            }
            Response.Redirect(@"/");
        }
    }
}