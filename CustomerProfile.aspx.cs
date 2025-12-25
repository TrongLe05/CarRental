using DataAccess;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace CarRental
{
    public partial class CustomerProfile : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            var cus = db.Customers.FirstOrDefault(x => x.Username == Session["Username"].ToString().Trim());
            if (cus != null)
            {
                lblUsername.Text = Session["Username"].ToString();
                txtFullname.Text = cus.Fullname;
                txtPhone.Text = cus.Phone;
                txtCustomerCCCD.Text = cus.CustomerCCCD;
                ddlSex.SelectedIndex = cus.Sex.Contains("Nam") ? 1 : 2;
                txtAddress.Text = cus.Address;
                txtBirthDate.Text = cus.BirthDate.Value.ToString("yyyy-MM-dd");
            }
            else
            {
                clearForm();
            }
        }

        public void clearForm()
        {
            lblUsername.Text = Session["Username"].ToString();
            txtFullname.Text = "";
            txtPhone.Text = "";
            txtCustomerCCCD.Text = "";
            ddlSex.SelectedIndex = 0;
            txtAddress.Text = "";
            txtBirthDate.Text = "";
        }
        public void enableForm()
        {
            txtFullname.Enabled = true;
            txtPhone.Enabled = true;
            txtCustomerCCCD.Enabled = true;
            ddlSex.Enabled = true;
            txtBirthDate.Enabled = true;
            txtAddress.Enabled = true;
        }
        public void disableForm()
        {
            txtFullname.Enabled = false;
            txtPhone.Enabled = false;
            txtCustomerCCCD.Enabled = false;
            ddlSex.Enabled = false;
            txtBirthDate.Enabled = false;
            txtAddress.Enabled = false;
        }
        private bool ValidateInputs()
        {
            if (string.IsNullOrWhiteSpace(txtFullname.Text) ||
                   string.IsNullOrWhiteSpace(txtAddress.Text) ||
                   string.IsNullOrWhiteSpace(txtCustomerCCCD.Text) ||
                   string.IsNullOrWhiteSpace(txtPhone.Text) ||
                   string.IsNullOrWhiteSpace(txtBirthDate.Text) ||
                   ddlSex.SelectedIndex < 1)
            {
                lblMassage.Text = "Vui lòng nhập đầy đủ thông tin!";
                return false;
            }

            string phone = txtPhone.Text.Trim();
            if (phone.Length != 10 || !phone.All(char.IsDigit))
            {
                lblMassage.Text = "Số điện thoại phải gồm đúng 10 chữ số!";
                return false;
            }

            return true;
        }
        private void UpdateCustomerInfo(Customer customer)
        {
            customer.Fullname = txtFullname.Text.Trim();
            customer.Phone = txtPhone.Text.Trim();
            customer.CustomerCCCD = txtCustomerCCCD.Text.Trim();
            customer.Sex = ddlSex.SelectedItem.ToString();
            customer.Address = txtAddress.Text.Trim();
            customer.BirthDate = DateTime.Parse(txtBirthDate.Text);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string username = Session["Username"]?.ToString()?.Trim();
                if (string.IsNullOrEmpty(username))
                {
                    lblMassage.Text = "Phiên làm việc hết hạn. Vui lòng đăng nhập lại!";
                    return;
                }

                var acc = db.Accounts.FirstOrDefault(x => x.Username == username);
                if (acc == null)
                {
                    lblMassage.Text = "Tài khoản không tồn tại!";
                    return;
                }

                if (!ValidateInputs())
                {
                    return;
                }

                var customer = db.Customers.FirstOrDefault(c => c.Username == username);
                bool isNewCustomer = (customer == null);

                if (isNewCustomer)
                {
                    customer = new Customer { Username = username };
                    db.Customers.InsertOnSubmit(customer);
                }

                UpdateCustomerInfo(customer);
                db.SubmitChanges();
                disableForm();
                btnSave.Enabled = false;
                lbtnUpdate.Enabled = true;
                lblMassage.Text = "Cập nhật thông tin thành công!";
            }
            catch (Exception ex)
            {
                lblMassage.Text = ex.Message;
            }
        }
        protected void lbtnUpdate_Click(object sender, EventArgs e)
        {
            btnSave.Enabled = true;
            lbtnUpdate.Enabled = false;
            enableForm();
        }
    }
}