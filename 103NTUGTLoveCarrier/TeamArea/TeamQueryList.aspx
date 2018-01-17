<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamQueryList.aspx.cs" Inherits="NTUGTLoveCarrier.TeamArea.TeamQueryList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <title>訂單列表</title>

    <link href="/images/icon.jpg" rel="SHORTCUT ICON" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/font-awesome/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/HoldOn.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/NavBarStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/footerStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/TeamQueryStyle.css" type="text/css" />

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="/Scripts/bootbox.min.js"></script>
    <script src="/Scripts/Custom/TeamQueryScript.js"></script>
    <script src="/Scripts/HoldOn.min.js"></script>

    <style>
        body {
            padding-top: 60px;
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
            <asp:Label ID="TeamLabel" runat="server" Text="組別：" class="col-xs-12" Style="font-size: 20px; margin-bottom: 10px;"></asp:Label>
            <asp:Label ID="RatioLabel" runat="server" Text="已點時段：" class="col-xs-12" Style="font-size: 20px; margin-bottom: 10px;"></asp:Label>

            <div class="tab-content col-sm-7">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#TimeTableTab">時間表</a></li>
                    <li><a data-toggle="tab" href="#ListTab">細節列表</a></li>
                </ul>

                <div id="TimeTableTab" class="tab-pane fade in active">
                    <h3>時間表</h3>
                    <p>請點選<strong style="color: red">紅色</strong>時段觀看訂單資訊</p>
                    <div class="col-xs-12">
                        <p class="pull-right"><span class="label label-success" style="bottom: 5px;"><i class="fa fa-check"></i></span>&nbsp;尚未預定&nbsp;&nbsp;<span class="label label-danger"><i class="fa fa-clock-o"></i></span>&nbsp;已預訂<%--&nbsp;&nbsp;<span class="label label-warning"><i class="fa fa-times"></i></span>&nbsp;本時段已訂滿10首歌--%></p>
                    </div>
                    <asp:Table ID="TimeTable" runat="server" class="table table-bordered table-striped table-responsive">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell></asp:TableHeaderCell>
                            <asp:TableHeaderCell><a data-toggle="tooltip" data-placement="top" title="5/2(一)">一</a></asp:TableHeaderCell>
                            <asp:TableHeaderCell><a data-toggle="tooltip" data-placement="top" title="5/3(二)">二</a></asp:TableHeaderCell>
                            <asp:TableHeaderCell><a data-toggle="tooltip" data-placement="top" title="5/4(三)">三</a></asp:TableHeaderCell>
                            <asp:TableHeaderCell><a data-toggle="tooltip" data-placement="top" title="5/5(四)">四</a></asp:TableHeaderCell>
                            <asp:TableHeaderCell><a data-toggle="tooltip" data-placement="top" title="5/6(五)">五</a></asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                    </asp:Table>
                </div>
                <div id="ListTab" class="tab-pane fade">
                    <h3>細節列表</h3>
                    <div style="padding: 0">
                        <asp:Table ID="myTable" runat="server" class="table table-responsive table-striped table-hover table-condensed table-bordered">
                            <asp:TableRow>
                                <asp:TableCell>More</asp:TableCell>
                                <asp:TableCell>訂單編號</asp:TableCell>
                                <asp:TableCell>傳情日期</asp:TableCell>
                                <asp:TableCell>傳情節數</asp:TableCell>
                                <asp:TableCell>歌曲</asp:TableCell>
                                <asp:TableCell>傳情地點</asp:TableCell>
                                <asp:TableCell>課堂名稱</asp:TableCell>
                                <asp:TableCell>通識課</asp:TableCell>
                                <asp:TableCell>繳費</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div>




            <div class="col-sm-7">
                <h5 style="margin-top: 0;"><i class="fa fa-paper-plane"></i>&nbsp;傳情與被傳情者資料由召部統一提供。</h5>
                <h5 style="margin-top: 0;"><i class="fa fa-paper-plane"></i>&nbsp;點歌資訊錯誤、敘述不清等任何問題，請與召部聯絡。</h5>
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
            <div class="col-xs-12" style="padding: 0 .5em">
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
