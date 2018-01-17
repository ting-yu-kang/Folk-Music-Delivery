<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailList.aspx.cs" Inherits="NTUGTLoveCarrier.OrderSystem.DetailList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0" />
    <link href="/images/icon.jpg" rel="SHORTCUT ICON" type="text/css" />

    <link rel="stylesheet" href="/Content/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="/Content/bootstrap-theme.min.css" type="text/css" />
    <link rel="stylesheet" href="/CSS/HoldOn.min.css" type="text/css" />
    <title>民歌繳費系統</title>

    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <script src="/Scripts/bootbox.min.js"></script>
    <script src="/Scripts/HoldOn.min.js"></script>
    <script src="/Scripts/Custom/DetailListScript.js"></script>
    
    <style>
        body {
            font-family: 微軟正黑體;
        }

        td, th {
            text-align: center;
            vertical-align: middle !important;
        }
    </style>
    <script>
        function SubmitConfirm() {
            var result = confirm('確定繳費?');
            if (!result) return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="col-xs-12">
            <div "col-xs-12">
                <h1>民歌繳費系統</h1>
                <asp:Button ID="Print" class="btn btn-info" runat="server" Text="Excel" OnClick="Print_Click" />
                <asp:Button ID="Logout" class="btn btn-default" runat="server" Text="登出" OnClick="Logout_Click" />
                <h4 style="color:red">＊閒置30分鐘自動登出</h4>
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Panel runat="server" class="col-xs-6" Style="padding: 0" DefaultButton="SubmitPhoneQuery">
                        <div class="form-group col-sm-8">
                            <label for="PhoneTextBox">手機查找:</label>
                            <asp:TextBox ID="PhoneTextBox" class="form-control" runat="server" autocomplete="off" MaxLength="10"></asp:TextBox>
                            <asp:ValidationSummary ID="PhoneSummary" runat="server" ShowSummary="true" ShowMessageBox="true" ValidationGroup="Phone" Visible="False" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="No data!" class="label label-danger" ControlToValidate="PhoneTextBox" ValidationGroup="Phone" Display="Dynamic"></asp:RequiredFieldValidator>
                            <%--<asp:RegularExpressionValidator ID="PhoneValid" runat="server" ErrorMessage="字數太長or不合法" class="label label-danger" ControlToValidate="PhoneTextBox" ValidationGroup="Phone" ValidationExpression="^[0-9]{1,10}$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                        </div>
                        <div class="form-group col-sm-8">
                            <asp:Button ID="SubmitPhoneQuery" class="btn btn-success" runat="server" OnClick="SubmitPhoneQuery_Click" Text="查詢" ValidationGroup="Phone" />
                        </div>
                    </asp:Panel>

                    <asp:Panel runat="server" class="col-xs-6" Style="padding: 0" DefaultButton="SubmitNameQuery">
                        <div class="form-group col-sm-8">
                            <label for="NameTextBox">姓名查找:</label>
                            <asp:TextBox ID="NameTextBox" class="form-control" runat="server" autocomplete="off" MaxLength="40"></asp:TextBox>
                            <asp:ValidationSummary ID="NameSummary" runat="server" ShowSummary="true" ShowMessageBox="true" ValidationGroup="Name" Visible="False" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="No data!" class="label label-danger" ControlToValidate="NameTextBox" ValidationGroup="Name" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-sm-8">
                            <asp:Button ID="SubmitNameQuery" class="btn btn-success" runat="server" OnClick="SubmitNameQuery_Click" Text="查詢" ValidationGroup="Name" />
                        </div>
                    </asp:Panel>
                    <div class="col-xs-12">
                        <asp:GridView ID="GridView1" runat="server" class="table table-striped table-bordered table-condensed table-responsive" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button runat="server" class="btn btn-warning" CommandName="PAY" Text="繳費" OnClientClick="return SubmitConfirm();" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button runat="server" class="btn btn-primary" CommandName="DETAIL" Text="詳細資料" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="col-xs-12">
                        <h1>
                            <asp:Label ID="NotFoundLabel" runat="server" class="label label-danger" Text="Not found!!!" Visible="False"></asp:Label>
                        </h1>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                </Triggers>
            </asp:UpdatePanel>
        </div>

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
