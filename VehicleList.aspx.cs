using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class VehicleList : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowPage();
        }

        public void ShowPage()
        {
            
            var vehicle = from p in db.Vehicles.Where(v => v.VehicleStatus == false).OrderBy(v => v.NameVehicle)
                          select p;
            DataList1.DataSource = vehicle;
            DataList1.DataBind();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Rent")
            {
                string vehicleId = e.CommandArgument.ToString();

                // Chuyển đến trang thanh toán
                Response.Redirect("PaymentPage.aspx?VehicleID=" + vehicleId);
            }
        }
    }
}