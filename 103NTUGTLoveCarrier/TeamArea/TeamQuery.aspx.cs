using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.TeamArea
{
    public partial class TeamQuery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["TeamQuery"] = null;
                Session["TeamQueryRIDList"] = null;
                FormsAuthentication.SignOut();

                string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
                SqlConnection myConn = new SqlConnection(strConn);
                try
                {
                    myConn.Open();
                    String strSQL = @"SELECT TID, 'No.' + CAST([TID] AS CHAR(2)) + ' ' + [TeamMember1] + ' ' + [TeamMember2] AS TeamMember FROM [Team]";
                    SqlCommand myCommand = new SqlCommand(strSQL, myConn);
                    using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                    {
                        TeamList.DataSource = myDataReader;
                        TeamList.DataTextField = "TeamMember";
                        TeamList.DataValueField = "TID";
                        TeamList.DataBind();
                    }
                }
                finally
                {

                    myConn.Close();

                }
            }
        }

        protected void SubmitTime_Click(object sender, EventArgs e)
        {
            Session["TeamQuery"] = TeamList.SelectedItem.Value;
            FormsAuthentication.SetAuthCookie("TeamQuery", false);
            Response.Redirect("/teamquerylist");
        }
    }
}