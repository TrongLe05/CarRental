<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentPage.aspx.cs" Inherits="CarRental.PaymentPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thanh toán - Cho thuê xe</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: #f5f5f5;
            padding-bottom: 30px;
        }

        .header {
            background: white;
            padding: 20px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .header i {
            color: #666;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .container a {
            font-size: 24px;
            color: #666;
            text-decoration: none;
        }
        .layout {
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: 20px;
        }

        .card {
            background: white;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .card-header {
            background: #f8f9fa;
            padding: 15px 20px;
            font-weight: 600;
            color: #333;
            border-bottom: 1px solid #e9ecef;
        }

            .card-header i {
                margin-right: 8px;
                color: #666;
            }

        .card-body {
            padding: 20px;
        }

        .customer-name {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 8px;
            color: #333;
        }

        .customer-info{
            color: #666;
            margin-bottom: 5px;
            font-size: 15px;
        }

        .btn-change {
            background: white;
            border: 1px solid #ddd;
            color: #333;
            padding: 8px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 14px;
        }

            .btn-change:hover {
                border-color: #666;
            }

        .vehicle-item {
            display: flex;
            gap: 15px;
        }

        .vehicle-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }

        .vehicle-info {
            flex: 1;
        }

        .vehicle-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #333;
        }

        .vehicle-details {
            display: flex;
            gap: 15px;
            margin-bottom: 8px;
            color: #666;
            font-size: 14px;
        }

        .vehicle-license {
            color: #666;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .vehicle-price {
            color: #e74c3c;
            font-size: 18px;
            font-weight: 600;
        }

        .date-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 15px;
        }

        .date-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        .date-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .duration-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            text-align: center;
            font-size: 16px;
            color: #333;
        }

        .summary-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            position: sticky;
            top: 20px;
        }

        .summary-header {
            background: #f8f9fa;
            padding: 15px 20px;
            font-weight: 600;
            color: #333;
            border-bottom: 1px solid #e9ecef;
        }

        .summary-body {
            padding: 20px;
        }

        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: #666;
            font-size: 14px;
        }

        .row.total {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }

        .total-price {
            color: #e74c3c;
            font-size: 20px;
        }

        .divider {
            height: 1px;
            background: #e9ecef;
            margin: 20px 0;
        }

        .btn-confirm {
            width: 100%;
            background: #e74c3c;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn-confirm:hover {
            background: #c0392b;
        }

        .btn-confirm:disabled {
            background: #31ae66;
        }

        .message {
            position: fixed;
            top: 100px;
            right: 20px;
            padding: 15px 20px;
            color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            z-index: 1000;
            max-width: 400px;
        }

        .message.success {
            background: #27ae60;
        }

        .message.error {
            background: #e74c3c;
        }

        @media (max-width: 992px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .summary-card {
                position: static;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <div class="container">
                <h2><a href="Home.aspx"> <i class="fas fa-car"></i> Cho thuê xe 3 con cá</a></h2>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container main-content">
            <div class="layout">
                <!-- Left Column -->
                <div class="left-column">
                    <!-- Địa chỉ nhận xe -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fa-solid fa-address-card"></i>
                            Thông tin khách hàng
                        </div>
                        <div class="card-body">
                            <div class="customer-info">
                                <b>Họ & tên:</b> <asp:Label ID="lblCustomerName" runat="server"></asp:Label> <br />
                                
                                <b>Số điện thoại:</b> <asp:Label ID="lblCustomerPhone" runat="server"></asp:Label> <br />
                                <b>Địa chỉ:</b> <asp:Label ID="lblCustomerAddress" runat="server"></asp:Label> <br />
                                <b>Căn cước công dân:</b> <asp:Label ID="lblCustomerID" runat="server"></asp:Label> <br />
                            </div>
                            <asp:Button ID="btnChangeAddress" runat="server" Text="Thay Đổi" CssClass="btn-change" OnClick="btnChangeAddress_Click" />
                        </div>
                    </div>

                    <!-- Thông tin xe -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-car-side"></i>
                            Thông Tin Xe Thuê
                        </div>
                        <div class="card-body">
                            <div class="vehicle-item">
                                <asp:Image ID="imgVehicle" runat="server" CssClass="vehicle-img" />
                                <div class="vehicle-info">
                                    <div class="vehicle-name">
                                        <asp:Label ID="lblVehicleName" runat="server"></asp:Label>
                                    </div>
                                    <div class="vehicle-details">
                                        <span><i class="fas fa-users"></i>
                                            <asp:Label ID="lblSeating" runat="server"></asp:Label>
                                            chỗ</span>
                                        <span><i class="fas fa-gas-pump"></i>
                                            <asp:Label ID="lblFuelType" runat="server"></asp:Label></span>
                                    </div>
                                    <div class="vehicle-license">
                                        <i class="fas fa-id-card"></i>Biển số:
                                        <asp:Label ID="lblLicensePlate" runat="server"></asp:Label>
                                    </div>
                                    <div class="vehicle-price">
                                        <asp:Label ID="lblPricePerDay" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Thời gian thuê -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-calendar-alt"></i>
                            Thời Gian Thuê
                        </div>
                        <div class="card-body">
                            <div class="date-row">
                                <div class="date-group">
                                    <label>Ngày nhận xe</label>
                                    <asp:TextBox ID="txtRentalDate" runat="server" TextMode="Date" CssClass="date-input" AutoPostBack="true" OnTextChanged="CalculateTotal"></asp:TextBox>
                                </div>
                                <div class="date-group">
                                    <label>Ngày trả xe</label>
                                    <asp:TextBox ID="txtReturnDate" runat="server" TextMode="Date" CssClass="date-input" AutoPostBack="true" OnTextChanged="CalculateTotal"></asp:TextBox>
                                </div>
                            </div>
                            <div class="duration-box">
                                Số ngày thuê:
                                <asp:Label ID="lblDuration" runat="server">0</asp:Label>
                                ngày
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="right-column">
                    <div class="summary-card">
                        <div class="summary-header">
                            Chi Tiết Thanh Toán
                        </div>
                        <div class="summary-body">
                            <div class="row">
                                <span>Giá thuê xe (x<asp:Label ID="lblDays" runat="server">0</asp:Label>
                                    ngày)</span>
                                <span>
                                    <asp:Label ID="lblSubTotal" runat="server">0 VNĐ</asp:Label></span>
                            </div>
                            <div class="row">
                                <span>Phí dịch vụ</span>
                                <span>
                                    <asp:Label ID="lblServiceFee" runat="server">0 VNĐ</asp:Label></span>
                            </div>
                            <div class="row">
                                <span>Phí bảo hiểm</span>
                                <span>
                                    <asp:Label ID="lblInsuranceFee" runat="server">0 VNĐ</asp:Label></span>
                            </div>
                            <div class="divider"></div>
                            <div class="row total">
                                <span>Tổng cộng</span>
                                <span class="total-price">
                                    <asp:Label ID="lblTotal" runat="server">0 VNĐ</asp:Label></span>
                            </div>
                        </div>
                        <asp:Button ID="btnConfirmPayment" runat="server" Text="Xác Nhận Đặt Xe" CssClass="btn-confirm" OnClick="btnConfirmPayment_Click" />
                    </div>
                </div>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
    </form>
</body>
</html>
