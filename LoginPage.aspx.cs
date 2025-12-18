using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string MD5(string str)
        {
            Byte[] pass = Encoding.UTF8.GetBytes(str);
            MD5 md5 = new MD5CryptoServiceProvider();
            string strPassword = Encoding.UTF8.GetString(md5.ComputeHash(pass));
            return strPassword;
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = MD5(txtPassword.Text);

            Data_CarRentalDataContext context = new Data_CarRentalDataContext();

            // Giữ nguyên dòng lệnh tìm kiếm cũ của bạn
            var account = context.Accounts.FirstOrDefault(a => a.Username == username && a.Password == password);

            if (account != null)
            {
                // --- BẮT ĐẦU ĐOẠN VIẾT THÊM ---
                // Kiểm tra xem tài khoản có bị khóa không (Giả sử 0/False là khóa)
                if (account.AccountStatus == false)
                {
                    lblMessage.Text = "Tài khoản đang bị khóa. Vui lòng liên hệ Admin.";
                    return; // Dừng lại, không cho chạy xuống đoạn chuyển trang
                }
                // --- KẾT THÚC ĐOẠN VIẾT THÊM ---

                if (account.Permission == 1)
                {
                    Response.Redirect("AdminDashboard.aspx");
                }
                else if (account.Permission == 2)
                {
                    Session["Username"] = txtUsername.Text;
                    Response.Redirect("StaffDashboard.aspx");
                }
                else if (account.Permission == 3)
                {
                    Session["Username"] = txtUsername.Text;
                    Response.Redirect("VehicleList.aspx");
                }
                else
                {
                    lblMessage.Text = "Unknown role.";
                }
            }
            else
            {
                // Failed login
                lblMessage.Text = "Invalid username or password.";
            }
        }

        protected void lbtnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUpPage.aspx");
        }
    }
}