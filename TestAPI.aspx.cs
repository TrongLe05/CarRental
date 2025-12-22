using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class TestAPI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bankBin = "970432";          // VP Bank
                string accountNo = "0772123133";
                string accountName = "LE MINH TRONG";
                string amount = "100000";
                string note = "Thanh toan don hang 001";

                string qrUrl = $"https://api.vietqr.io/image/{bankBin}-{accountNo}-compact2.png" +
                               $"?amount={amount}" +
                               $"&addInfo={Server.UrlEncode(note)}" +
                               $"&accountName={Server.UrlEncode(accountName)}";

                imgQR.ImageUrl = qrUrl;
            }
        }
    }
}