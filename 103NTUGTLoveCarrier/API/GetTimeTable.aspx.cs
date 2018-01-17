using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NTUGTLoveCarrier.API
{
    public partial class GetTimeTable: System.Web.UI.Page
    {
        string[] ClassArray = new string[] { "2", "3", "4", "5", "6", "7", "8", "9" };
        protected void Page_Load(object sender, EventArgs e)
        {
            int TID = TryToParse(Request.Form["TID"]); /*post method*/
            //int TID = TryToParse(Request.QueryString["TID"]); /*get method*/
            if(TID <= 0) return;

            TimeTable timeTable = new TimeTable();
            int Date, Class;

            string strConn = ConfigurationManager.ConnectionStrings["LoveCarrierConnectionString"].ConnectionString;
            SqlConnection myConn = new SqlConnection(strConn);
            try
            {
                myConn.Open();
                /*load timetable and count total song*/
                //string strSQL = @"SELECT Time.Day, Time.Class, SongCount FROM Time, SongTotal Where Time.TID = @TID and Time.Day = SongTotal.Day and Time.Class = SongTotal.Class";
                string strSQL = @"SELECT Time.Day, Time.Class FROM Time Where Time.TID = @TID";
                SqlCommand myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@TID", TID);
                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while(myDataReader.Read())
                    {
                        Date = Convert.ToInt32(myDataReader["Day"].ToString());
                        Class = Convert.ToInt32(myDataReader["Class"].ToString());
                        //SongCount = Convert.ToInt32(myDataReader["SongCount"].ToString());

                        //if(SongCount >= 10)
                        //    timeTable.schedule[Date - 1, Class - 2] = 3;
                        //else
                            timeTable.schedule[Date - 1, Class - 2] = 1;
                    }
                }

                /*check whether reserved*/
                strSQL = @"SELECT Day,Class,count (*) FROM Reserve Where Reserve.TID = @TID group by day,class";
                myCommand = new SqlCommand(strSQL, myConn);
                myCommand.Parameters.AddWithValue("@TID", TID);
                using(SqlDataReader myDataReader = myCommand.ExecuteReader())
                {
                    while(myDataReader.Read())
                    {
                        Date = Convert.ToInt32(myDataReader[0].ToString());
                        Class = Convert.ToInt32(myDataReader[1].ToString());
                        timeTable.schedule[Date - 1, Class - 2] = 2;
                    }
                }

                /*create Json*/
                StringBuilder strJson = new StringBuilder();
                char[] colText = new char[5];

                strJson.Append("{\"TimeTable\":[");
                for(int i = 0 ; i < 8 ; i++)
                {

                    for(int j = 0 ; j < 5 ; j++)
                    {
                        if(timeTable.schedule[j, i] == 1) colText[j] = 'V';
                        else if(timeTable.schedule[j, i] == 2) colText[j] = '▲';
                        //else if(timeTable.schedule[j, i] == 3) colText[j] = 'X';
                        else colText[j] = ' ';
                    }
                    strJson.AppendFormat("[\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\"]", i + 2, colText[0], colText[1], colText[2], colText[3], colText[4]);
                    if(i != 7)
                    {
                        strJson.AppendFormat(",");
                    }
                }
                strJson.Append("]}");

                //Response.Clear();
                //Response.ContentType = "application/json; charset=utf-8";
                Response.Write(strJson);
                //Response.End();

            }
            finally
            {

                myConn.Close();

            }
        }

        public class TimeTable
        {
            public int[,] schedule = new int[5, 8];
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