using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class SiteStaff : System.Web.UI.MasterPage
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra đăng nhập
                if (Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();
                    LoadUserInfo(username);
                }
                else
                {
                    // Chưa đăng nhập thì chuyển về trang Login
                    Response.Redirect("LoginPage.aspx");
                }
            }
        }
        private void LoadUserInfo(string username)
        {
            try
            {
                // 1. Tìm trong bảng STAFF (Nhân viên/Admin)
                var staff = db.Staffs.SingleOrDefault(s => s.Username == username);

                if (staff != null)
                {
                    // Hiển thị Fullname
                    lblUsername.Text = staff.Fullname;
                    // Hiển thị Position (Chức vụ) lấy từ DB
                    lblPosition.Text = staff.Position;
                }
                else
                {
                    // 2. Nếu không phải Staff, tìm trong bảng CUSTOMER (Khách hàng)
                    var customer = db.Customers.SingleOrDefault(c => c.Username == username);
                    if (customer != null)
                    {
                        lblUsername.Text = customer.Fullname;
                        lblPosition.Text = "Khách hàng"; // Khách hàng không có cột chức vụ nên gán cứng
                    }
                    else
                    {
                        // Trường hợp có Session nhưng không tìm thấy trong DB
                        lblUsername.Text = username;
                        lblPosition.Text = "Unknown";
                    }
                }
            }
            catch (Exception)
            {
                lblUsername.Text = "Error";
                lblPosition.Text = "---";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xóa Session và đăng xuất
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LoginPage.aspx");
        }
    }
}