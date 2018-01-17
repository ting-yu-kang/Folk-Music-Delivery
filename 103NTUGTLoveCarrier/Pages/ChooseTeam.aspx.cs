using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.Pages
{
    public partial class ChooseTeam: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder TeamDiv = new StringBuilder();
            string TID, Team, TeamDetail, Ratio, ImageCount;
            int ReserveCount, TotalCount;
            string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection myConn = new SqlConnection(strConn);
            try
            {
                myConn.Open();
                String strSQL = @"SELECT Team.TID,ISNULL(RCountTable.RCount,0) as ReserveCount,TCountTable.TCount as TotalCount, Team.TeamMember1, Team.TeamMember2, Team.DepartGrade1, Team.DepartGrade2, Team.ImageCount
                    FROM (select TID,count(1) AS TCount from Time group by(TID))as TCountTable,
                    (Team
                    LEFT JOIN (select TID,count(1) AS RCount from Reserve group by(TID))as RCountTable
                    ON RCountTable.TID = Team.TID)
                    Where Team.TID = TCountTable.TID
                    order by Team.TID";
                SqlCommand myCommand = new SqlCommand(strSQL, myConn);

                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while(myDataReader.Read())
                    {
                        TID = myDataReader["TID"].ToString();
                        Team = myDataReader["TeamMember1"].ToString();
                        TeamDetail = myDataReader["DepartGrade1"].ToString() + " " + myDataReader["TeamMember1"].ToString();
                        if(myDataReader["TeamMember2"].ToString() != "")
                        {
                            Team += " " + myDataReader["TeamMember2"].ToString();
                            TeamDetail += " / " + myDataReader["DepartGrade2"].ToString() + " " + myDataReader["TeamMember2"].ToString();
                        }
                        ReserveCount = Convert.ToInt32(myDataReader["ReserveCount"].ToString());
                        TotalCount = Convert.ToInt32(myDataReader["TotalCount"].ToString());
                        Ratio = TotalCount - ReserveCount + " / " + TotalCount;
                        ImageCount = myDataReader["ImageCount"].ToString();

                        TeamDiv.Append("<div class=\"col-lg-3 col-md-3 col-sm-4 col-ms-6 col-xs-12 profile\">");
                        TeamDiv.AppendFormat("<div class=\"img-box " + "Team_" + TID + "\" onclick=\"OpenTeamModal({0},'{1}','{2}','{3}',{4})\">", TID, Team, TeamDetail, Ratio, ImageCount);
                        TeamDiv.AppendFormat("<img src=\"/images/Players/{0}-1.JPG\" class=\"img-responsive\" />", myDataReader["TID"].ToString());
                        TeamDiv.Append("<span><i class=\"glyphicon glyphicon-fullscreen\"></i></span>");
                        TeamDiv.Append("</div>");
                        TeamDiv.AppendFormat("<h1>No.{0} {1}</h1>", myDataReader["TID"].ToString(), Team);
                        TeamDiv.AppendFormat("<h2>available：{0}</h2>", TotalCount - ReserveCount);
                        TeamDiv.Append("</div>");
                        Literal1.Text = TeamDiv.ToString();
                    }
                }

                int getTID = TryToParse(Request.QueryString["tid"]);
                if(getTID > 0)
                {
                    ClientScript.RegisterStartupScript(GetType(), "click", "<script>$('.Team_" + getTID + "').click();</script>");
                }
            }
            finally
            {
                myConn.Close();
            }
        }

        private static int TryToParse(string value)
        {
            int number;
            bool result = Int32.TryParse(value, out number);
            if(result)
            {
                return number;
            }
            else
            {
                return -1;
            }
        }
    }
}