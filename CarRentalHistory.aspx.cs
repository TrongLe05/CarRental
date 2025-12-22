using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class CarRentalHistory : System.Web.UI.Page
    {
        Data_CarRentalDataContext db =new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvOrders.PageIndex = e.NewPageIndex;
            LoadData();
        }
        void LoadData()
        {
            int getCustID = db.Customers.Where(c => c.Username == Session["Username"].ToString()).Select(c => c.CustomerID).SingleOrDefault();

            var query = from o in db.Orders
                        join v in db.Vehicles on o.VehicleID equals v.VehicleID into vGroup
                        from veh in vGroup.DefaultIfEmpty()
                        join c in db.Customers on o.CustomerID equals c.CustomerID into cGroup
                        from cust in cGroup.DefaultIfEmpty()
                        where cust.CustomerID == getCustID
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
                            CustomerName = (cust != null) ? cust.Username : "---",
                        };

            if (!string.IsNullOrWhiteSpace(txtDateFind.Text))
            {
                DateTime dateFind = DateTime.Parse(txtDateFind.Text);
                query = query.Where(x => x.RentalDate == dateFind);
                if (!query.Any())
                {
                    lblMessage.Text = "Không có dữ liệu thuê xe vào ngày " + DateTime.Parse(txtDateFind.Text).ToString("dd-MM-yyyy");
                }
                else
                {
                    lblMessage.Text = "";
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            var getCustID = from cus in db.Customers where cus.Username == Session["Username"].ToString() select cus.CustomerID;
            lblMessage.Text = getCustID.GetType().ToString();
        }

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
    }
}