<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="CarRental.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="~/Content/LoginPageStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-box login">
                <h1>Login</h1>
                <div class="input-box">
                    <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
                </div>

                <div class="input-box">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                </div>

                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                <asp:Button ID="btnLogin" runat="server" Text="LOGIN" OnClick="btnLogin_Click"/>
                <br />
                Đăng ký tài khoản <asp:LinkButton ID="lbtnSignUp" runat="server" OnClick="lbtnSignUp_Click">SignUp</asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>