using DataAccess;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra đăng nhập (tạm bỏ để test)
                if (Session["Username"] == null)
                {
                    Session["Username"] = "customer01"; // Test
                }

                lblUsername.Text = "Xin chào, " + Session["Username"];
                LoadVehicles();
                UpdateStatusBar();
            }
        }

        private void LoadVehicles()
        {
            Data_CarRentalDataContext db = new Data_CarRentalDataContext();

            // Lấy xe có trạng thái khả dụng (VehicleStatus = false)
            var vehicles = from v in db.Vehicles
                           where v.VehicleStatus == false
                           orderby v.NameVehicle
                           select v;

            DataList1.DataSource = vehicles;
            DataList1.DataBind();

            // Hiển thị thông báo nếu không có xe
            pnlEmpty.Visible = !vehicles.Any();
        }

        private void UpdateStatusBar()
        {
            Data_CarRentalDataContext db = new Data_CarRentalDataContext();

            // Tổng số xe
            int totalVehicles = db.Vehicles.Count();
            lblTotalVehicles.Text = totalVehicles.ToString();

            // Xe khả dụng
            int availableVehicles = db.Vehicles.Count(v => v.VehicleStatus == false);
            lblAvailableVehicles.Text = availableVehicles.ToString();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Rent")
            {
                string vehicleId = e.CommandArgument.ToString();

                // Chuyển đến trang thanh toán
                Response.Redirect("PayPage.aspx?VehicleID=" + vehicleId);
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LoginPage.aspx"); // Hoặc trang đăng nhập của bạn
        }
    }
}