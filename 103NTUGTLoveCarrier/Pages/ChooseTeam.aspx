<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChooseTeam.aspx.cs" Inherits="NTUGTLoveCarrier.Pages.ChooseTeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <link href="/images/icon.jpg" rel="SHORTCUT ICON" />
    <title>Choose Guitarists</title>
    <link rel="stylesheet" href="/Content/bootstrap.css" />
    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/bootstrap_ms.css" />
    <link rel="stylesheet" href="/CSS/HoldOn.min.css" type="text/css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/CSS/TeamStyle.css" />
    <link rel="stylesheet" href="/CSS/NavBarStyle.css" />
    <link rel="stylesheet" href="/CSS/footerStyle.css" />

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="/Scripts/bootbox.min.js"></script>
    <script src="/Scripts/HoldOn.min.js"></script>
    <script src="/Scripts/Custom/TeamScript.js"></script>

    <style>
        body {
            padding-top: 50px;
            //font-family: '微軟正黑體';
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

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-lg-12">
                        <h1 class="description">Choose Guitarists</h1>
                        <h4 style="margin:0"><i class="fa fa-hand-pointer-o"></i>&nbsp;Click images to see the schedule</h4>
                        <div class="row pt-md">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            <%--<div class="col-lg-3 col-md-3 col-sm-4 col-ms-6 col-xs-12 profile">
                                <div class="img-box">
                                    <img src="/images/Players/1.JPG" class="img-responsive" />
                                    <span><i class="glyphicon glyphicon-fullscreen"></i></span>
                                </div>
                                <h1>朱瑤章 劉柔語</h1>
                                <h2>可選時段：0/13</h2>
                            </div>--%>
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
        <div id="TeamInfo" style="display: none;">
            <div class="row">
                <div class="col-sm-6">
                    <fieldset id="TeamDetailDiv" class="col-xs-12" data-keyboard="true">
                        <legend></legend>
                        <div id="TeamPhotoCarousel" class="carousel slide">
                            <!-- this is Carousel indicators -->
                            <ol class="carousel-indicators">
                                <%--<li data-target="#TeamPhotoCarousel" data-slide-to="0" class="active"></li>--%>
                            </ol>
                            <!--this is Wrapper for carousel items which are divided into three parts -->
                            <div class="carousel-inner">
                                <%--<div class="item active">
                                    <img src="/images/players/1.jpg" />
                                </div>--%>
                            </div>
                            <!-- this is Carousel controls -->
                            <a class="carousel-control left" href="#TeamPhotoCarousel" role="button">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="carousel-control right" href="#TeamPhotoCarousel" role="button">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
                        <div id="TeamDetail">
                            <h3></h3>
                            <h4></h4>
                            <%--<p></p>--%>
                        </div>
                    </fieldset>
                </div>
                <div class="col-sm-6">
                    <fieldset id="SongPickerDiv" class="col-xs-12" data-keyboard="true">
                        <legend>Song</legend>
                        <div id="SongContent">
                            <%--<div class="song-container pull-left"  style="display: none">
                                <h4 class="originalSinger">五月天五月天五月天</h4>
                                <h4 class="songCount">1 / 3</h4>
                                <h2 class="songName">想個不停</h2>
                                <h4 class="category">
                                    <span class="label label-warning">友情</span>
                                    <span class="label label-primary">愛情</span>
                                    <span class="label label-danger">銃康</span>
                                    <span class="label label-success">師長</span>
                                    <span class="label label-info">另類</span>
                                </h4>
                            </div>--%>
                        </div>
                        <span data-toggle="songpicker" data-type="subtract" class="fa fa-angle-left"></span>
                        <span data-toggle="songpicker" data-type="add" class="fa fa-angle-right"></span>
                    </fieldset>
                    <fieldset id="TimeTableDiv" class="col-xs-12">
                        <legend>Time</legend>
                        <p class="pull-right"><span class="label label-success" style="bottom: 5px;"><i class="fa fa-check"></i></span>&nbsp;Available&nbsp;&nbsp;<span class="label label-danger"><i class="fa fa-clock-o"></i></span>&nbsp;Ordered<%--&nbsp;&nbsp;<span class="label label-warning"><i class="fa fa-times"></i></span>&nbsp;本時段已訂滿10首歌--%></p>
                        <table id="TimeTable" class="table table-bordered table-striped table-responsive">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th><a data-toggle="tooltip" data-placement="top" title="5/2(一)">Mon.</a></th>
                                    <th><a data-toggle="tooltip" data-placement="top" title="5/3(二)">Tue.</a></th>
                                    <th><a data-toggle="tooltip" data-placement="top" title="5/4(三)">Wed.</a></th>
                                    <th><a data-toggle="tooltip" data-placement="top" title="5/5(四)">Thu.</a></th>
                                    <th><a data-toggle="tooltip" data-placement="top" title="5/6(五)">Fri.</a></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </fieldset>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
