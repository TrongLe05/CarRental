<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewVehicle.aspx.cs" Inherits="CarRental.ViewVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .vehicle-detail {
            display: flex;
            gap: 100px;
            margin: 30px 0 30px 300px;
            flex-wrap: wrap;
/*            align-items: center;*/
            justify-content: center;
        }

        /* IMAGE */
        .vehicle-image {
            flex: 0;
/*            padding: 10px;*/
/*            border: 1px solid #333;*/
            
           
        }

        .vehicle-img {
            max-width: 450px;
            height: 100%;
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 0, 0, .2);
        }

        /* INFO */
        .vehicle-info {
            flex: 1;
        }

        .vehicle-title {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .vehicle-price {
            font-size: 22px;
            color: #16a34a;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .vehicle-meta p {
            margin: 6px 0;
        }

        .vehicle-desc {
            margin-top: 20px;
        }

        .btn-rent {
            margin-top: 100px;
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 12px 22px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

            .btn-rent:hover {
                background-color: #1d4ed8;
            }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="vehicle-detail">

            <!-- LEFT: IMAGE -->
            <div class="vehicle-image">
                <asp:Image ID="imgVehicle" runat="server" CssClass="vehicle-img" />
            </div>

            <!-- RIGHT: INFO -->
            <div class="vehicle-info">
                <h1 class="vehicle-title">
                    <asp:Label ID="lblNameVehicle" runat="server" />
                </h1>

                <div class="vehicle-price">
                    <asp:Label ID="lblPrice" runat="server" />
                </div>

                <div class="vehicle-meta">
                    <p>
                        👥 Số chỗ ngồi:
                <asp:Label ID="lblSeat" runat="server" />
                    </p>
                    <p>
                        ⛽ Nhiên liệu:
                <asp:Label ID="lblFuel" runat="server" />
                    </p>
                </div>

                <div class="vehicle-action">
                    <asp:Button ID="btnRent" runat="server"
                        Text="Thuê xe ngay"
                        CssClass="btn-rent" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
