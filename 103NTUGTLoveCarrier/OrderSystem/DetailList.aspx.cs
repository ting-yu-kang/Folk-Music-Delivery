using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

using NPOI;
using NPOI.HSSF.UserModel;
using NPOI.XSSF.UserModel;
using NPOI.SS.UserModel;
using System.Web.Configuration;
using System.Data;
using System.IO;

namespace NTUGTLoveCarrier.OrderSystem
{
    public partial class DetailList : System.Web.UI.Page
    {
        List<Reserve> reserve = new List<Reserve>();
        private string[] DateString = new string[] { "5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)" };
        private string[] ClassString = new string[] { "二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)" };
        List<int> RIDSessionList = new List<int>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["QueryOrderRIDList"] = null;
                if (Session["authenticated"] == null || (string)Session["authenticated"] != "true")
                {
                    FormsAuthentication.SignOut();
                    ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('請重新登入！');window.location='/staff/secret';</script>");
                    //Response.Redirect("/staff/secret");
                    return;
                }
                Session["authenticated"] = null;
            }
        }

        protected void SubmitPhoneQuery_Click(object sender, EventArgs e)
        {
            DoQuery("Phone");
        }

        protected void SubmitNameQuery_Click(object sender, EventArgs e)
        {
            DoQuery("Name");
        }

        protected void DoQuery(string queryStyle)
        {
            reserve.Clear();
            string PhoneQuery = PhoneTextBox.Text;
            string NameQuery = NameTextBox.Text;
            bool empty = true;

            string connectionString = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection Connection = new SqlConnection(connectionString);
            try
            {
                Connection.Open();

                string strSQL = "";
                SqlCommand myCommand = new SqlCommand(strSQL, Connection);
                if (queryStyle == "Phone")
                {
                    strSQL = @"SELECT RID, Name, Day,Class,Phone, DepartGrade,PayDay,TeamMember1,TeamMember2,SongName,SentName,IsPaid from [Reserve],[Song],[Team] WHERE Reserve.TID = Team.TID and Reserve.SID = Song.SID and Reserve.Phone LIKE @Phone order by RID";
                    myCommand = new SqlCommand(strSQL, Connection);
                    myCommand.Parameters.AddWithValue("@Phone", '%' + PhoneQuery + '%');
                }
                if (queryStyle == "Name")
                {
                    strSQL = @"SELECT RID, Name, Day,Class,Phone, DepartGrade,PayDay,TeamMember1,TeamMember2,SongName,SentName,IsPaid from [Reserve],[Song],[Team] WHERE Reserve.TID = Team.TID and Reserve.SID = Song.SID and Reserve.Name LIKE @Name order by RID";
                    myCommand = new SqlCommand(strSQL, Connection);
                    myCommand.Parameters.AddWithValue("@Name", '%' + NameQuery + '%');
                }
                RIDSessionList.Clear();

                using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    string RID;
                    string Phone;
                    string PayText;
                    string TimeText;
                    string Name;
                    string SentName;
                    while (myDataReader.Read())
                    {
                        empty = false;
                        RID = myDataReader["RID"].ToString();
                        Phone = myDataReader["Phone"].ToString();
                        RIDSessionList.Add(Convert.ToInt32(RID));
                        PayText = ((myDataReader["IsPaid"].ToString() == "True") ? "是" : "否");
                        TimeText = DateString[Convert.ToInt32(myDataReader["Day"].ToString()) - 1] + "\n" + ClassString[Convert.ToInt32(myDataReader["Class"].ToString()) - 2];
                        Name = myDataReader["Name"].ToString();
                        if (Name.Length > 10) Name = Name.Substring(0, 10) + "...";
                        SentName = myDataReader["SentName"].ToString();
                        if (SentName.Length > 10) SentName = SentName.Substring(0, 10) + "...";
                        reserve.Add(new Reserve(RID, Name, Phone, SentName, myDataReader["SongName"].ToString(), TimeText, PayText));
                    }
                    if (empty)
                    {
                        NotFoundLabel.Visible = true;
                        GridView1.DataSource = null;
                        GridView1.DataBind();
                        Session["QueryOrderRIDList"] = null;
                    }
                    else {
                        NotFoundLabel.Visible = false;
                        GridView1.DataSource = reserve;
                        GridView1.DataBind();
                        Session["QueryOrderRIDList"] = RIDSessionList;
                    }
                }

            }
            finally
            {
                Connection.Close();
            }
        }

        public class Reserve
        {
            public Reserve(string rID, string name, string phone, string sentName, string songName, string time, string isPaid)
            {
                訂單編號 = rID;
                傳情者 = name;
                手機 = phone;
                被傳情者 = sentName;
                傳情歌曲 = songName;
                傳情時間 = time;
                繳費狀況 = isPaid;
            }

            public string 訂單編號 { get; set; }
            public string 繳費狀況 { get; set; }
            public string 傳情者 { get; set; }
            public string 手機 { get; set; }
            public string 被傳情者 { get; set; }
            public string 傳情歌曲 { get; set; }
            public string 傳情時間 { get; set; }
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('已登出！');window.location='/staff/secret';</script>");
            //Response.Redirect("/staff/secret");
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Button BTN = (Button)e.CommandSource;
            GridViewRow myRow = (GridViewRow)BTN.NamingContainer;
            int RID = Convert.ToInt32(GridView1.Rows[myRow.DataItemIndex].Cells[2].Text);
            string Name = GridView1.Rows[myRow.DataItemIndex].Cells[4].Text;
            string Phone = GridView1.Rows[myRow.DataItemIndex].Cells[5].Text;

            if (e.CommandName == "PAY")
            {

                //GridView1.DataSource = null;
                //GridView1.DataBind();

                string connectionString = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
                SqlConnection Connection = new SqlConnection(connectionString);
                try
                {
                    Connection.Open();

                    String strSQL = @"UPDATE Reserve SET IsPaid = 1 Where RID = " + RID;
                    SqlCommand myCommand = new SqlCommand(strSQL, Connection);
                    try
                    {
                        myCommand.ExecuteNonQuery();
                    }
                    catch
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('寫入錯誤')", true);
                    }
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('訂單 " + RID + " 繳費成功！')", true);
                    GridView1.Rows[myRow.DataItemIndex].Cells[3].Text = "是";
                }
                catch
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('連線錯誤')", true);
                }
                finally
                {
                    Connection.Close();
                }
            }
            else if (e.CommandName == "DETAIL")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "OpenInfoModal", "OpenInfoModal(" + RID + ", '" + Name + "', '" + Phone + "'); ", true);
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[8].Text = e.Row.Cells[8].Text.Replace("\n", "<br/>");
        }

        protected void Print_Click(object sender, EventArgs e)
        {
            //***************************************************************************
            //*** for Exporting to a Excel file
            HSSFWorkbook workbook = new HSSFWorkbook();


            //== 新增試算表 Sheet名稱。使用 NPOI.SS.UserModel命名空間。(v.1.2.4版）
            ISheet u_sheet = (ISheet)workbook.CreateSheet("My Sheet_124");
            //***************************************************************************

            //=======微軟SDK文件的範本=======
            SqlConnection Conn = new SqlConnection();
            //----上面已經事先寫好 Imports System.Web.Configuration ----
            Conn.ConnectionString = WebConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            //----(連結資料庫)----

            SqlDataReader dr = null;
            SqlCommand cmd = new SqlCommand(@"Select RID as'訂單編號',Reserve.TID as '歌手編號',Team.TeamMember1+' '+Team.TeamMember2 as '歌手',
                                                Day as '星期',Class as '課堂', Song.SongName as '傳情歌曲', Category as '歌曲分類', 
                                                ClassName as '課堂名稱', Place as '傳情地點', GeneralLesson as '是否為通識課', 
                                                Name as '傳情人', DepartGrade as '傳情人系級',Phone as '傳情人手機', Email as '傳情人Email', 
                                                SentName as '被傳情人', SentDepartGrade as '被傳情人系級',SentPhone as '被傳情人手機', SentEmail as '被傳情人Email',
                                                PayDay as '繳費時間', SpecialRequest as '特殊需求', Remark as '備註', ReserveTime as '送出時間', IsPaid as '繳費與否'
                                                from Reserve,Team,Song 
                                                where Team.TID = Reserve.TID and Song.SID = Reserve.SID order by Reserve.RID", Conn);

            try
            {
                Conn.Open();   //---- 這時候才連結DB
                dr = cmd.ExecuteReader();  //---- 這時候執行SQL指令，取出資料

                //===============================================(start)
                //== 利用迴圈，把資料寫入 Excel各個儲存格裡面。

                IRow u_Row = u_sheet.CreateRow(0);
                for (int i = 0; i < dr.FieldCount; i++)
                {
                    u_Row.CreateCell(i).SetCellValue(dr.GetName(i));
                }

                int k = 1;
                while (dr.Read())
                {
                    //**** v.1.2.4版在此有很大的改變！！！請看 http://tonyqus.sinaapp.com/archives/73 
                    //**** 先建好一列（Row），才能去作格子（Cell）
                    u_Row = u_sheet.CreateRow(k);

                    for (int i = 0; i < dr.FieldCount; i++)
                    {   //-- FieldCount是指 DataReader每一列紀錄裡面，有幾個欄位。

                        //**********************************************************(start)
                        //**** v.1.2.4版在此有很大的改變！！！請看 http://tonyqus.sinaapp.com/archives/73  
                        u_Row.CreateCell(i).SetCellValue(dr.GetValue(i).ToString());  //== .CreateCell() 可設定為同一列(Row)的 [第幾個格子]
                        //**********************************************************(end)

                        //u_Row.CreateCell(i).SetCellType(CellType.STRING);
                        //設定每一個欄位（格子）的儲存格內容，如：字串。

                        //XXXXX 以下用法，在 v1.2.4版會有 Bug，只能列出每一列的「最後一格」的資料！！XXXXXXXXXX
                        //== 避免這樣的錯誤，請看 http://tonyqus.sinaapp.com/archives/73
                        //    u_sheet.CreateRow(k).CreateCell(i).SetCellValue(dr.GetValue(i).ToString());  //*** for Exporting to a Excel file (v.1.2.1版，正常)
                    }
                    k++;
                }
                //===============================================(end)
            }
            catch (Exception ex)   //---- 如果程式有錯誤或是例外狀況，將執行這一段
            {
                Response.Write("<b>Error Message----  </b>" + ex.ToString() + "<hr />");
            }
            finally
            {
                if (dr != null)
                {
                    cmd.Cancel();  //----關閉DataReader之前，一定要先「取消」SqlCommand
                    dr.Close();
                }
                if (Conn.State == ConnectionState.Open)
                {
                    Conn.Close();
                    Conn.Dispose();  //---- 一開始宣告有用到 New的,最後必須以 .Dispose()結束
                }
            }

            //***************************************************************************
            //*** for Exporting to a Excel file
            MemoryStream ms = new MemoryStream();  //==需要 System.IO命名空間
            workbook.Write(ms);

            //== Excel檔名，請寫在最後面 filename的地方
            DateTime serverTime = DateTime.Now;
            DateTime localTime = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(serverTime, TimeZoneInfo.Local.Id, "Taipei Standard Time");

            Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode("民歌傳情訂單", System.Text.Encoding.UTF8) + localTime.ToString(@"yyyy-MM-dd HHmm") + ".xls");
            Response.BinaryWrite(ms.ToArray());

            //== 釋放資源
            workbook = null;   //== C#為 null
            ms.Close();
            ms.Dispose();
        }
    }
}
