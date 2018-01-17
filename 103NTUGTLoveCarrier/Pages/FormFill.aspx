<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormFill.aspx.cs" Inherits="NTUGTLoveCarrier.Pages.FormFill" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1." />
    <title>Form</title>

    <link href="/images/icon.jpg" rel="SHORTCUT ICON" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/font-awesome/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/build.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/NavBarStyle.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/footerStyle.css" type="text/css" />

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>

    <script>
        //function SubmitConfirm() {
        //    alert('尚未開放!');
        //    return false;
        //}
        $(document).ready(function () {
            alert('Our Activity had finished, thank you!\nNTU Guitar Club 2016'); window.history.back();
            return;
            alert('注意：表單提交之前，本時段依然開放其他人選歌，請盡速填寫以免他人搶先！');
        });
        function SubmitConfirm() {
            var isValid = Page_ClientValidate();
            if (!isValid) return false;
            var result = confirm('確定送出?');
            if (!result) return false;
        }
    </script>

    <style>
        body {
            padding-top: 50px;
            font-family: '微軟正黑體';
        }

        span.checkbox {
            margin-top: 0;
        }

        @media only screen and (max-width: 768px) {
            div.col-sm-6 {
                padding-right: 0 !important;
                padding-left: 0 !important;
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

        <div hidden="hidden">
            <asp:ValidationSummary ID="valSummary" runat="server" ShowSummary="true" ShowMessageBox="true" />
        </div>
        <asp:HiddenField ID="DateHd" Value="-1" runat="server" />
        <asp:HiddenField ID="ClassHd" Value="-1" runat="server" />
        <asp:HiddenField ID="TeamHd" Value="-1" runat="server" />
        <asp:HiddenField ID="SongHd" Value="-1" runat="server" />

        <div class="row" style="margin: 1em">
            <h1 class="col-xs-12" style="font-family: cwTeXYen; font-weight: initial;">Form</h1>
            <h5><span style="color: #FF0000; font-weight: bolder;">*</span>Requested</h5>
            <div class="col-sm-6">
                <div class="list-group">
                    <h4 class="list-group-item active" style="margin-top: 0;">Information</h4>
                    <p class="list-group-item"><strong>Date：</strong><asp:Label ID="DateLabel" runat="server" Text=""></asp:Label></p>
                    <p class="list-group-item"><strong>Time：</strong><asp:Label ID="ClassLabel" runat="server" Text=""></asp:Label></p>
                    <p class="list-group-item"><strong>Song：</strong><asp:Label ID="SongLabel" runat="server" Text=""></asp:Label></p>
                    <p class="list-group-item"><strong>Guitarist：</strong><asp:Label ID="TeamLabel" runat="server" Text=""></asp:Label></p>
                    <p class="list-group-item"><strong>Category：</strong><asp:Label ID="CategoryLabel" runat="server" Text=""></asp:Label></p>
                </div>

                <div class="panel panel-success" style="padding: 0;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Location</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Location(ex.LE 102)<span style="color: #FF0000; font-weight: bolder;">*</span>：
                                </label>
                                <a class="label label-primary" href="https://nol.ntu.edu.tw/" target="_blank"><i class="fa fa-graduation-cap" aria-hidden="true"></i>&nbsp;NTU course</a>
                                <asp:RequiredFieldValidator class="label label-danger" runat="server" ErrorMessage="請輸入傳情地點" ControlToValidate="PlaceTextBox" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="PlaceLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="PlaceTextBox" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="PlaceTextBox" class="form-control" runat="server" placeholder="Location" MaxLength="40"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Class Name(ex.Sociology of Love)：
                                </label>
                                <asp:RegularExpressionValidator ID="ClassLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="ClassNameTextBox" Display="Dynamic"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="ClassNameTextBox" class="form-control" runat="server" placeholder="Class Name" MaxLength="40"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>General Lesson(Y/N)<span style="color: #FF0000; font-weight: bolder;">*</span>：</label>
                                <asp:DropDownList ID="GeneralLessonDropDownList" class="form-control" runat="server">
                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Don't know" Value="2" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-info" style="padding: 0;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sender</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Sender's Name<span style="color: #FF0000; font-weight: bolder;">*</span>：
                                    <asp:RequiredFieldValidator class="label label-danger" ID="NameValid" runat="server" ErrorMessage="請輸入姓名" ControlToValidate="NameTextBox" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="NameLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="NameTextBox"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="NameTextBox" class="form-control" runat="server" placeholder="Sender's Name" MaxLength="40"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Sender's Department<span style="color: #FF0000; font-weight: bolder;">*</span>：
                                    <asp:RequiredFieldValidator class="label label-danger" ID="DGValid" runat="server" ErrorMessage="請輸入系級" ControlToValidate="DepartmentGradeTextBox" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="DepartmentGradeLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,20}" ControlToValidate="DepartmentGradeTextBox"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="DepartmentGradeTextBox" class="form-control" runat="server" placeholder="Sender's Department" MaxLength="20"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Sender's Mobile Number<span style="color: #FF0000; font-weight: bolder;">*</span>：
                                    <asp:RequiredFieldValidator ID="PhoneValid1" class="label label-danger" runat="server" ErrorMessage="請輸入手機號碼" ControlToValidate="PhoneTextBox" Display="Dynamic" Font-Bold="True" />
                                    <asp:RegularExpressionValidator ID="PhoneValid2" class="label label-danger" runat="server" ErrorMessage="請輸入正確的手機格式" ControlToValidate="PhoneTextBox" ValidationExpression="[0]{1}[9]{1}[0-9]{8}" Display="Dynamic" Font-Bold="True" />
                                </label>
                                <asp:TextBox ID="PhoneTextBox" class="form-control" runat="server" placeholder="Sender's Mobile Number" MaxLength="10"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Sender's Email<span style="color: #FF0000; font-weight: bolder;">*</span>：
                                    <asp:RequiredFieldValidator ID="EmailValid1" class="label label-danger" runat="server" ErrorMessage="請輸入email" ControlToValidate="EmailTextBox" Display="Dynamic" Font-Bold="True" />
                                    <asp:RegularExpressionValidator ID="EmailValid2" class="label label-danger" runat="server" ErrorMessage="請輸入正確的Email格式" ControlToValidate="EmailTextBox" ValidationExpression="[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}" Display="Dynamic" Font-Bold="True" />
                                    <asp:RegularExpressionValidator ID="EmailLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="EmailTextBox"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="EmailTextBox" class="form-control" runat="server" placeholder="Sender's Email" MaxLength="40"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="panel panel-warning" style="padding: 0;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Receiver</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Receiver's Name<span style="color: #FF0000; font-weight: bolder;">*</span>：
                                    <asp:RequiredFieldValidator class="label label-danger" ID="NamedValid" runat="server" ErrorMessage="請輸入被傳情者姓名" ControlToValidate="SentNameTextBox" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="SentNameLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="SentNameTextBox"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="SentNameTextBox" class="form-control" runat="server" placeholder="Receiver's Name" MaxLength="40"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Receiver's Department(Optional)：
                                    <asp:RegularExpressionValidator ID="SentSentDepartmentLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,20}" ControlToValidate="SentDepartmentGradeTextBox"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="SentDepartmentGradeTextBox" class="form-control" runat="server" placeholder="Receiver's Department" MaxLength="20"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Receiver's Mobile Number(Optional)：
                                    <asp:RegularExpressionValidator class="label label-danger" runat="server" ErrorMessage="請輸入正確的手機格式" ControlToValidate="SentPhoneTextBox" ValidationExpression="[0]{1}[9]{1}[0-9]{8}" Display="Dynamic" Font-Bold="True" />
                                </label>
                                <asp:TextBox ID="SentPhoneTextBox" class="form-control" runat="server" placeholder="Receiver's Mobile Number" MaxLength="10"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Receiver's Email(Optional)：
                                   <asp:RegularExpressionValidator class="label label-danger" runat="server" ErrorMessage="請輸入正確的Email格式" ControlToValidate="SentEmailTextBox" ValidationExpression="[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}" Display="Dynamic" Font-Bold="True" />
                                    <asp:RegularExpressionValidator ID="SentEmailLengthValidator" runat="server" class="label label-danger" ErrorMessage="字數太長" ValidationExpression="[\s\S]{0,40}" ControlToValidate="SentEmailTextBox"></asp:RegularExpressionValidator>
                                </label>
                                <asp:TextBox ID="SentEmailTextBox" class="form-control" runat="server" placeholder="Receiver's Email" MaxLength="40"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default" style="padding: 0;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Fee(50 NTD) and Special Request</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>Payment Date<span style="color: #FF0000; font-weight: bolder;">*</span>：</label>
                                <asp:DropDownList ID="PayDayDropDownList" class="form-control" runat="server">
                                    <asp:ListItem Text="4/25(Mon.)" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="4/26(Tue.)" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="4/27(Wed.)" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4/28(Thu.)" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="4/29(Fri.)(before 14:30)" Value="5" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>Special Request：</label>
                                <asp:CheckBoxList ID="SpecialRequestCheckBox" runat="server">
                                    <asp:ListItem class="checkbox checkbox-primary" Text="Anonymous" Value="匿名傳情"></asp:ListItem>
                                    <asp:ListItem class="checkbox checkbox-primary" Text="Don't read the postcard in public" Value="不公開朗誦"></asp:ListItem>
                                    <asp:ListItem class="checkbox checkbox-primary" Text="Receiver is a prorfessor" Value="傳情給教授"></asp:ListItem>
                                    <asp:ListItem class="checkbox checkbox-primary" Text="Find the receiver in public" Value="公開尋找同學"></asp:ListItem>
                                    <asp:ListItem class="checkbox checkbox-primary" Text="Receiver will skip the class" Value="惡搞不在同學"></asp:ListItem>
                                    <asp:ListItem class="checkbox checkbox-primary" Text="Please be quiet" Value="安靜傳情"></asp:ListItem>
                                    <asp:ListItem class="checkbox checkbox-primary" Text="" Value="下課不確定">Class break time not sure(Please explain below)</asp:ListItem>
                                </asp:CheckBoxList>
                                <p style="color: red">[Anonymous]：We promise not to leak your identity!</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label>
                                    Remark:<br />
                                    (若歌手無法完成備註需求，將於傳情活動結束之後，辦理全額退費)(上限500字)： 
                                </label>
                                <p>
                                    ex:教授上課風格、特別安靜、容易拖延
                                    <asp:RegularExpressionValidator ID="SRValidator" runat="server" class="label label-danger" ErrorMessage="超過500字" ValidationExpression="[\s\S]{0,500}" Display="Dynamic" ControlToValidate="RemarkTextBox"></asp:RegularExpressionValidator>
                                </p>
                                <asp:TextBox ID="RemarkTextBox" class="form-control" runat="server" Rows="3" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-danger" style="padding: 0">
                    <div class="panel-heading">
                        <h3 class="panel-title" style="line-height: 1.5em">注意: 表單提交之前，本時段依然開放其他人選歌，請盡速填寫以免他人搶先！</h3>
                    </div>
                </div>
            </div>
            <div class="col-sm-12" style="text-align: right;">
                <asp:Button ID="SubmitButton" class="btn btn-success" runat="server" Text="送出表單" OnClientClick="return SubmitConfirm();" OnClick="SubmitButton_Click" />
            </div>
        </div>
        <!--footer-->
        <footer>
            <div class="col-sm-6 col-sm-push-6 footer-links">
                <a href="/" class="home"><i class="fa fa-home"></i>&nbsp;Home</a>
                ·
                <a href="https://www.facebook.com/ntuguitar/" target="_parent" class="ntugt"><i class="fa fa-facebook-square"></i>&nbsp;NTUGuitar 2016</a>
                ·
				<a href="https://www.facebook.com/ntuguitarlove/" target="_parent" class="love"><i class="fa fa-heart"></i>&nbsp;Fanpage</a>
            </div>
            <div class="col-sm-6 col-sm-pull-6 footer-name">
                <p>NTUGuitar2016 MusicDelivery<small> | Design:康廷宇 Ting-Yu Kang</small></p>
            </div>
        </footer>
        <!--footer-->
    </form>
</body>
</html>
