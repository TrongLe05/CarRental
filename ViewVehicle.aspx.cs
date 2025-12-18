using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class ViewVehicle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string lp;
            if (Request.QueryString["licensePlate"] != null)
            {
                lp = Request.QueryString["licensePlate"];
                loadData(lp);
            }
        }
        private void loadData(string lp)
        {
            Data_CarRentalDataContext context = new Data_CarRentalDataContext();
            Vehicle vehicle = context.Vehicles.SingleOrDefault(v => v.LicensePlate == lp);
            if (vehicle != null)
            {
                lblNameVehicle.Text = vehicle.NameVehicle;
                lblSeat.Text = vehicle.SeatingCapacity.ToString() + " chỗ";
                lblFuel.Text = vehicle.FuelType;    
                lblPrice.Text = vehicle.Price.ToString() + "VNĐ/ngày";
                imgVehicle.ImageUrl = "~/Image/Vehicle/" + vehicle.Image;
            }
        }
    }
}