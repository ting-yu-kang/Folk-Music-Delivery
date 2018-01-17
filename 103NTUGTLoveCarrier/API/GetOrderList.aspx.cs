using NTUGTLoveCarrier.Class;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.API
{
    public partial class GetOrderList: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int RID = TryToParse(Request.Form["RID"]); /*post method*/
            string Phone = Request.Form["Phone"];
            string Name = Request.Form["Name"];

            if(RID <= 0 || Phone == null || Name == null) return;
            if(Session["QueryOrderRIDList"] == null) return;
            else
            {
                List<int> RIDSessionList = (List<int>)Session["QueryOrderRIDList"];
                if(!RIDSessionList.Contains(RID)) return;
            }
             
            string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection myConn = new SqlConnection(strConn);
            try
            {
                myConn.Open();
                String strSQL = @"SELECT Day,Class,TeamMember1,TeamMember2,SongName,Category,Place,ClassName,GeneralLesson,Name,DepartGrade,Phone,Email,SentName,SentDepartGrade,SentPhone,SentEmail,PayDay,SpecialRequest,Remark,IsPaid from [Reserve],[Song],[Team] WHERE Reserve.TID = Team.Tid and Reserve.SID = Song.SID and Reserve.RID = @RID and Reserve.Name = @Name and Reserve.Phone = @Phone";
                SqlCommand myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@RID", RID);
                myCommand.Parameters.AddWithValue("@Name", Name);
                myCommand.Parameters.AddWithValue("@Phone", Phone);

                FormContent Form = new FormContent();

                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    myDataReader.Read();
                    FormContent FormReply = new FormContent(
                        Convert.ToInt32(myDataReader["Day"].ToString()),
                        Convert.ToInt32(myDataReader["Class"].ToString()),
                        0,
                        myDataReader["TeamMember1"].ToString() + " " + myDataReader["TeamMember2"].ToString(),
                        0,
                        myDataReader["SongName"].ToString(),
                        myDataReader["Category"].ToString(),
                        myDataReader["Place"].ToString(),
                        myDataReader["ClassName"].ToString(),
                        Convert.ToInt32(myDataReader["GeneralLesson"].ToString()),
                        myDataReader["Name"].ToString(),
                        myDataReader["DepartGrade"].ToString(),
                        myDataReader["Phone"].ToString(),
                        myDataReader["Email"].ToString(),
                        myDataReader["SentName"].ToString(),
                        myDataReader["SentDepartGrade"].ToString(),
                        myDataReader["SentPhone"].ToString(),
                        myDataReader["SentEmail"].ToString(),
                        Convert.ToInt32(myDataReader["PayDay"].ToString()),
                        myDataReader["SpecialRequest"].ToString(),
                        myDataReader["Remark"].ToString(),
                        Convert.ToInt32(myDataReader["IsPaid"])
                    );

                    JavaScriptSerializer js = new JavaScriptSerializer();
                    string strJson = js.Serialize(FormReply);
                    Response.Write(strJson);
                }



                //Response.Clear();
                //Response.ContentType = "application/json; charset=utf-8";

                //Response.End();

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