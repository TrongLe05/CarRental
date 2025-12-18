<%@ Page Title="" Language="C#" MasterPageFile="~/SiteStaff.Master" AutoEventWireup="true" CodeBehind="StaffDashboard.aspx.cs" Inherits="CarRental.StaffDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Container riêng của trang này */
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

        /* Form thêm mới */
        .add-form {
            margin-bottom: 20px;
            padding: 15px;
            background: #eef2ff;
            border-radius: 8px;
        }

        .input-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
            margin-top: 10px;
        }

        .form-control {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn-add {
            background: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 10px;
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
            border-radius: 4px;
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

        /* Action Buttons */
        .btn-action {
            margin-right: 5px;
            cursor: pointer;
            border: none;
            background: none;
            font-size: 16px;
        }

        .edit-btn {
            color: #ffc107;
        }

        .delete-btn {
            color: #dc3545;
        }

        .save-btn {
            color: #28a745;
        }

        .cancel-btn {
            color: #6c757d;
        }

        /* Nút Đăng xe */
        .btn-post {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
            border: 1px solid #007bff;
            padding: 5px 10px;
            border-radius: 4px;
            transition: 0.2s;
        }

            .btn-post:hover {
                background: #007bff;
                color: white;
            }

            .btn-post.disabled {
                color: #ccc;
                border-color: #ccc;
                pointer-events: none;
                cursor: not-allowed;
            }

        /* Trạng thái */
        .status-rented {
            color: red;
            font-weight: bold;
        }

        .status-available {
            color: green;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-container">
        <h2><i class="fa-solid fa-car-rear"></i>Quản lý thông tin phương tiện</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div class="add-form">
            <h4>Thêm phương tiện mới:</h4>
            <div class="input-group">
                <asp:TextBox ID="txtNewLicensePlate" runat="server" CssClass="form-control" Placeholder="Biển số"></asp:TextBox>
                <asp:TextBox ID="txtNewNameVehicle" runat="server" CssClass="form-control" Placeholder="Tên xe"></asp:TextBox>
                <asp:TextBox ID="txtNewSeating" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Số chỗ" Width="80px"></asp:TextBox>
                <asp:TextBox ID="txtNewPrice" runat="server" CssClass="form-control" Placeholder="Giá thuê" TextMode="Number"></asp:TextBox>

                <asp:DropDownList ID="ddlFuelType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">-- Loại nhiên liệu --</asp:ListItem>
                    <asp:ListItem Value="Xăng">Xăng</asp:ListItem>
                    <asp:ListItem Value="Dầu">Dầu</asp:ListItem>
                    <asp:ListItem Value="Điện">Điện</asp:ListItem>
                </asp:DropDownList>

                <asp:FileUpload ID="fuNewImage" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="btnAdd" runat="server" Text="Thêm xe" CssClass="btn-add" OnClick="btnAdd_Click" />
        </div>

        <div class="filter-section">
            <strong><i class="fa-solid fa-filter"></i>Tìm kiếm & Lọc:</strong>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm biển số hoặc tên xe..."></asp:TextBox>
            <asp:DropDownList ID="ddlFilterFuel" runat="server" CssClass="form-control">
                <asp:ListItem Value="All">-- Tất cả nhiên liệu --</asp:ListItem>
                <asp:ListItem Value="Xăng">Xăng</asp:ListItem>
                <asp:ListItem Value="Dầu">Dầu</asp:ListItem>
                <asp:ListItem Value="Điện">Điện</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">-- Tất cả trạng thái --</asp:ListItem>
                <asp:ListItem Value="0">Chưa cho thuê</asp:ListItem>
                <asp:ListItem Value="1">Đã cho thuê</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="False"
            CssClass="mydatagrid"
            DataKeyNames="LicensePlate"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvStaff_PageIndexChanging"
            OnRowCancelingEdit="gvStaff_RowCancelingEdit"
            OnRowEditing="gvStaff_RowEditing"
            OnRowUpdating="gvStaff_RowUpdating"
            OnRowDeleting="gvStaff_RowDeleting"
            OnRowCommand="gvStaff_RowCommand">

            <PagerStyle CssClass="paging" HorizontalAlign="Center" />

            <Columns>
                <%-- Cột Ảnh Xe --%>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" CssClass="car-img" ImageUrl='<%# "~/Image/Vehicle/" + Eval("Image") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Image ID="imgCarEdit" runat="server" CssClass="car-img" ImageUrl='<%# Eval("Image") %>' />
                        <br />
                        <asp:FileUpload ID="fuEditImage" runat="server" Width="180px" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" ReadOnly="True" />
                <asp:BoundField DataField="NameVehicle" HeaderText="Tên xe" />
                <asp:BoundField DataField="SeatingCapacity" HeaderText="Số chỗ" />
                <asp:BoundField DataField="FuelType" HeaderText="Nhiên liệu" />
                <asp:BoundField DataField="Price" HeaderText="Giá/Ngày" DataFormatString="{0:0,000}" />

                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# (bool)Eval("VehicleStatus") ? "Đã cho thuê" : "Chưa cho thuê" %>'
                            CssClass='<%# (bool)Eval("VehicleStatus") ? "status-rented" : "status-available" %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <!--
                        <asp:CheckBox ID="chkTrangThai" runat="server"
                            Checked='<%# Bind("VehicleStatus") %>' Text="Đã thuê" />
                        -->
                    </EditItemTemplate>
                </asp:TemplateField>



                <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-action edit-btn"><i class="fa-solid fa-pen-to-square"></i></asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-action delete-btn" OnClientClick="return confirm('Bạn có chắc muốn xóa?');"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-action save-btn"><i class="fa-solid fa-check"></i></asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-action cancel-btn"><i class="fa-solid fa-xmark"></i></asp:LinkButton>
                    </EditItemTemplate>

                    <ItemStyle Width="100px"></ItemStyle>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
