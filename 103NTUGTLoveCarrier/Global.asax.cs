using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace NTUGTLoveCarrier
{
    public class Global: System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("index", "", "~/Default.aspx");
            routes.MapPageRoute("ChooseTeam", "team", "~/Pages/ChooseTeam.aspx");
            routes.MapPageRoute("ChooseTime", "time", "~/Pages/ChooseTime.aspx");
            routes.MapPageRoute("ChooseCategory", "category", "~/Pages/ChooseCategory.aspx");
            routes.MapPageRoute("songlist", "songlist", "~/Pages/SongList.aspx");
            routes.MapPageRoute("formfill", "formfill", "~/Pages/FormFill.aspx");
            routes.MapPageRoute("confirm", "confirm", "~/Pages/FormConfirm.aspx");
            routes.MapPageRoute("query", "query", "~/QueryOrder/QueryOrder.aspx");
            routes.MapPageRoute("querylist", "querylist", "~/QueryOrder/QueryList.aspx");
            routes.MapPageRoute("teamquery", "teamquery", "~/TeamArea/TeamQuery.aspx");
            routes.MapPageRoute("teamquerylist", "teamquerylist", "~/TeamArea/TeamQueryList.aspx");
            routes.MapPageRoute("api-orderlist", "api-orderlist", "~/API/GetOrderList.aspx");
            routes.MapPageRoute("api-teamdata", "api-teamdata", "~/API/GetTeamData.aspx");
            routes.MapPageRoute("api-teamorder", "api-teamorder", "~/API/GetTeamOrder.aspx");
            routes.MapPageRoute("api-timetable", "api-timetable", "~/API/GetTimeTable.aspx");
            routes.MapPageRoute("admin", "staff/secret", "~/OrderSystem/DetailListAuthenticate.aspx");
            routes.MapPageRoute("adminlist", "staff/secretlist", "~/OrderSystem/DetailList.aspx");
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}