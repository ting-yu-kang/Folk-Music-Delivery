<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormConfirm.aspx.cs" Inherits="NTUGTLoveCarrier.Pages.FormConfirm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <title>確認資料</title>

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

    <script>
        //$(document).ready(function () {
        //    Congrats();
        //});
        function Congrats() {
            var RedirectTo;
            bootbox.dialog({
                message: $('#SubmitSuccess'),
                closeButton: false,
                //size: "large",
                buttons: {
                    redirect: {
                        label: "選歌查詢",
                        className: "btn-success",
                        callback: function () {
                            RedirectTo = "Query";
                        }
                    },
                    home: {
                        label: "確定",
                        className: "btn-primary",
                        callback: function () {
                            RedirectTo = "Home";
                        }
                    }
                },
                show: false
            })
                .on('shown.bs.modal', function () {
                    $('#SubmitSuccess').show();
                })
                .on('hide.bs.modal', function () {
                    if (RedirectTo == "Query") {
                        window.location = "/query";
                    }
                    else
                        window.location = "/";
                })
                .modal('show');
        }

        function SubmitConfirm() {
            var result = confirm('確定送出?');
            if (!result) return false;
        }
        //function SubmitConfirm() {
        //    alert('尚未開放！');
        //    return false;
        //}
    </script>
    <style>
        body {
            padding-top: 50px;
            font-family: '微軟正黑體';
        }

        div.col-sm-12, div.col-sm-6 {
            padding: 0 .5em;
        }
        .panel-body{
            padding:10px;
        }
        .panel-body ol{
            padding-left:20px;
        }
        .panel-body ol li{
            margin-bottom:10px;
        }
        .panel-body p{
            padding-left:0px;
            margin-left:5px;
        }
        @media only screen and (max-width: 768px) {
            div.col-sm-6 {
                padding-right: 0 !important;
                padding-left: 0 !important;
            }
            #SubmitSuccess div.col-xs-12{
                padding:0;
            }

            #SubmitSuccess ul{
                padding-left: 20px;
            }
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
            <h1 class="col-sm-12" style="font-family: cwTeXYen; font-weight: initial;">確認資料</h1>
            <div class="col-sm-12">
                <div class="col-sm-6">
                    <div class="panel panel-warning" style="padding: 0">
                        <div class="panel-heading">
                            <h3 class="panel-title" style="line-height: 1.5em">注意: 表單提交之前，本時段依然開放其他人選歌，請盡速確認以免他人搶先！</h3>
                        </div>
                    </div>

                    <div class="list-group">
                        <a class="list-group-item active">歌曲與時間資訊</a>
                        <asp:Label ID="DateLabel" class="list-group-item" runat="server" Text="傳情日期： "></asp:Label>
                        <asp:Label ID="ClassLabel" class="list-group-item" runat="server" Text="傳情時間： "></asp:Label>
                        <asp:Label ID="SongLabel" class="list-group-item" runat="server" Text="傳情歌曲： "></asp:Label>
                        <asp:Label ID="TeamLabel" class="list-group-item" runat="server" Text="傳情歌手： "></asp:Label>
                        <asp:Label ID="CategoryLabel" class="list-group-item" runat="server" Text="歌曲分類： "></asp:Label>
                    </div>
                    <div class="list-group">
                        <a class="list-group-item active">地點資訊</a>
                        <asp:Label ID="PlaceLabel" class="list-group-item" runat="server" Text="傳情地點："></asp:Label>
                        <asp:Label ID="ClassNameLabel" class="list-group-item" runat="server" Text="課堂名稱："></asp:Label>
                        <asp:Label ID="GeneralLessonLabel" class="list-group-item" runat="server" Text="是否為通識課："></asp:Label>
                    </div>
                    <div class="list-group">
                        <a class="list-group-item active">傳情者資訊</a>
                        <asp:Label ID="NameLabel" class="list-group-item" runat="server" Text="傳情者姓名："></asp:Label>
                        <asp:Label ID="DepartmentGradeLabel" class="list-group-item" runat="server" Text="傳情者系級："></asp:Label>
                        <asp:Label ID="PhoneLabel" class="list-group-item" runat="server" Text="傳情者手機："></asp:Label>
                        <asp:Label ID="EmailLabel" class="list-group-item" runat="server" Text="傳情者Email："></asp:Label>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="list-group">
                        <a class="list-group-item active">被傳情者資訊</a>
                        <asp:Label ID="SentNameLabel" class="list-group-item" runat="server" Text="被傳情者姓名："></asp:Label>
                        <asp:Label ID="SentDepartmentGradeLabel" class="list-group-item" runat="server" Text="被傳情者系級："></asp:Label>
                        <asp:Label ID="SentPhoneLabel" class="list-group-item" runat="server" Text="被傳情者手機："></asp:Label>
                        <asp:Label ID="SentEmailLabel" class="list-group-item" runat="server" Text="被傳情者Email："></asp:Label>
                    </div>
                    <div class="list-group">
                        <a class="list-group-item active">繳費與特殊需求</a>
                        <asp:Label ID="PayDayLabel" class="list-group-item" runat="server" Text="前往攤位繳費時間："></asp:Label>
                        <asp:Label ID="SpecialRequestLabel" class="list-group-item" runat="server" Text="特殊需求"></asp:Label>
                        <asp:Label ID="RemarkLabel" class="list-group-item" runat="server" Text="備註："></asp:Label>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="panel panel-danger" style="padding: 0">
                        <div class="panel-heading">
                            <h3 class="panel-title">注意事項</h3>
                        </div>
                        <div class="panel-body">
                            <ol>
                                <li>請再次確認您的「姓名」、「手機」正確輸入，此為查詢選歌紀錄的依據。</li>
                                <li>請再次確認被傳情者之「姓名」、「上課地點」正確輸入，讓歌手能夠順利找到您的傳情對象！</li>
                                <li>請於填入之繳費時間前來繳費，逾期將不予受理，選歌資訊也將被刪除。</li>
                                <li>繳費後請當場填寫傳情內容於明信片上，放入牛皮紙袋中，填妥袋外資訊後繳交。</li>
                                <li>若未傳情成功，將主動與傳情者聯繫，原則上將移至隔週同一時間進行傳情，詳細情況再另行通知。</li>
                            </ol>
                            <p style="font-weight: bolder;">💕&nbsp;台大吉他，你會愛他! 感謝你妳的點歌，請記得繳費後才正式報名成功，隔週才有歌手為你妳傳情喔&nbsp;💕</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12" style="text-align: right">
                    <asp:Button ID="BackButton" class="btn btn-danger" runat="server" Text="返回" OnClientClick="javascript:window.history.go(-1);" />
                    <asp:Button ID="SubmitButton" class="btn btn-success" runat="server" Text="確認送出" OnClientClick="return SubmitConfirm();" OnClick="SubmitButton_Click" />
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
        <div id="SubmitSuccess" style="display: none;">
            <div class="col-xs-12" style="text-align: center;">
                <img width="150" src="/images/check.png" />
                <h2>選歌完成！</h2>
            </div>
            <div class="col-xs-12" style="padding-left: 0;">
                <ul style="font-size: 16px;">
                    <li style="margin-top: 1em;">我們已經收到您的選歌！請依照您選定的繳費日期(4/25-4/29)，<br />
                        至<u>小福吉他週(11:30-14:20)</u>繳費及填寫明信片。</li>
                    <li style="margin-top: 1em;">欲查詢選歌及繳費紀錄，請憑<u>姓名與電話</u>至 <a href="/query"><i class="fa fa-book"></i>查詢系統</a>確認資訊。</li>
                    <li style="margin-top: 1em;">資訊錯誤、取消訂歌等任何問題，請私訊 <a href="https://www.facebook.com/ntuguitarlove/" target="_parent"><i class="fa fa-facebook-square"></i>民歌傳情Fanpage。</a></li>
                </ul>
            </div>
            <div class="row" style="text-align: right;">
                <p style="padding-right: 30px; margin: 1em 0 0 0">2016台大吉他社 民歌傳情</p>
            </div>
        </div>
    </form>
</body>
</html>
