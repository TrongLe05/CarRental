using DataAccess;
using System;
using System.Data.Linq;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI;

namespace CarRental
{
    public partial class PaymentPage : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null)
                {
                    Response.Redirect("LoginPage.aspx");
                    return;
                }
                int vehicleId = int.Parse(Request.QueryString["VehicleID"] ?? "1");

                LoadVehicleInfo(vehicleId);
                SetDefaultDates();
                LoadCustomerInfo();
                
                
                if (!ValidateInputs())
                {
                    ShowMessage("Vui lòng cập nhật đầy đủ thông tin hồ sơ!", false);
                    return;
                }
                
            }
        }
        private bool ValidateInputs()
        {
            return !string.IsNullOrWhiteSpace(lblCustomerName.Text) &&
                   !string.IsNullOrWhiteSpace(lblCustomerAddress.Text) &&
                   !string.IsNullOrWhiteSpace(lblCustomerPhone.Text);
        }
        private void LoadCustomerInfo()
        {
            string username = Session["Username"]?.ToString()?.Trim();
            
            try
            {
                var customerInfo = db.Customers.SingleOrDefault(c => c.Username == username);
                if (customerInfo != null)
                {
                    lblCustomerName.Text = customerInfo.Fullname;
                    lblCustomerID.Text = customerInfo.CustomerCCCD;
                    lblCustomerPhone.Text = customerInfo.Phone;
                    lblCustomerAddress.Text = customerInfo.Address;
                }
            }
            catch (Exception ex) 
            {
                lblCustomerName.Text = ex.Message;  
            }
        }

        private void LoadVehicleInfo(int vehicleId)
        {
            try
            {
                var vehicleInfo = db.Vehicles.SingleOrDefault(v => v.VehicleID == vehicleId);
                if (vehicleInfo != null)
                {
                    lblVehicleName.Text = vehicleInfo.NameVehicle;
                    lblSeating.Text = vehicleInfo.SeatingCapacity.ToString();
                    lblFuelType.Text = vehicleInfo.FuelType;
                    lblLicensePlate.Text = vehicleInfo.LicensePlate;
                    lblPricePerDay.Text = string.Format("{0:N0} VNĐ/ngày", vehicleInfo.Price);

                    Session["VehiclePrice"] = vehicleInfo.Price;
                    Session["VehicleID"] = vehicleId;

                    imgVehicle.ImageUrl = "~/Image/Vehicle/" + vehicleInfo.Image;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi: " + ex.Message, false);
            }
        }

        private void SetDefaultDates()
        {
            DateTime today = DateTime.Today;
            txtRentalDate.Text = today.AddDays(1).ToString("yyyy-MM-dd");
            txtReturnDate.Text = today.AddDays(1).ToString("yyyy-MM-dd");
            CalculateTotal(null, null);
        }

        protected void CalculateTotal(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtRentalDate.Text) || string.IsNullOrEmpty(txtReturnDate.Text))
                    return;

                DateTime rentalDate = DateTime.Parse(txtRentalDate.Text);
                DateTime returnDate = DateTime.Parse(txtReturnDate.Text);

                if (returnDate < rentalDate)
                {
                    ShowMessage("Ngày trả xe phải sau ngày nhận xe!", false);
                    return;
                }

                int days = (returnDate - rentalDate).Days;
                if (days == 0)
                {
                    days = 1;
                    lblDuration.Text = "1";
                }
                lblDuration.Text = days.ToString();
                lblDays.Text = days.ToString();

                decimal pricePerDay = Session["VehiclePrice"] != null
                    ? Convert.ToDecimal(Session["VehiclePrice"])
                    : 500000;

                decimal subtotal = pricePerDay * days;
                decimal serviceFee = subtotal * 0.05m;
                decimal insuranceFee = subtotal * 0.03m;
                decimal total = subtotal + serviceFee + insuranceFee;

                lblSubTotal.Text = string.Format("{0:N0} VNĐ", subtotal);
                //lblServiceFee.Text = string.Format("{0:N0} VNĐ", serviceFee);
                //lblInsuranceFee.Text = string.Format("{0:N0} VNĐ", insuranceFee);
                lblTotal.Text = string.Format("{0:N0} VNĐ", total);

                Session["TotalPrice"] = total;
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi: " + ex.Message, false);
            }
        }

        protected void btnConfirmPayment_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime rentalDate = DateTime.Parse(txtRentalDate.Text);
                DateTime returnDate = DateTime.Parse(txtReturnDate.Text);

                int customerId = GetCustomerId(Session["Username"]?.ToString());
                int vehicleId = Convert.ToInt32(Session["VehicleID"]);
                int totalPrice = Convert.ToInt32(Session["TotalPrice"]);

                Order order = new Order();
                var vehicle = db.Vehicles.SingleOrDefault(v => v.VehicleID == vehicleId);

                try
                {
                    order.CustomerID = customerId;
                    order.VehicleID = vehicleId;
                    order.StaffID = 6;
                    order.RentalDate = rentalDate;
                    order.ReturnDate = returnDate;
                    order.TotalPrice = totalPrice;

                    if (vehicle != null)
                    {
                        if (vehicle.VehicleStatus != true)
                        {
                            vehicle.VehicleStatus = true;
                        }
                        else
                        {
                            ShowMessage("Xe hiện đang cho thuê", false);
                        }
                    }
                    else
                    {
                        ShowMessage("Không tìm thấy xe", false);
                        return;
                    }

                    db.Orders.InsertOnSubmit(order);
                    db.SubmitChanges();
                    btnConfirmPayment.Enabled = false;
                    btnConfirmPayment.Text = "Đặt xe thành công!";
                    ShowMessage($"Đặt xe thành công! Mã đơn: {order.OrderID}", true);
                }
                catch (Exception ex)
                {
                    ShowMessage("Lỗi: " + ex.Message, false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi thanh toán: " + ex.Message, false);
            }
        }

        protected void btnChangeAddress_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerProfile.aspx");
        }

        private int GetCustomerId(string username)
        {
            var customer = db.Customers.SingleOrDefault(c => c.Username == username);
            try
            {
                if (customer == null)
                {
                    return 0;
                }
            }
            catch
            {
            }
            return customer.CustomerID;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
            lblMessage.CssClass = isSuccess ? "message success" : "message error";

            ScriptManager.RegisterStartupScript(this, GetType(), "hideMessage",
                "setTimeout(function(){ var msg = document.querySelector('.message'); if(msg) msg.style.display='none'; }, 5000);", true);
        }
    }
}