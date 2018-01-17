<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryList.aspx.cs" Inherits="NTUGTLoveCarrier.QueryOrder.QueryList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <title>查詢結果</title>

    <link href="/images/icon.jpg" rel="SHORTCUT ICON" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/font-awesome/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/HoldOn.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/NavBarStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/footerStyle.css" type="text/css" />

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="/Scripts/bootbox.min.js"></script>
    <script src="/Scripts/Custom/QueryListScript.js"></script>
    <script src="/Scripts/HoldOn.min.js"></script>

    <style>
        body {
            padding-top: 50px;
            font-family: '微軟正黑體';
        }

        td {
            text-align: center;
            line-height: 2em !important;
            vertical-align: middle !important;
        }

        #QueryInformation p {
            color: #808080;
        }

        #QueryInformation h4 {
            font-size: 1.2em;
            margin: 0;
        }
    </style>
</head>
<body>
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
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-music"></i>&nbsp;選歌&nbsp;<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="/time"><i class="fa fa-clock-o"></i>&nbsp;時段選歌</a></li>
                                <li><a href="/category"><i class="fa fa-sitemap"></i>&nbsp;分類選歌</a></li>
                                <li><a href="/team"><i class="fa fa-music"></i>&nbsp;歌手選歌</a></li>
                                <li class="divider"></li>
                                <li><a href="/query"><i class="fa fa-book"></i>&nbsp;選歌查詢</a></li>
                            </ul>
                        </li>
                        <li><a href="/"><i class="fa fa-home"></i>&nbsp;Home</a></li>
                        <%--<li><a href="https://www.facebook.com/ntuguitarlove/" target="_parent"><i class="fa fa-facebook-square"></i>&nbsp;Facebook</a></li>--%>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Navigation -->

        <div class="row" style="margin: 0 1em">
            <h1 class="col-xs-12">查詢結果</h1>
            <asp:Label ID="NameLabel" runat="server" Text="姓名：" class="col-xs-12"></asp:Label>
            <asp:Label ID="PhoneLabel" runat="server" Text="電話：" class="col-xs-12"></asp:Label>

            <div class="col-sm-7 table-responsive" style="padding: 0">
                <asp:Table ID="myTable" runat="server" class="table table-striped table-hover table-condensed table-bordered">
                    <asp:TableRow>
                        <asp:TableCell>More</asp:TableCell>
                        <asp:TableCell>時間</asp:TableCell>
                        <asp:TableCell>歌目</asp:TableCell>
                        <asp:TableCell>繳費</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <div class="col-sm-7">
                <h5 style="margin: 0;">資訊錯誤、取消訂歌等任何問題，請私訊&nbsp;<a href="https://www.facebook.com/ntuguitarlove/" target="_parent"><i class="fa fa-facebook-square"></i><strong>民歌傳情Fanpage</strong></a></h5>
            </div>
            <div>
                <asp:Label ID="DateHdLabel" runat="server" Text=""></asp:Label>
                <asp:Label ID="TimeHdLabel" runat="server" Text=""></asp:Label>
                <asp:Label ID="TeamHdLabel" runat="server" Text=""></asp:Label>
                <asp:Label ID="SongHdLabel" runat="server" Text=""></asp:Label>
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
        <div id="QueryInformation" class="row" style="display: none;">
            <div class="col-sm-6" style="padding: 0 .5em">
                <div class="panel panel-primary">
                    <div class="panel-heading">歌曲與時間資訊</div>
                    <div class="list-group">
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情日期</p>
                            <h4 id="date" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情時間</p>
                            <h4 id="class" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情歌手</p>
                            <h4 id="teammembarname" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情歌曲</p>
                            <h4 id="songname" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">歌曲分類</p>
                            <h4 id="category" class="list-group-item-text"></h4>
                        </div>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">地點資訊</div>
                    <div class="list-group">
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情地點</p>
                            <h4 id="place" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">課堂名稱</p>
                            <h4 id="classname" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">是否為通識課</p>
                            <h4 id="generallesson" class="list-group-item-text"></h4>
                        </div>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">傳情者資訊</div>
                    <div class="list-group">
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情者姓名</p>
                            <h4 id="name" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情者系級</p>
                            <h4 id="departgrade" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情者手機</p>
                            <h4 id="phone" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">傳情者Email</p>
                            <h4 id="email" class="list-group-item-text"></h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6" style="padding: 0 .5em">
                <div class="panel panel-primary">
                    <div class="panel-heading">被傳情者資訊</div>
                    <div class="list-group">
                        <div class="list-group-item">
                            <p class="list-group-item-heading">被傳情者姓名</p>
                            <h4 id="sentname" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">被傳情者系級</p>
                            <h4 id="sentdepartgrade" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">被傳情者手機</p>
                            <h4 id="sentphone" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">被傳情者Email</p>
                            <h4 id="sentemail" class="list-group-item-text"></h4>
                        </div>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">繳費與特殊需求</div>
                    <div class="list-group">
                        <div class="list-group-item">
                            <p class="list-group-item-heading">攤位繳費時間</p>
                            <h4 id="payday" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">特殊需求</p>
                            <h4 id="specialrequest" class="list-group-item-text"></h4>
                        </div>
                        <div class="list-group-item">
                            <p class="list-group-item-heading">備註</p>
                            <h4 id="remark" class="list-group-item-text"></h4>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <p class="list-group-item-heading">已付款</p>
                        <h4 id="ispaid" class="list-group-item-text">是</h4>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
