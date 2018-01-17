<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChooseCategory.aspx.cs" Inherits="NTUGTLoveCarrier.Pages.ChooseCategory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <title>Choose a Category</title>
    <link href="/images/icon.jpg" rel="SHORTCUT ICON" />

    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/font-awesome/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/NavBarStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/footerStyle.css" type="text/css" />

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>

    <style>
        body {
            padding-top: 50px;
            font-family: 'cwTeXYen','微軟正黑體';
        }

        .panel p, #CategoryList {
            font-size: 1.5em;
            height: auto;
        }

        .panel ul {
            padding-left: 20px;
        }

        .panel li {
            margin-bottom:10px;
            font-size: 1.4em;
        }

        .panel h2 {
            font-size: 1.3em !important;
        }

        .panel h3 {
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

        <div class="row" style="margin: 0 1em">
            <h1 class="col-sm-12">Choose a Category</h1>
            <div class="panel panel-primary col-sm-6" style="padding: 0">
                <div class="panel-heading">
                    <h2 class="panel-title">Categories</h2>
                </div>
                <div class="panel-body">
                    <asp:HiddenField ID="SubmitType" Value="Category" runat="Server"></asp:HiddenField>
                    <div class="form-group" style="margin: 1em 0">
                        <asp:DropDownList ID="CategoryList" class="form-control" runat="server">
                            <asp:ListItem Text="All" Value="all"></asp:ListItem>
                            <asp:ListItem Text="Friend" Value="c1"></asp:ListItem>
                            <asp:ListItem Text="Lover" Value="c2"></asp:ListItem>
                            <asp:ListItem Text="Prank" Value="c3"></asp:ListItem>
                            <asp:ListItem Text="Teacher" Value="c4"></asp:ListItem>
                            <asp:ListItem Text="Other" Value="c5"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="panel panel-info col-sm-6" style="padding: 0; margin-right: 1em">
                <div class="panel-heading">
                    <h2 class="panel-title">注意事項</h2>
                </div>
                <div class="panel-body">
                    <ul>
                        <li>傳情對象包含<u>學生</u>、<u>教授</u>、以及任何可在<u>校總區</u>中被準確找到的對象</li>
                        <li>傳情內容不一定是告白，可以是<u>感謝、銃康、宣傳之夜</u>等各種要求</li>
                        <li>請務必依您指定的繳費日期至<u>小福吉他週攤位</u>完成繳費程序，若逾時未繳，系統將<u>自動移除選歌資料</u>，開放他人選歌</li>
                    </ul>
                    <blockquote>
                        <h3>根據您的傳情需要，從歌單中找尋最對味的歌曲與歌手!</h3>
                        <h4 style="color: red">(歌曲可能特別被賦予不同情緒! 例如：歌手用"銃康"形式演唱"分手快樂")</h4>
                    </blockquote>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-9">
                    <asp:Button ID="SubmitCategory" runat="server" Text="Submit" class="btn btn-primary" PostBackUrl="/songlist" />
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
