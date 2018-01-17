using NTUGTLoveCarrier.Class;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.Pages
{
    public partial class FormConfirm: System.Web.UI.Page
    {
        private string[] DateString = new string[] { "5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)" };
        private string[] ClassString = new string[] { "二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)" };
        private string[] ReserveString = new string[] { "4/25(一)", "4/26(二)", "4/27(三)", "4/28(四)", "4/29(五)" };
        private string[] GereralLessonString = new string[] { "否", "是", "不知道" };
        FormContent FormReply;
        Literal AlertMsg = new Literal();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if(Session["FormReply"] == null)
                {
                    ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('錯誤，請重新選擇');window.location='/songlist';</script>");
                    Response.Redirect("/songlist");
                    return;
                }
                FormReply = (FormContent)Session["FormReply"];
                if(FormReply == null) { return; }
                DateLabel.Text = "傳情日期：" + DateString[FormReply.Date - 1];
                ClassLabel.Text = "傳情時間：" + ClassString[FormReply.Class - 2];
                TeamLabel.Text = "傳情歌手：" + FormReply.TeamMemberName;
                SongLabel.Text = "傳情歌曲：" + FormReply.SongName;
                CategoryLabel.Text = "歌曲分類：" + FormReply.Category;
                PlaceLabel.Text = "傳情地點：" + FormReply.Place;
                ClassNameLabel.Text = "課堂名稱：" + FormReply.ClassName;
                GeneralLessonLabel.Text = "是否為通識課：" + GereralLessonString[FormReply.GeneralLesson];
                NameLabel.Text = "傳情者姓名：" + FormReply.Name;
                DepartmentGradeLabel.Text = "傳情者系級：" + FormReply.DepartGrade;
                PhoneLabel.Text = "傳情者手機：" + FormReply.Phone;
                EmailLabel.Text = "傳情者Email：" + FormReply.Email;
                SentNameLabel.Text = "被傳情者姓名：" + FormReply.SentName;
                SentDepartmentGradeLabel.Text = "被傳情者系級：" + FormReply.SentDepartGrade;
                SentPhoneLabel.Text = "被傳情者手機：" + FormReply.SentPhone;
                SentEmailLabel.Text = "被傳情者Email：" + FormReply.SentEmail;
                PayDayLabel.Text = "前往攤位繳費時間：" + ReserveString[FormReply.PayDay - 1];
                SpecialRequestLabel.Text = "特殊需求：<br/>" + FormReply.SpecialRequest;
                RemarkLabel.Text = "備註：<br/>" + FormReply.Remark.Replace(Environment.NewLine, "<br />");
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if(Session["FormReply"] == null)
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('錯誤，請重新選擇');window.location='/songlist';</script>");
                Response.Redirect("/songlist");
                return;
            }
            FormReply = (FormContent)Session["FormReply"];

            int Date = FormReply.Date;
            int Class = FormReply.Class;
            int Team = FormReply.Team;
            int Song = FormReply.Song;
            string Place = FormReply.Place;
            string ClassName = FormReply.ClassName;
            int GeneralLesson = FormReply.GeneralLesson;
            string Name = FormReply.Name;
            string DepartGrade = FormReply.DepartGrade;
            string Phone = FormReply.Phone;
            string Email = FormReply.Email;
            string SentName = FormReply.SentName;
            string SentDepartGrade = FormReply.SentDepartGrade;
            string SentPhone = FormReply.SentPhone;
            string SentEmail = FormReply.SentEmail;
            int PayDay = FormReply.PayDay;
            string SpecialRequest = FormReply.SpecialRequest;
            string Remark = FormReply.Remark;
            bool IsReserved = false;
            bool IsFull = false;
            Session.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection Connection = new SqlConnection(connectionString);
            try
            {
                Connection.Open();

                String strSQL = @"SELECT count(1) from [Reserve] WHERE Reserve.Day = @Date and Reserve.Class = @Class and Reserve.TID = @Team";
                SqlCommand myCommand = new SqlCommand(strSQL, Connection);
                myCommand.Parameters.AddWithValue("@Date", Date);
                myCommand.Parameters.AddWithValue("@Class", Class);
                myCommand.Parameters.AddWithValue("@Team", Team);
                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    myDataReader.Read();
                    if(myDataReader[0].ToString() != "0") IsReserved = true;
                }
                if(IsReserved)
                {
                    ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('本時段您指定的傳情歌手已被他人選歌，請重新選擇...');window.location='/songlist';</script>");
                    //Response.Redirect("/songlist");
                    return;
                }

                //strSQL = @"SELECT SongCount from [SongTotal] WHERE Day = @Date and Class = @Class";
                //myCommand = new SqlCommand(strSQL, Connection);
                //myCommand.Parameters.AddWithValue("@Date", Date);
                //myCommand.Parameters.AddWithValue("@Class", Class);
                //using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                //{
                //    myDataReader.Read();
                //    if(Convert.ToInt32(myDataReader[0].ToString()) >= 10) IsFull = true;
                //}
                //if(IsFull)
                //{
                //    ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('本時段可選歌數已滿，請重新選擇...');window.location='/songlist';</script>");
                //    //Response.Redirect("/songlist");
                //    return;
                //}

                else if(!IsFull && !IsReserved)
                {
                    strSQL = "INSERT INTO Reserve ([TID],[Day],[Class],[SID],[Place],[ClassName],[GeneralLesson],[Name],[DepartGrade],[Phone],[Email],[SentName],[SentDepartGrade],[SentPhone],[SentEmail],[PayDay],[SpecialRequest],[Remark]) VALUES (@TID, @Day, @Class, @SID, @Place, @ClassName, @GeneralLesson, @Name, @DepartGrade, @Phone, @Email, @SentName, @SentDepartGrade,@SentPhone,@SentEmail,@PayDay,@SpecialRequest,@Remark)";
                    myCommand = new SqlCommand(strSQL, Connection);
                    myCommand.Parameters.AddWithValue("@TID", Team);
                    myCommand.Parameters.AddWithValue("@Day", Date);
                    myCommand.Parameters.AddWithValue("@Class", Class);
                    myCommand.Parameters.AddWithValue("@SID", Song);
                    myCommand.Parameters.AddWithValue("@Place", Place);
                    myCommand.Parameters.AddWithValue("@ClassName", ClassName);
                    myCommand.Parameters.AddWithValue("@GeneralLesson", GeneralLesson);
                    myCommand.Parameters.AddWithValue("@Name", Name);
                    myCommand.Parameters.AddWithValue("@DepartGrade", DepartGrade);
                    myCommand.Parameters.AddWithValue("@Phone", Phone);
                    myCommand.Parameters.AddWithValue("@Email", Email);
                    myCommand.Parameters.AddWithValue("@SentName", SentName);
                    myCommand.Parameters.AddWithValue("@SentDepartGrade", SentDepartGrade);
                    myCommand.Parameters.AddWithValue("@SentPhone", SentPhone);
                    myCommand.Parameters.AddWithValue("@SentEmail", SentEmail);
                    myCommand.Parameters.AddWithValue("@PayDay", PayDay);
                    myCommand.Parameters.AddWithValue("@SpecialRequest", SpecialRequest);
                    myCommand.Parameters.AddWithValue("@Remark", Remark);

                    //String strSQL2 = @"UPDATE [SongTotal] SET SongCount+=1 WHERE Day = @Date and Class = @Class";
                    //SqlCommand myCommand2 = new SqlCommand(strSQL2, Connection);
                    //myCommand2.Parameters.AddWithValue("@Date", Date);
                    //myCommand2.Parameters.AddWithValue("@Class", Class);
                    try
                    {
                        myCommand.ExecuteNonQuery();
                        //myCommand2.ExecuteNonQuery();
                    }
                    catch(Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('資料庫錯誤');window.location='/songlist';", true);
                        //Response.Redirect("/songlist");
                        return;
                    }
                    AlertMsg.Text = "<script language='javascript'>Congrats();</script>";
                    this.Page.Controls.Add(AlertMsg);
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('連線錯誤');window.location='/songlist';", true);
                //Response.Redirect("/songlist");
                return;
            }
            finally
            {
                Connection.Close();
            }
        }
    }
}
