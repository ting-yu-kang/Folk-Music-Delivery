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
    public partial class FormFill: System.Web.UI.Page
    {
        private string[] DateString = new string[] { "5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)" };
        private string[] ClassString = new string[] { "二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)" };
        private string[] CategoryName = new string[] { "友情", "愛情", "銃康", "師長", "另類" };

        int Date = -1;
        int Class = -1;
        int Team = -1;
        int Song = -1;
        string Category;

        protected override void OnError(EventArgs e)
        {
            base.OnError(e);

            Exception ex = Server.GetLastError();

            if(ex is HttpRequestValidationException)
            {
                Server.ClearError();

                string js = "<script type='text/javascript'>" +
                            "alert('表單內容發生錯誤，可能其中包含危險字元，若問題持續發生，請洽吉他社工作人員！');" +
                            "window.location='/songlist';" +
                            "</script>";

                Response.Write(js);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            return;
            if (!IsPostBack)
            {
                Date = TryToParse(Request.Form["Date"]);
                Class = TryToParse(Request.Form["Class"]);
                Team = TryToParse(Request.Form["Team"]);
                Song = TryToParse(Request.Form["Song"]);

                if(Date < 1 || Date > 5 || Class < 2 || Class > 9 || Team <= 0 || Song <= 0)
                {
                    ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('錯誤，請重新選擇');window.location='/songlist';</script>");
                    Response.Redirect("/songlist");
                    return;
                }
                DateHd.Value = Convert.ToString(Date);
                ClassHd.Value = Convert.ToString(Class);
                TeamHd.Value = Convert.ToString(Team);
                SongHd.Value = Convert.ToString(Song);

                DateLabel.Text = DateString[Date - 1];
                ClassLabel.Text = ClassString[Class - 2];

                string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
                SqlConnection myConn = new SqlConnection(strConn);
                try
                {
                    myConn.Open();
                    String strSQL = @"SELECT TeamMember1,TeamMember2 FROM [Team] WHERE Team.TID = @Team";
                    SqlCommand myCommand = new SqlCommand(strSQL, myConn);
                    myCommand.Parameters.AddWithValue("@Team", Team);
                    using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                    {
                        while(myDataReader.Read())
                        {
                            TeamLabel.Text = myDataReader[0].ToString() + " " + myDataReader[1].ToString();
                        }
                    }
                    strSQL = @"SELECT SongName, Category FROM [Song] WHERE Song.SID = @Song";
                    myCommand = new SqlCommand(strSQL, myConn);
                    myCommand.Parameters.AddWithValue("@Song", Song);
                    using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                    {
                        while(myDataReader.Read())
                        {
                            SongLabel.Text = myDataReader[0].ToString();
                            Category = myDataReader[1].ToString();
                            CategoryLabel.Text = "";
                            for(int i = 0 ; i < Category.Length ; i++)
                            {
                                CategoryLabel.Text += CategoryName[Category[i] - '1'] + " ";
                            }
                        }
                    }
                }
                catch
                {
                    ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('連線錯誤');window.location='/songlist';</script>");
                    //Response.Redirect("/songlist");
                    return;
                }
                finally
                {
                    myConn.Close();
                }
            }
            else //postback
            {
                
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            /*check if repeat*/
            bool IsReserved = false;
            bool IsFull = false;
            string connectionString = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection Connection = new SqlConnection(connectionString);
            try
            {
                Connection.Open();
                String strSQL = @"SELECT count(1) from [Reserve] WHERE Reserve.Day = @Date and Reserve.Class = @Class and Reserve.TID = @Team";
                SqlCommand myCommand = new SqlCommand(strSQL, Connection);
                myCommand.Parameters.AddWithValue("@Date", Convert.ToInt32(DateHd.Value));
                myCommand.Parameters.AddWithValue("@Class", Convert.ToInt32(ClassHd.Value));
                myCommand.Parameters.AddWithValue("@Team", Convert.ToInt32(TeamHd.Value));
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
                //myCommand.Parameters.AddWithValue("@Date", Convert.ToInt32(DateHd.Value));
                //myCommand.Parameters.AddWithValue("@Class", Convert.ToInt32(ClassHd.Value));
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
            }
            catch(Exception ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('連線錯誤');window.location='/songlist';</script>");
                //Response.Redirect("/songlist");
                return;
            }
            finally
            {
                Connection.Close();
            }

            /*Fill Session to Send*/
            if(!IsReserved && !IsFull)
            {
                bool isRemark = false;
                string SpecialRequestText = "";
                for(int i = 0 ; i < SpecialRequestCheckBox.Items.Count ; i++)
                {
                    if(SpecialRequestCheckBox.Items[i].Selected)
                    {
                        isRemark = true;
                        SpecialRequestText += "[" + SpecialRequestCheckBox.Items[i].Value + "] ";
                    }
                }
                if(!isRemark) SpecialRequestText = "無";

                FormContent FormReply = new FormContent(
                    Convert.ToInt32(DateHd.Value),
                    Convert.ToInt32(ClassHd.Value),
                    Convert.ToInt32(TeamHd.Value),
                    TeamLabel.Text,
                    Convert.ToInt32(SongHd.Value),
                    SongLabel.Text,
                    CategoryLabel.Text,
                    PlaceTextBox.Text,
                    ClassNameTextBox.Text,
                    Convert.ToInt32(GeneralLessonDropDownList.SelectedValue),
                    NameTextBox.Text,
                    DepartmentGradeTextBox.Text,
                    PhoneTextBox.Text,
                    EmailTextBox.Text,
                    SentNameTextBox.Text,
                    SentDepartmentGradeTextBox.Text,
                    SentPhoneTextBox.Text,
                    SentEmailTextBox.Text,
                    Convert.ToInt32(PayDayDropDownList.SelectedValue),
                    SpecialRequestText,
                    RemarkTextBox.Text,
                    0
                );
                Session["FormReply"] = FormReply;
                Response.Redirect("/confirm");
            }
            return;
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
