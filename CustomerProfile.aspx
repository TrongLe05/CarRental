<%@ Page ValidateRequest="False" Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="CarRental.CustomerProfile" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="/Content/CustomerProfileStye.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            height: 25px;
            
        }
        .auto-style2 {
            width: 245px;
            text-align: right;
        }

        .auto-style3 {
            width: 245px;
            text-align: right;
            height: 25px;
        }

        .auto-style4 {
            width: 245px;
            text-align: right;
            height: 24px;
        }
        .auto-style5 {
            height: 24px;
        }

        * {
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 1100px;
            margin: 100px auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2><i class="fa-solid fa-address-card"></i> Hồ sơ của tôi</h2>
        <div class="update-info">
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label7" runat="server" Text="Tên đăng nhập "></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" Text="Họ &amp; tên"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtFullname" CssClass="input-box" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="CCCD"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtCustomerCCCD" CssClass="input-box" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="Giới tính"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:DropDownList ID="ddlSex" CssClass="input-box" runat="server" Enabled="False">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem Value="1">Nam</asp:ListItem>
                            <asp:ListItem Value="2">Nữ</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Số điện thoại"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtPhone" CssClass="input-box" runat="server" TextMode="Phone" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label5" runat="server" Text="Địa chỉ"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        &nbsp;<asp:TextBox ID="txtAddress" runat="server" Enabled="False" TextMode="MultiLine" Width="200px"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label6" runat="server" Text="Ngày sinh"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtBirthDate" CssClass="input-box" runat="server" TextMode="Date" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lblMassage" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:Button ID="btnSave" CssClass="btn-save" runat="server" Text="Lưu" OnClick="btnSave_Click" Enabled="False" />
                        <asp:LinkButton ID="lbtnUpdate" runat="server" OnClick="lbtnUpdate_Click">Cập nhật</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
