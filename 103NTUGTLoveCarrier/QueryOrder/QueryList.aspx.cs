using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.QueryOrder
{
    public partial class QueryList: System.Web.UI.Page
    {
        string Phone;
        string Name;
        private string[] DateString = new string[] { "5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)" };
        private string[] ClassString = new string[] { "二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["QueryOrderName"] == null || Session["QueryOrderPhone"]==null)
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('請填寫姓名手機');window.location='/query';</script>");
                //Response.Redirect("/query");
                return;
            }
            Name = (string)Session["QueryOrderName"];
            Phone = (string)Session["QueryOrderPhone"];

            Session["QueryOrderName"] = null;
            Session["QueryOrderPhone"]= null;

            NameLabel.Text = "傳情者姓名：" + Name;
            PhoneLabel.Text = "傳情者手機：" + Phone;

            bool IsEmpty = true;

            string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection myConn = new SqlConnection(strConn);
            List<int> RIDSessionList = new List<int>();
            try
            {
                myConn.Open();
                String strSQL = @"SELECT RID,Day,Class,TeamMember1,TeamMember2,SongName,IsPaid from [Reserve],[Team],[Song] WHERE Reserve.TID = Team.TID and Reserve.SID = Song.SID and Reserve.Phone = @Phone and Reserve.Name = @Name order by RID";
                SqlCommand myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@Phone", Phone);
                myCommand.Parameters.AddWithValue("@Name", Name);
                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while(myDataReader.Read())
                    {
                        string RID = myDataReader[0].ToString();
                        RIDSessionList.Add(Convert.ToInt32(RID));
                        IsEmpty = false;
                        TableCell cell_button = new TableCell();
                        TableRow row = new TableRow();
                        Button button = new Button();
                        button.ID = RID;
                        button.Text = "More";
                        button.Attributes["class"] = "btn btn-primary";
                        button.Attributes["style"] = "padding: 8px;";
                        button.OnClientClick = "OpenInfoModal(" + RID + ",'" + Name + "','" + Phone + "');return false;";
                        //button.OnClientClick = "var result = confirm('確定選歌？\\n歌名：" + myDataReader[0].ToString() + "\\n日期：" + DateText[Date - 1] + "\\n時間：" + ClassText[Class] + "'); if(result){submitSession(); $('DateHdLabel').text() = " + Date + " ;} return false;";
                        cell_button.Controls.Add(button);
                        row.Cells.Add(cell_button);

                        int Date = Convert.ToInt32(myDataReader[1].ToString());
                        int Class = Convert.ToInt32(myDataReader[2].ToString());
                        string T1 = myDataReader[3].ToString();
                        string T2 = myDataReader[4].ToString();
                        string SName = myDataReader[5].ToString();
                        string IsPaid = myDataReader["IsPaid"].ToString();

                        TableCell cell_song = new TableCell();
                        cell_song.Text = DateString[Date - 1] + "<br>" + ClassString[Class - 2];
                        row.Cells.Add(cell_song);

                        TableCell cell_player = new TableCell();
                        cell_player.Text = SName + "<br>" + "(" + T1 + " " + T2 + ")";
                        row.Cells.Add(cell_player);

                        TableCell cell_pay = new TableCell();
                        if(IsPaid == "True")
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
            }
            finally
            {

                myConn.Close();

            }

            if(IsEmpty)
            {
                Session["QueryOrderRIDList"] = null;
                FormsAuthentication.SignOut();
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('查無資料');window.location='/query';</script>");
                //Response.Redirect("/query");
                return;
            }
            else
            {
                FormsAuthentication.SetAuthCookie("QueryFound", false);
                Session["QueryOrderRIDList"] = RIDSessionList;
            }
        }
    }
}