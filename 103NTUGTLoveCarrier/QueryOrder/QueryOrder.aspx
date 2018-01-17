<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryOrder.aspx.cs" Inherits="NTUGTLoveCarrier.QueryOrder.QueryOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <title>Query</title>

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
            font-family: '微軟正黑體';
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
                                <li><a href="/team"><i class="fa fa-music"></i>&nbsp;Song</a></li>
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

        <div hidden="hidden">
            <asp:ValidationSummary ID="valSummary" runat="server" ShowSummary="true" ShowMessageBox="true" />
        </div>

        <div class="row" style="margin: 0 1em">
            <h1 class="col-sm-12">Query</h1>
            <div class="panel panel-primary col-sm-6" style="margin-left: 15px; padding: 0">
                <div class="panel-heading">
                    <h2 class="panel-title">Name and Mobile</h2>
                </div>
                <div class="panel-body">
                    <asp:HiddenField ID="SubmitType" Value="Time" runat="Server"></asp:HiddenField>
                    <div class="form-group" style="margin: 1em 0">
                        <p class="control-label" style="text-align: left;">
                            Name: <asp:TextBox ID="NameTextBox" class="form-control" runat="server" MaxLength="40"></asp:TextBox>
                            <asp:RequiredFieldValidator class="label label-danger" ID="NameValid" runat="server" ErrorMessage="請輸入姓名" ControlToValidate="NameTextBox" Display="Dynamic" />
                            <asp:RegularExpressionValidator class="label label-danger" ID="NameLengthValidator" runat="server"  ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="NameTextBox" Display="Dynamic"></asp:RegularExpressionValidator>
                        </p>
                    </div>
                    <div class="form-group" style="margin: 1em 0">
                        <p class="control-label" style="text-align: left">
                            Mobile: <asp:TextBox ID="PhoneTextBox" class="form-control" runat="server" MaxLength="10"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PhoneValid1" class="label label-danger" runat="server" ErrorMessage="請輸入手機號碼" ControlToValidate="PhoneTextBox" Display="Dynamic" Font-Bold="True" />
                            <asp:RegularExpressionValidator ID="PhoneValid2" class="label label-danger" runat="server" ErrorMessage="請輸入正確的手機格式" ControlToValidate="PhoneTextBox" ValidationExpression="[0]{1}[9]{1}[0-9]{8}" Display="Dynamic" Font-Bold="True" />
                        </p>
                    </div>
                </div>
                <div class="panel-footer">
                    <h5 style="margin:0;">資訊錯誤、取消訂歌等任何問題，請私訊&nbsp;<a href="https://www.facebook.com/ntuguitarlove/" target="_parent"><i class="fa fa-facebook-square"></i><strong>民歌傳情Fanpage</strong></a></h5>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-9">
                    <asp:Button ID="SubmitTime" runat="server" Text="query" class="btn btn-success" OnClick="SubmitTime_Click" />
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
