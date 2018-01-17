<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailListAuthenticate/staff/secretlist.cs" Inherits="NTUGTLoveCarrier.RestrictPages.OrderSystem.DetailListAuthenticate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />
    <link href="/images/icon.jpg" rel="SHORTCUT ICON" type="text/css" />

    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <title>民歌繳費系統</title>
    <style>
        body{
            font-family:微軟正黑體;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="SubmitButton">
        <div class="col-sm-6">
            <h1>民歌繳費系統</h1>
            <p>注意：限民歌工作人員使用，密碼請勿流出！</p>
            <div class="form-group">
                <label for="pwd">請輸入密碼:</label>
                <asp:TextBox ID="pwd" TextMode="password" class="form-control" runat="server" MaxLength="20"></asp:TextBox>
            </div>
            <asp:Button ID="SubmitButton" class="btn btn-success" runat="server" Text="送出" OnClick="SubmitButton_Click" />
            <asp:Button ID="BackButton" class="btn btn-info" runat="server" Text="回首頁" OnClientClick="window.location='/'; return false;" />
        </div>
    </form>
</body>
</html>
