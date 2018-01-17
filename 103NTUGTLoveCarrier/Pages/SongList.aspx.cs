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
    public partial class SongList: System.Web.UI.Page
    {
        private string SubmitType;
        private string CategorySelected = "";
        private int DateSelected = -1;
        private int ClassSelected = -1;
        private string[] CategoryName = new string[] { "Friend", "Lover", "Prank", "Teacher", "Other" };
        private string[] CategoryStyle = new string[] { "primary", "danger", "warning", "success", "info" };
        private string[] DateString = new string[] { "All Datess", "5 / 2(Mon.)", "5 / 3(Tue.)", "5 / 4(Wed.)", "5 / 5(Thu.)", "5 / 6(Fri.)" };
        private string[] ClassString = new string[] { "All Time", "", "2(10:00-10:20)", "3(11:10-11:20)", "4(12:10-12:20)", "5(13:10-13:20)", "6(14:10-14:20)", "7(15:10-15:30)", "8(16:20-16:30)", "9(17:20-17:30)" };

        protected void Page_Load(object sender, EventArgs e)
        {
            SubmitType = Page.Request.Form["SubmitType"];
            if(SubmitType == "Time")
            {
                DateList.SelectedValue = Page.Request.Form["DateList"];
                ClassList.SelectedValue = Page.Request.Form["ClassList"];
                Submit_Click(null, EventArgs.Empty);
                ClientScript.RegisterStartupScript(GetType(), "setPanelButton", "<script>setPanelButton('all');</script>");
            }
            else if(SubmitType == "Category")
            {
                DateList.SelectedValue = "0";
                ClassList.SelectedValue = "0";
                CategorySelected = Page.Request.Form["CategoryList"];
                Submit_Click(null, EventArgs.Empty);
                ClientScript.RegisterStartupScript(GetType(), "setPanelButton", "<script>setPanelButton('" + CategorySelected + "');</script>");
            }
            else if(!IsPostBack)
            {
                DateList.SelectedValue = "0";
                ClassList.SelectedValue = "0";
                Submit_Click(null, EventArgs.Empty);
            }
            else
            {
                DateLabel.Text = "All Datess";
                ClassLabel.Text = "All Time";
                ClientScript.RegisterStartupScript(GetType(), "setPanelButton", "<script>setPanelButton('all');</script>");
            }
            return;
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            //System.Threading.Thread.Sleep(2000);
            //if (DateSelected == Convert.ToInt32(DateList.SelectedValue) && ClassSelected == Convert.ToInt32(ClassList.SelectedValue)) return;

            DateSelected = Convert.ToInt32(DateList.SelectedValue);
            ClassSelected = Convert.ToInt32(ClassList.SelectedValue);

            if(DateSelected < 0 || ClassSelected < 0 || DateSelected > 5 || ClassSelected > 9 || ClassSelected == 1)
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('錯誤，請重新選擇');window.location='/songlist';</script>");
                //Response.Redirect("/songlist");
                return;
            }
            DateLabel.Text = DateString[DateSelected];
            ClassLabel.Text = ClassString[ClassSelected];
            //DayList.SelectedValue = Page.Request.Form["DayList"];
            //ClassList.SelectedValue = Page.Request.Form["ClassList"];

            StringBuilder output = new StringBuilder();
            string SongName;
            string TeamMember;
            string Category;
            string CategoryClass;
            string CategoryParse;
            string TeamID;
            string SongID;
            string OriginalPlayer;

            string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection myConn = new SqlConnection(strConn);
            try
            {
                myConn.Open();
                String strSQL;
                SqlCommand myCommand;
                //if (DateSelected != 0 && ClassSelected != 0)
                //{
                //    strSQL = @"SELECT SongCount from [SongTotal] WHERE Day = @Date and Class = @Class";
                //    myCommand = new SqlCommand(strSQL, myConn);
                //    myCommand.Parameters.AddWithValue("@Date", DateSelected);
                //    myCommand.Parameters.AddWithValue("@Class", ClassSelected);
                //    using (SqlDataReader myDataReader = myCommand.ExecuteReader())
                //    {
                //        myDataReader.Read();
                //        if (Convert.ToInt32(myDataReader[0].ToString()) >= 10)
                //        {
                //            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "", "alert('本時段可選歌數已滿，請重新選擇...')", true);
                //            Literal1.Text = "";
                //            return;
                //        }
                //    }
                //}

                strSQL = @"SELECT distinct SongName,TeamMember1,TeamMember2,Team.TID,Song.SID, Category, OriginalPlayer
                    FROM [Time],[Play],[Team],[Song] 
                    WHERE";
                if(DateSelected != 0 && ClassSelected != 0) strSQL += " not exists(SELECT * from Reserve where Time.Day=Reserve.Day and Time.CLass=Reserve.Class and Team.TID=Reserve.TID) and";
                strSQL += " Time.TID = Team.TID and Play.TID = Time.TID and Play.SID = Song.SID";
                if(DateSelected != 0) { strSQL += " and Time.Day = @DateSelected"; }
                if(ClassSelected != 0) { strSQL += " and Time.Class = @ClassSelected"; }

                myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@DateSelected", DateSelected);
                myCommand.Parameters.AddWithValue("@ClassSelected", ClassSelected);
                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while(myDataReader.Read())
                    {
                        SongName = myDataReader[0].ToString();
                        TeamMember = myDataReader[1].ToString();
                        if(myDataReader[2].ToString() != null)
                            TeamMember += " " + myDataReader[2].ToString();
                        TeamID = myDataReader[3].ToString();
                        SongID = myDataReader[4].ToString();
                        Category = myDataReader[5].ToString();
                        OriginalPlayer = myDataReader["OriginalPlayer"].ToString();
                        CategoryClass = "";
                        CategoryParse = "";
                        for(int i = 0 ; i < Category.Length ; i++)
                        {
                            CategoryClass += " _c" + Category[i];
                            CategoryParse += CategoryName[Category[i] - '1'] + " ";
                        }
                        output.Append("<div class=\"col-lg-5 col-md-6 col-sm-8 col-ms-10 songlist found" + CategoryClass + "\">");
                        output.Append("<div class=\"panel panel-default\">");
                        output.Append("<div class=\"panel-heading clickable\">");
                        if(ClassSelected != 0 && DateSelected != 0)
                            output.AppendFormat("<button class=\"btn btn-primary btn-md pull-right order\" onclick=\"return submitConfirm('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}');\">Choose<i class=\"glyphicon glyphicon-chevron-right\"></i></button>", SongName, TeamMember, DateString[DateSelected], ClassString[ClassSelected], CategoryParse, SongID, TeamID, DateSelected, ClassSelected);
                        else
                            output.AppendFormat("<button class=\"btn btn-primary btn-md pull-right order\" onclick=\"return OpenTimeModel('{0}','{1}','{2}','{3}','{4}');\">Choose<i class=\"glyphicon glyphicon-chevron-right\"></i></button>", SongName, TeamMember, CategoryParse, SongID, TeamID);
                        output.Append("<h4 class=\"pull-left\">");
                        output.Append("<i class=\"glyphicon glyphicon-plus\"></i>");
                        output.Append(" #" + SongID + " " +  SongName);
                        output.Append("</h4>");
                        output.Append("<div class=\"clearfix\"></div>");
                        output.Append("</div>");
                        output.Append("<div class=\"panel-body\">");
                        output.Append("<div class=\"col-sm-5 col-ms-5 image-div\">");
                        output.Append("<a href=\"/team?tid=" + TeamID + "\" target=\"_blank\"><img alt=\"image\" class=\"img-responsive\" src=\"/images/Players/" + TeamID + "-1.jpg\" /></a>");
                        output.Append("</div>");
                        output.Append("<div class=\"col-sm-7 col-ms-7 content-div\">");
                        output.Append("<h5>(" + OriginalPlayer + ")</h5>");
                        output.Append("<h3>#" + SongID + " " + SongName + "</h3>");
                        output.Append("<h4>No. " + TeamID + " " + TeamMember + "</h4>");
                        if(ClassSelected != 0 && DateSelected != 0)
                        {
                            output.AppendFormat("<p class=\"time\">{0} / {1}</p>", DateString[DateSelected], ClassString[ClassSelected]);
                        }
                        output.Append("<div class=\"categorylabel\">");
                        for(int i = 0 ; i < Category.Length ; i++)
                        {
                            output.AppendFormat("<h4 class=\"category\"><span class=\"label label-{0}\">{1}</span></h4>", CategoryStyle[Category[i] - '1'], CategoryName[Category[i] - '1']);
                        }
                        output.Append("</div>");
                        output.AppendFormat("<button class=\"btn btn-primary btn-md timetable\" onclick=\"return OpenTimeModel('{0}','{1}','{2}','{3}','{4}');\"><i class=\"glyphicon glyphicon-calendar\"></i>Schedule</button>", SongName, TeamMember, CategoryParse, SongID, TeamID);
                        output.Append("</div>");
                        output.Append("</div>");
                        output.Append("</div>");
                        output.Append("</div>");
                    }

                    Literal1.Text = output.ToString();
                }
            }
            catch
            {
                ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('連線錯誤...');window.location='/songlist';</script>");
                //Response.Redirect("/songlist");
            }
            finally
            {
                myConn.Close();
            }
        }

        //protected void Submit_CategoryClick(object sender, EventArgs e)
        //{
        //    CategorySelected = Convert.ToInt32(CategoryList.SelectedValue);
        //    if(CategorySelected < 1 || CategorySelected > 5)
        //    {
        //        ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('錯誤，請重新選擇');window.location='/category';</script>");
        //        return;
        //    }

        //    StringBuilder output = new StringBuilder();
        //    string SongName = "";
        //    string TeamMember = "";
        //    string Category = "";
        //    string CategoryClass = "";
        //    string CategoryParse = "";
        //    string TeamID = "";
        //    string SongID = "";
        //    //string Date = "";
        //    //string Class = "";
        //    bool isEmpty = true;

        //    string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
        //    SqlConnection myConn = new SqlConnection(strConn);
        //    try
        //    {
        //        myConn.Open();

        //        string strSQL = @"SELECT distinct SongName,TeamMember1,TeamMember2,Team.TID,Song.SID,Song.Category
        //            FROM [Time],[Play],[Team],[Song] 
        //            WHERE not exists(SELECT * from Reserve where Time.Day=Reserve.Day and Time.CLass=Reserve.Class and Team.TID=Reserve.TID) 
        //            and Song.Category LIKE '%" + CategorySelected +
        //            "%' and Time.TID = Team.TID and Play.TID = Time.TID and Play.SID = Song.SID";
        //        SqlCommand myCommand = new SqlCommand(strSQL, myConn);

        //        using(SqlDataReader myDataReader = myCommand.ExecuteReader())
        //        {
        //            while(myDataReader.Read())
        //            {
        //                isEmpty = false;

        //                SongName = myDataReader[0].ToString();
        //                TeamMember = myDataReader[1].ToString();
        //                if(myDataReader[2].ToString() != null)
        //                    TeamMember += " " + myDataReader[2].ToString();
        //                TeamID = myDataReader[3].ToString();
        //                SongID = myDataReader[4].ToString();
        //                Category = myDataReader[5].ToString();

        //                CategoryClass = "";
        //                CategoryParse = "";
        //                for(int i = 0 ; i < Category.Length ; i++)
        //                {
        //                    CategoryClass += " _c" + Category[i];
        //                    CategoryParse += CategoryName[Category[i] - '1'] + " ";
        //                }
        //                output.Append("<div class=\"col-lg-5 col-md-6 col-sm-8 songlist found" + CategoryClass + "\">");
        //                output.Append("<div class=\"panel panel-default\">");
        //                output.Append("<div class=\"panel-heading clickable\">");
        //                output.AppendFormat("<button class=\"btn btn-primary btn-md pull-right\" onclick=\"return OpenTimeModel('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}');\">時間表<i class=\"glyphicon glyphicon-chevron-right\"></i></button>", SongName, TeamMember, "", "", CategoryParse, SongID, TeamID, "", "");
        //                output.Append("<h4 class=\"pull-left\">");
        //                output.Append("<i class=\"glyphicon glyphicon-plus\"></i>");
        //                output.Append("&nbsp;" + SongName);
        //                output.Append("</h4>");
        //                output.Append("<div class=\"clearfix\"></div>");
        //                output.Append("</div>");
        //                output.Append("<div class=\"panel-body\">");
        //                output.Append("<div class=\"col-sm-5 image-div\">");
        //                output.Append("<img alt=\"image\" class=\"img-responsive\" src=\"/images/Players/" + TeamID + ".jpg\" />");
        //                output.Append("</div>");
        //                output.Append("<div class=\"col-sm-7 content-div\">");
        //                output.Append("<h3>" + SongName + "</h3>");
        //                output.Append("<h4>" + TeamMember + "</h4>");
        //                output.Append("<div>");
        //                for(int i = 0 ; i < Category.Length ; i++)
        //                {
        //                    output.AppendFormat("<h4 class=\"category\"><span class=\"label label-{0}\">{1}</span></h4>", CategoryStyle[Category[i] - '1'], CategoryName[Category[i] - '1']);
        //                }
        //                output.Append("</div>");
        //                //output.AppendFormat("<p class=\"time\">{0} / {1}</p>", DateString[Dates[0][0] - '1'], ClassString[Classes[0][0] - '2']);
        //                output.Append("</div>");
        //                output.Append("</div>");
        //                output.Append("</div>");
        //                output.Append("</div>");
        //            }
        //        }
        //        Literal1.Text = output.ToString();
        //        if(isEmpty)
        //        {
        //            ClientScript.RegisterStartupScript(GetType(), "message", "<script>alert('查無歌曲，請重新選擇...');window.location='/category';</script>");
        //            return;
        //        }

        //    }
        //    finally
        //    {
        //        myConn.Close();
        //    }
        //}
    }
}