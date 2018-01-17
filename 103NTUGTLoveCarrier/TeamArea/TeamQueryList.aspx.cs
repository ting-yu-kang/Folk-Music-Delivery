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
    public partial class TeamQueryList : System.Web.UI.Page
    {
        string TID;
        private string[] DateString = new string[] { "5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)" };
        private string[] ClassString = new string[] { "二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)" };
        private string[] GeneralLessonString = new string[] { "否", "是", "不知道" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TeamQuery"] == null)
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('請選擇歌手');window.location='/teamquery';</script>");
                //Response.Redirect("/query");
                return;
            }
            TID = (string)Session["TeamQuery"];

            Session["TeamQuery"] = null;

            bool IsEmpty = true;

            string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection myConn = new SqlConnection(strConn);
            List<int> RIDSessionList = new List<int>();
            try
            {
                myConn.Open();
                String strSQL = @"SELECT RID,Reserve.TID,TeamMember1,TeamMember2,ISPaid,SongName,Place,Day,Class,ClassName,GeneralLesson
                                    from [Reserve],[Team],[Song] 
                                    WHERE Reserve.TID = Team.TID and Reserve.SID = Song.SID and Reserve.TID = @TID
                                    ORDER BY Day, Class";
                SqlCommand myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@TID", TID);
                using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while (myDataReader.Read())
                    {
                        string RID = myDataReader["RID"].ToString();
                        RIDSessionList.Add(Convert.ToInt32(RID));
                        IsEmpty = false;
                        TableCell cell_button = new TableCell();
                        TableRow row = new TableRow();
                        Button button = new Button();
                        button.ID = RID;
                        button.Text = "More";
                        button.Attributes["class"] = "btn btn-primary";
                        button.Attributes["style"] = "padding: 8px;";
                        button.OnClientClick = "OpenInfoModal(" + RID + "," + TID + ");return false;";
                        //button.OnClientClick = "var result = confirm('確定選歌？\\n歌名：" + myDataReader[0].ToString() + "\\n日期：" + DateText[Date - 1] + "\\n時間：" + ClassText[Class] + "'); if(result){submitSession(); $('DateHdLabel').text() = " + Date + " ;} return false;";
                        cell_button.Controls.Add(button);
                        row.Cells.Add(cell_button);

                        int Date = Convert.ToInt32(myDataReader["Day"].ToString());
                        int Class = Convert.ToInt32(myDataReader["Class"].ToString());
                        string T1 = myDataReader["TeamMember1"].ToString();
                        string T2 = myDataReader["TeamMember2"].ToString();
                        string IsPaid = myDataReader["IsPaid"].ToString();
                        int GeneralLesson = Convert.ToInt32(myDataReader["GeneralLesson"].ToString());
                        string Place = myDataReader["Place"].ToString();
                        string SongName = myDataReader["SongName"].ToString();
                        string ClassName = myDataReader["ClassName"].ToString();

                        TeamLabel.Text = "組別： No." + myDataReader["TID"].ToString() + " " + T1 + (T2 != "" ? " " + T2 : "");

                        TableCell cell_RID = new TableCell();
                        cell_RID.Text = RID;
                        row.Cells.Add(cell_RID);

                        TableCell cell_date = new TableCell();
                        cell_date.Text = DateString[Date - 1];
                        row.Cells.Add(cell_date);

                        TableCell cell_class = new TableCell();
                        cell_class.Text = ClassString[Class - 2];
                        row.Cells.Add(cell_class);

                        TableCell cell_song = new TableCell();
                        cell_song.Text = SongName;
                        row.Cells.Add(cell_song);

                        TableCell cell_place = new TableCell();
                        cell_place.Text = Place;
                        row.Cells.Add(cell_place);

                        TableCell cell_className = new TableCell();
                        cell_className.Text = ClassName;
                        row.Cells.Add(cell_className);

                        TableCell cell_generalLession = new TableCell();
                        cell_generalLession.Text = GeneralLessonString[GeneralLesson];
                        row.Cells.Add(cell_generalLession);

                        TableCell cell_pay = new TableCell();
                        if (IsPaid == "True")
                        {
                            cell_pay.Text = "是";
                            cell_pay.Attributes["style"] = "color:green; font-weight:bold;";
                        }
                        else
                        {
                            cell_pay.Text = "否";
                            cell_pay.Attributes["style"] = "color:red; font-weight:bold;";
                        }
                        row.Cells.Add(cell_pay);

                        myTable.Rows.Add(row);
                    }
                }

                /*Time Table*/
                TimeTableClass timeTableArray = new TimeTableClass();
                strSQL = @"SELECT Time.Day, Time.Class FROM Time Where Time.TID = @TID";
                myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@TID", TID);
                using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while (myDataReader.Read())
                    {
                        int Date, Class;
                        Date = Convert.ToInt32(myDataReader["Day"].ToString());
                        Class = Convert.ToInt32(myDataReader["Class"].ToString());
                        timeTableArray.schedule[Date - 1, Class - 2] = -1;
                    }
                }
                strSQL = @"SELECT RID, Day, Class FROM Reserve Where Reserve.TID = @TID";
                myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@TID", TID);
                using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while (myDataReader.Read())
                    {
                        int Date, Class, RID;
                        Date = Convert.ToInt32(myDataReader["Day"].ToString());
                        Class = Convert.ToInt32(myDataReader["Class"].ToString());
                        RID = Convert.ToInt32(myDataReader["RID"].ToString());
                        timeTableArray.schedule[Date - 1, Class - 2] = RID;
                    }
                }

                for (int i = 0; i < 8; i++)
                {
                    TableRow row = new TableRow();
                    for (int j = 0; j < 6; j++)
                    {
                        TableCell cell_RID = new TableCell();
                        if (j == 0)
                            cell_RID.Text = "<a data-toggle=\"tooltip\" data-placement=\"top\" title=\""+ ClassString[i]+"\">" + Convert.ToString(i + 2) + "</a>";
                        else
                        {
                            if (timeTableArray.schedule[j - 1, i] == -1)
                                cell_RID.Text = "<span class=\"label label-success\"><i class=\"fa fa-check\"></i></span>";
                            else if (timeTableArray.schedule[j - 1, i] > 0)
                                cell_RID.Text = "<span class=\"btn btn-danger btm-sm\" onclick=\"return OpenInfoModal(" + timeTableArray.schedule[j - 1, i] + "," + TID + "); \"><i class=\"fa fa-clock-o\"></i></span>";
                            else
                                cell_RID.Text = "";
                        }
                        row.Cells.Add(cell_RID);
                    }
                    TimeTable.Rows.Add(row);
                }

                /*Ratio*/
                strSQL = @"SELECT ISNULL(RCountTable.RCount,0) as ReserveCount,TCountTable.TCount as TotalCount
                    FROM (select TID,count(1) AS TCount from Time group by(TID))as TCountTable,
                    (Team
                    LEFT JOIN (select TID,count(1) AS RCount from Reserve group by(TID))as RCountTable
                    ON RCountTable.TID = Team.TID)
                    Where Team.TID = TCountTable.TID
                    and Team.TID = @TID";
                myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@TID", TID);

                using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    myDataReader.Read();
                    int ReserveCount = Convert.ToInt32(myDataReader["ReserveCount"].ToString());
                    int TotalCount = Convert.ToInt32(myDataReader["TotalCount"].ToString());
                    RatioLabel.Text = "已點時段：" + ReserveCount + " / " + TotalCount;
                }

            }
            finally
            {

                myConn.Close();

            }

            if (IsEmpty)
            {
                Session["TeamQueryRIDList"] = null;
                FormsAuthentication.SignOut();
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('查無資料');window.location='/teamquery';</script>");
                //Response.Redirect("/query");
                return;
            }
            else
            {
                Session["TeamQueryRIDList"] = RIDSessionList;
                //ClientScript.RegisterStartupScript(GetType(), "getTimeTable", "<script>getTimeTable(" + TID + ")</script>");
            }
        }

        public class TimeTableClass
        {
            public int[,] schedule = new int[5, 8];
        }
    }
}