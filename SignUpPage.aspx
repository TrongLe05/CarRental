<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUpPage.aspx.cs" Inherits="CarRental.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    <link href="~/Content/SignUpPageStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-box login">
                <h1>Sign Up</h1>
                <div class="input-box">
                    <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
                </div>

                <div class="input-box">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                </div>

                <div class="input-box">
                    <asp:TextBox ID="txtPasswordRe" runat="server" TextMode="Password" Placeholder="Re-enter password"></asp:TextBox>
                </div>

                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                <asp:Button ID="btnLogin" runat="server" Text="SIGN UP" OnClick="btnLogin_Click"/>

                Đã có tài khoản? <asp:LinkButton ID="lbtnLogin" runat="server" OnClick="lbtnLogin_Click">Login</asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>