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
    public partial class SignUp : System.Web.UI.Page
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
            if (txtUsername.Text == "")
            {
                lblMessage.Text = "Nhập username!";
                txtUsername.Focus();
            }
            else if (txtPassword.Text == "")
            {
                lblMessage.Text = "Nhập password!";
                txtPassword.Focus();
            }
            else
            {
                string username = txtUsername.Text;
                string password = MD5(txtPassword.Text);
                string rePassword = MD5(txtPasswordRe.Text);
                Data_CarRentalDataContext context = new Data_CarRentalDataContext();
                var findAccount = context.Accounts.SingleOrDefault(a => a.Username == username);
                if (findAccount == null)
                {
                    if (password != rePassword)
                    {
                        lblMessage.Text = "Mật khẩu nhập lại không trùng khớp!";
                        txtPassword.Text = "";
                        txtPasswordRe.Text = "";
                        txtPassword.Focus();
                        return;
                    }
                    try
                    {
                        Account newAccount = new Account
                        {
                            Username = username,
                            Password = password,
                            Permission = 3,
                            AccountStatus = true
                        };
                        context.Accounts.InsertOnSubmit(newAccount);
                        context.SubmitChanges();
                        lblMessage.Text = "Đăng ký thành công!";
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = ex.Message;
                    }
                }
                else
                {
                    lblMessage.Text = "Tài khoản đã tồn tại!";
                    return;
                }
            }

        }

        protected void lbtnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }
    }
}