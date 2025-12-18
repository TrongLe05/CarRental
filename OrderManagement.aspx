<%@ Page Title="" Language="C#" MasterPageFile="~/SiteStaff.Master" AutoEventWireup="true" CodeBehind="OrderManagement.aspx.cs" Inherits="CarRental.OrderManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        .page-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
        /* Xanh lá - Duyệt */
        .btn-complete {
            background-color: #17a2b8;
        }
        /* Xanh dương - Hoàn tất */
        .btn-cancel {
            background-color: #dc3545;
        }
        /* Đỏ - Hủy */
        .btn-delete {
            background-color: #6c757d;
        }
        /* Xám - Xóa */

        /* --- STYLE CHO TRẠNG THÁI --- */
        .status-pending {
            color: #ffc107;
            font-weight: bold;
        }
        /* Vàng */
        .status-approved {
            color: #28a745;
            font-weight: bold;
        }
        /* Xanh lá */
        .status-completed {
            color: #17a2b8;
            font-weight: bold;
        }
        /* Xanh dương */
        .status-cancelled {
            color: #dc3545;
            font-weight: bold;
        }
        /* Đỏ */
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-container">
        <h2><i class="fa-solid fa-file-invoice-dollar"></i>Quản lý đơn thuê xe</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div class="filter-section">
            <strong><i class="fa-solid fa-filter"></i>Tìm kiếm & Lọc:</strong>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm theo khách hoặc biển số..."></asp:TextBox>

            <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="All">-- Tất cả trạng thái --</asp:ListItem>
                <asp:ListItem Value="Pending">Chờ duyệt</asp:ListItem>
                <asp:ListItem Value="Approved">Đã duyệt (Đang thuê)</asp:ListItem>
                <asp:ListItem Value="Completed">Hoàn thành</asp:ListItem>
                <asp:ListItem Value="Cancelled">Đã hủy</asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
            CssClass="mydatagrid"
            DataKeyNames="OrderID"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvOrders_PageIndexChanging"
            OnRowCommand="gvOrders_RowCommand"
            OnRowDeleting="gvOrders_RowDeleting">

            <PagerStyle CssClass="paging" HorizontalAlign="Center" />

            <Columns>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" CssClass="car-img" ImageUrl='<%#"~/Image/Vehicle/" + Eval("CarImage") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" />
                <asp:BoundField DataField="VehicleName" HeaderText="Tên xe" />
                <asp:BoundField DataField="CustomerName" HeaderText="Khách hàng" />

                <asp:BoundField DataField="RentalDate" HeaderText="Ngày thuê" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="ReturnDate" HeaderText="Ngày trả" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Tổng tiền" DataFormatString="{0:0,000} VNĐ" />

                <%-- CỘT TRẠNG THÁI HIỂN THỊ TIẾNG VIỆT --%>
                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# GetStatusText(Eval("OrderStatus")) %>'
                            CssClass='<%# GetStatusClass(Eval("OrderStatus")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- CỘT THAO TÁC VỚI CÁC NÚT MÀU --%>
                <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="140px">
                    <ItemTemplate>
                        <div class="action-group">
                            <asp:LinkButton ID="btnApprove" runat="server" CommandName="ApproveOrder" CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn-icon btn-approve" ToolTip="Duyệt đơn (Xe -> Đã thuê)"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Pending") %>'>
                                <i class="fa-solid fa-check"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnComplete" runat="server" CommandName="CompleteOrder" CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn-icon btn-complete" ToolTip="Hoàn tất & Trả xe (Xe -> Trống)"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Approved") %>'>
                                <i class="fa-solid fa-flag-checkered"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelOrder" CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn-icon btn-cancel" ToolTip="Hủy đơn" OnClientClick="return confirm('Bạn chắc chắn muốn hủy đơn này?');"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Pending") %>'>
                                <i class="fa-solid fa-xmark"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-icon btn-delete"
                                OnClientClick="return confirm('Xóa vĩnh viễn dòng lịch sử này?');"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Cancelled") || IsStatus(Eval("OrderStatus"), "Completed") %>'>
                                <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
