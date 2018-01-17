<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SongList.aspx.cs" Inherits="NTUGTLoveCarrier.Pages.SongList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Song List</title>

    <link href="/images/icon.jpg" rel="SHORTCUT ICON" />
    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <link href="/CSS/bootstrap_ms.css" rel="stylesheet" />
    <link rel="stylesheet" href="/Content/font-awesome/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/HoldOn.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/SongListStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/footerStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/NavBarStyle.css" type="text/css" />

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="/Scripts/bootbox.min.js"></script>
    <script src="/Scripts/Custom/SongListScript.js"></script>
    <script src="/Scripts/HoldOn.min.js"></script>

    <style>
        body {
            padding-top: 50px;
        }
    </style>
</head>
<body onload="rebinding();">
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header page-scroll">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="https://www.facebook.com/ntuguitar/" target="_parent">NTU Guitar 2016</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-music"></i>&nbsp;Menu&nbsp;<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="/time"><i class="fa fa-clock-o"></i>&nbsp;Time</a></li>
                                <li><a href="/category"><i class="fa fa-sitemap"></i>&nbsp;Category</a></li>
                                <li><a href="/team"><i class="fa fa-music"></i>&nbsp;Guitarist</a></li>
                                <li class="divider"></li>
                                <li><a href="/query"><i class="fa fa-book"></i>&nbsp;Query</a></li>
                            </ul>
                        </li>
                        <li><a href="/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                        <%--<li><a href="https://www.facebook.com/ntuguitarlove/" target="_parent"><i class="fa fa-facebook-square"></i>&nbsp;Facebook</a></li>--%>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Navigation -->
        <div id="songContent">
            <div class="col-sm-6">
                <h1 class="col-xs-12 title">Song List</h1>
            </div>
            <div class="col-sm-6">
                <div class="row toggle">
                    <div class="btn-group pull-right">
                        <button type="button" class="btn btn-primary btn-toggle" data-target="on"><span class="glyphicon glyphicon-plus"></span>&nbsp;Expand</button>
                        <button type="button" class="btn btn-danger btn-toggle" data-target="off"><span class="glyphicon glyphicon-minus"></span>&nbsp;Collapse</button>
                    </div>
                </div>

                <div class="row category-filter">
                    <div class="btn-group pull-right">
                        <button type="button" class="btn btn-primary btn-filter c1" data-target="_c1">Friend</button>
                        <button type="button" class="btn btn-danger btn-filter c2" data-target="_c2">Lover</button>
                        <button type="button" class="btn btn-warning btn-filter c3" data-target="_c3">Prank</button>
                        <button type="button" class="btn btn-success btn-filter c4" data-target="_c4">Teacher</button>
                        <button type="button" class="btn btn-info btn-filter c5" data-target="_c5">Other</button>
                        <button type="button" class="btn btn-default btn-filter active all" data-target="_all">All</button>
                    </div>
                </div>
            </div>

            <hr class="divider up" />

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="row timebar">
                        <div class="col-xs-12">
                            <h4 style="display: inline-block">
                                <asp:Label ID="DateLabel" class="label date label-default" runat="server" Text=""></asp:Label>
                            </h4>
                            <h4 style="display: inline-block">
                                <asp:Label ID="ClassLabel" class="label class label-default" runat="server" Text=""></asp:Label>
                            </h4>
                            <h4 style="display: inline-block">
                                <asp:Label ID="CategoryLabel" class="label category label-success" runat="server" Text=""></asp:Label>
                            </h4>
                        </div>
                        <div class="col-xs-12">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ChooseTimeModel"><span class="glyphicon glyphicon-time"></span>Choose Time</button>
                        </div>
                    </div>

                    <div class="row songlists">
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>

                        <%--  <!-- Begin Listing -->
                    <div class="col-lg-5 col-md-6 col-sm-8 songlist found">
                        <div class="panel panel-default">
                            <div class="panel-heading clickable">
                                <button class="btn btn-primary btn-md pull-right" onclick="return submitConfirm('當你孤單你會想起誰','謝承諭 趙家倫','5/2(一)','二下課(10:00-10:20)','愛情 銃康 ','20','7','1','2','23');">選歌去<i class="glyphicon glyphicon-chevron-right"></i></button>
                                <h4 class="pull-left">
                                    <i class="glyphicon glyphicon-plus"></i>
                                    少年少年少年少年
                                </h4>
                                <div class="clearfix"></div>
                            </div>
                            <div class="panel-body">
                                <div class="col-sm-5 image-div">
                                    <img alt="image" class="img-responsive" src="/images/Players/1.jpg" />
                                </div>
                                <div class="col-sm-7 content-div">
                                    <h3>少年少年少年少年</h3>
                                    <h4>黃廷瑀 張達元</h4>
                                    <div>
                                        <h4 class="category"><span class="label label-warning">友情</span></h4>
                                        <h4 class="category"><span class="label label-primary">友情</span></h4>
                                        <h4 class="category"><span class="label label-danger">友情</span></h4>
                                        <h4 class="category"><span class="label label-success">友情</span></h4>
                                        <h4 class="category"><span class="label label-info">友情</span></h4>
                                    </div>
                                    <p class="time">5/2(星期一) / 五下課(13:10-13:20)</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Listing-->--%>
                        <div class="col-lg-6 col-md-8 col-sm-10 col-ms-10 songlist notfound" style="display: none">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4>No Result</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="col-xs-5 col-ms-5 image-div">
                                        <img alt="image" class="img-responsive" src="/images/logo.jpg" />
                                    </div>
                                    <div class="col-xs-7 col-ms-7 content-div">
                                        <h3>台大吉他社103級 民歌傳情</h3>
                                        <h4>2016/5/2 - 2016/5/6</h4>
                                        <div>
                                            <h4 class="category"><span class="label label-warning">友情</span></h4>
                                            <h4 class="category"><span class="label label-primary">愛情</span></h4>
                                            <h4 class="category"><span class="label label-danger">銃康</span></h4>
                                            <h4 class="category"><span class="label label-success">師長</span></h4>
                                            <h4 class="category"><span class="label label-info">另類</span></h4>
                                        </div>
                                        <p class="time">台大吉他，你會愛他！</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Submit" EventName="Click" />
                </Triggers>

            </asp:UpdatePanel>

            <div class="row">
                <hr class="divider down" />
            </div>

            <div id="TimeTableModel" style="display: none;">
                <div class="row">
                    <p class="pull-right"><span class="label label-success" style="bottom: 5px;"><i class="fa fa-check"></i></span>&nbsp;Available&nbsp;&nbsp;<span class="label label-danger"><i class="fa fa-clock-o"></i></span>&nbsp;Ordered<%--&nbsp;&nbsp;<span class="label label-warning"><i class="fa fa-times"></i></span>&nbsp;本時段已訂滿10首歌--%></p>
                </div>
                <table id="TimeTable" class="table table-bordered table-striped table-responsive">
                    <thead>
                        <tr>
                            <th></th>
                            <th><a data-toggle="tooltip" data-placement="top" title="5/2(一)">一</a></th>
                            <th><a data-toggle="tooltip" data-placement="top" title="5/3(二)">二</a></th>
                            <th><a data-toggle="tooltip" data-placement="top" title="5/4(三)">三</a></th>
                            <th><a data-toggle="tooltip" data-placement="top" title="5/5(四)">四</a></th>
                            <th><a data-toggle="tooltip" data-placement="top" title="5/6(五)">五</a></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div class="modal fade" id="ChooseTimeModel" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                            <h3 class="modal-title">Choose a time</h3>
                        </div>
                        <div class="modal-body" style="font-size: 1.4em;">
                            <div class="form-group">
                                <label for="DateList">Date：</label>
                                <asp:DropDownList ID="DateList" class="form-control" runat="server" Style="font-size: 1em; height: 40px;">
                                    <asp:ListItem Text="All Datess" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="5/2(Mon.)" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="5/3(Tue.)" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="5/4(Wed.)" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="5/5(Thu.)" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5/6(Fri.)" Value="5"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label for="DateList">Time：</label>
                                <asp:DropDownList ID="ClassList" class="form-control" runat="server" Style="font-size: 1em; height: 40px;">
                                    <asp:ListItem Text="All Time" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="2(10:00-10:20)" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3(11:10-11:20)" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4(12:10-12:20)" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5(13:10-13:20)" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6(14:10-14:20)" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7(15:10-15:30)" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8(16:20-16:30)" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9(17:20-17:30)" Value="9"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="Submit" runat="server" Text="Submit" class="btn btn-success" OnClick="Submit_Click" UseSubmitBehavior="false" data-dismiss="modal" />
                            <button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <footer>
            <div class="col-sm-6 col-sm-push-6 footer-links">
                <a href="/" class="home"><i class="fa fa-home"></i>&nbsp;Home</a>
                ·
                <a href="https://www.facebook.com/ntuguitar/" class="ntugt" target="_parent"><i class="fa fa-facebook-square"></i>&nbsp;NTUGuitar 2016</a>
                ·
				<a href="https://www.facebook.com/ntuguitarlove/" class="love" target="_parent"><i class="fa fa-heart"></i>&nbsp;Fanpage</a>
            </div>
            <div class="col-sm-6 col-sm-pull-6 footer-name">
                <p>NTUGuitar2016 MusicDelivery<small> | Design:康廷宇 Ting-Yu Kang</small></p>
            </div>
        </footer>
        <!--footer-->
    </form>
</body>
</html>
