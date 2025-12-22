<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="CarRentalHistory.aspx.cs" Inherits="CarRental.CarRentalHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 1500px;
            margin: 100px auto;
        }

        h2 {
            color: #333;
            border-bottom: 2px solid #7494ec;
            padding-bottom: 10px;
            margin-top: 0;
        }

        /* Bộ lọc */
        .filter-section {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            align-items: center;
            flex-wrap: wrap;
        }

        .date-input {
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .date-input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
        }

        .form-control {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn-search {
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 4px;
        }

        /* GridView */
        .mydatagrid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

            .mydatagrid th {
                background-color: #7494ec;
                color: white;
                padding: 10px;
                text-align: left;
            }

            .mydatagrid td {
                padding: 10px;
                border-bottom: 1px solid #ddd;
                vertical-align: middle;
            }

            .mydatagrid tr:hover {
                background-color: #f1f1f1;
            }

        .car-img {
            width: 100%;
            height: 90px;
            object-fit: contain;
        }

        /* Phân trang */
        .paging td table {
            margin: 10px auto;
        }

        .paging td span {
            background: #7494ec;
            color: #fff;
            padding: 5px 10px;
            border-radius: 4px;
            margin: 2px;
        }

        .paging td a {
            background: #fff;
            color: #333;
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin: 2px;
            text-decoration: none;
        }

        /* --- STYLE CHO NÚT THAO TÁC --- */
        .action-group {
            display: flex;
            gap: 5px;
        }

        .btn-icon {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 32px;
            height: 32px;
            border-radius: 4px;
            color: white;
            border: none;
            cursor: pointer;
            text-decoration: none;
            transition: 0.2s;
            font-size: 14px;
        }

            .btn-icon:hover {
                opacity: 0.8;
                transform: translateY(-2px);
            }

        .btn-approve {
            background-color: #28a745;
        }

        /* CSS cho trạng thái */

        /* Vàng */
        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }
        
        /* Xanh lá */
        .status-approved {
            color: #28a745;
            font-weight: bold;
        }

        /* Xanh dương */
        .status-completed {
            color: #17a2b8;
            font-weight: bold;
        }

        /* Đỏ */
        .status-cancelled {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-container">
        <h2><i class="fa-solid fa-clock-rotate-left"></i> Lịch sử thuê xe</h2>

        <div class="filter-section">
            <strong><i class="fa-solid fa-filter"></i> Lọc:</strong>
            <asp:TextBox ID="txtDateFind" CssClass="date-input" runat="server" TextMode="Date"></asp:TextBox>

            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" />
        </div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
            CssClass="mydatagrid"
            DataKeyNames="OrderID"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvOrders_PageIndexChanging">

            <PagerStyle CssClass="paging" HorizontalAlign="Center" />

            <Columns>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" CssClass="car-img" ImageUrl='<%#"~/Image/Vehicle/" + Eval("CarImage") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" />
                <asp:BoundField DataField="VehicleName" HeaderText="Tên xe" />

                <asp:BoundField DataField="RentalDate" HeaderText="Ngày thuê" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="ReturnDate" HeaderText="Ngày trả" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Tổng tiền" DataFormatString="{0:0,000} VNĐ" />

                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# GetStatusText(Eval("OrderStatus")) %>'
                            CssClass='<%# GetStatusClass(Eval("OrderStatus")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
