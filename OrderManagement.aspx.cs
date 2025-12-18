using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class OrderManagement : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    if (Session["Username"] == null) Response.Redirect("LoginPage.aspx");
            LoadData();
            //}
        }

        // --- CÁC HÀM HELPER HIỂN THỊ ---

        // 1. Lấy CSS class màu sắc cho chữ trạng thái
        protected string GetStatusClass(object statusObj)
        {
            if (statusObj == null) return "status-pending";
            string status = statusObj.ToString();
            if (status == "Approved") return "status-approved"; // Xanh lá
            if (status == "Completed") return "status-completed"; // Xanh dương
            if (status == "Cancelled") return "status-cancelled"; // Đỏ
            return "status-pending"; // Vàng
        }

        // 2. Lấy Text hiển thị Tiếng Việt
        protected string GetStatusText(object statusObj)
        {
            if (statusObj == null || string.IsNullOrEmpty(statusObj.ToString())) return "Chờ duyệt";
            string status = statusObj.ToString();
            if (status == "Approved") return "Đang thuê";
            if (status == "Completed") return "Hoàn thành";
            if (status == "Cancelled") return "Đã hủy";
            return "Chờ duyệt";
        }

        // 3. Hàm kiểm tra trạng thái để ẩn hiện nút (QUAN TRỌNG: Sửa để xử lý NULL)
        protected bool IsStatus(object statusObj, string targetStatus)
        {
            // Nếu dữ liệu trong DB là NULL hoặc Rỗng -> Coi như là "Pending" (Chờ duyệt)
            string currentStatus = (statusObj == null || string.IsNullOrEmpty(statusObj.ToString())) ? "Pending" : statusObj.ToString();
            return currentStatus == targetStatus;
        }

        // --- LOAD DỮ LIỆU ---
        void LoadData()
        {
            var query = from o in db.Orders
                        join v in db.Vehicles on o.VehicleID equals v.VehicleID into vGroup
                        from veh in vGroup.DefaultIfEmpty()
                        join c in db.Customers on o.CustomerID equals c.CustomerID into cGroup
                        from cust in cGroup.DefaultIfEmpty()

                        orderby o.OrderID descending
                        select new
                        {
                            o.OrderID,
                            o.OrderStatus,
                            o.RentalDate,
                            o.ReturnDate,
                            o.TotalPrice,

                            LicensePlate = (veh != null) ? veh.LicensePlate : "---",
                            VehicleName = (veh != null) ? veh.NameVehicle : "---",
                            CarImage = (veh != null) ? veh.Image : "",
                            CustomerName = (cust != null) ? cust.Username : "---"
                        };

            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                string key = txtSearch.Text.Trim();
                query = query.Where(x => x.CustomerName.Contains(key) || x.LicensePlate.Contains(key));
            }

            if (ddlFilterStatus.SelectedValue != "All")
            {
                string selectedStatus = ddlFilterStatus.SelectedValue;

                // KIỂM TRA ĐẶC BIỆT CHO TRẠNG THÁI "CHỜ DUYỆT"
                // Giả sử Value của item "Chờ duyệt" trong DropDownList bạn đặt là "Pending"
                if (selectedStatus == "Pending")
                {
                    // Lọc các dòng mà OrderStatus trong DB là NULL hoặc Rỗng
                    query = query.Where(x => x.OrderStatus == null || x.OrderStatus == "");
                }
                else
                {
                    // Các trạng thái khác (Approved, Completed...) so sánh bình thường
                    query = query.Where(x => x.OrderStatus == selectedStatus);
                }
            }

            gvOrders.DataSource = query.ToList();
            gvOrders.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvOrders.PageIndex = 0;
            LoadData();
        }

        // --- XỬ LÝ LOGIC NÚT BẤM ---
        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                var order = db.Orders.SingleOrDefault(o => o.OrderID == orderId);

                if (order != null)
                {
                    var car = db.Vehicles.SingleOrDefault(v => v.VehicleID == order.VehicleID);

                    // 1. DUYỆT ĐƠN (Approved) -> Xe chuyển sang "Đã cho thuê" (true)
                    if (e.CommandName == "ApproveOrder")
                    {
                        order.OrderStatus = "Approved";
                        if (car != null) car.VehicleStatus = true;
                    }
                    // 2. HOÀN TẤT (Completed) -> Xe chuyển sang "Chưa cho thuê" (false)
                    else if (e.CommandName == "CompleteOrder")
                    {
                        order.OrderStatus = "Completed";
                        if (car != null) car.VehicleStatus = false;
                    }
                    // 3. HỦY ĐƠN (Cancelled) -> Xe chuyển sang "Chưa cho thuê" (false)
                    else if (e.CommandName == "CancelOrder")
                    {
                        order.OrderStatus = "Cancelled";
                        if (car != null) car.VehicleStatus = false;
                    }

                    db.SubmitChanges();
                    LoadData();
                    lblMessage.Text = "Cập nhật trạng thái thành công!";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi thao tác: " + ex.Message;
            }
        }

        protected void gvOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int orderId = Convert.ToInt32(gvOrders.DataKeys[e.RowIndex].Value);
                var order = db.Orders.SingleOrDefault(o => o.OrderID == orderId);
                if (order != null)
                {
                    db.Orders.DeleteOnSubmit(order);
                    db.SubmitChanges();
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi xóa: " + ex.Message;
            }
        }

        protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvOrders.PageIndex = e.NewPageIndex;
            LoadData();
        }
    }
}