using DataAccess;
using System;
using System.Collections.Generic;
using System.IO; // Thêm thư viện này để xử lý file ảnh
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class StaffDashboard : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            LoadData();
            //}
        }

        // --- HÀM LOAD DỮ LIỆU ĐA NĂNG (TÌM KIẾM + LỌC) ---
        void LoadData()
        {
            var query = from v in db.Vehicles select v;

            // 1. Tìm kiếm theo tên hoặc biển số
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                string key = txtSearch.Text.Trim();
                query = query.Where(v => v.NameVehicle.Contains(key) || v.LicensePlate.Contains(key));
            }

            // 2. Lọc theo Loại nhiên liệu
            if (ddlFilterFuel.SelectedValue != "All")
            {
                query = query.Where(v => v.FuelType == ddlFilterFuel.SelectedValue);
            }

            // 3. Lọc theo Trạng thái (0: Chưa thuê, 1: Đã thuê)
            if (ddlFilterStatus.SelectedValue != "-1")
            {
                bool isRented = (ddlFilterStatus.SelectedValue == "1");
                query = query.Where(v => v.VehicleStatus == isRented);
            }

            // Sắp xếp mặc định
            query = query.OrderByDescending(v => v.VehicleID);

            gvStaff.DataSource = query.ToList();
            gvStaff.DataBind();
        }

        // --- NÚT TÌM KIẾM ---
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvStaff.PageIndex = 0; // Về trang 1 khi tìm kiếm
            LoadData();
        }

        // --- PHÂN TRANG ---
        protected void gvStaff_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStaff.PageIndex = e.NewPageIndex;
            LoadData();
        }

        // --- XỬ LÝ THÊM MỚI ---
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                var check = db.Vehicles.FirstOrDefault(v => v.LicensePlate == txtNewLicensePlate.Text.Trim());
                if (check != null)
                {
                    lblMessage.Text = "Biển số " + txtNewLicensePlate.Text + " đã tồn tại!";
                    return;
                }

                Vehicle vehicle = new Vehicle();
                // Nếu ID tự tăng thì không cần dòng này, nếu không thì giữ nguyên
                vehicle.VehicleID = (db.Vehicles.Any()) ? db.Vehicles.Max(v => v.VehicleID) + 1 : 1;

                vehicle.LicensePlate = txtNewLicensePlate.Text.Trim();
                vehicle.NameVehicle = txtNewNameVehicle.Text.Trim();
                vehicle.SeatingCapacity = int.Parse(txtNewSeating.Text);
                vehicle.Price = int.Parse(txtNewPrice.Text);
                vehicle.FuelType = ddlFuelType.SelectedValue;
                vehicle.VehicleStatus = false; // Mặc định là Chưa thuê (false)

                // Xử lý Upload Ảnh
                string imagePath = "~/CarImages/No_Image_Available.jpg"; // Ảnh mặc định nếu không up
                if (fuNewImage.HasFile)
                {
                    string fileName = Path.GetFileName(fuNewImage.FileName);
                    // Tạo tên file duy nhất để tránh trùng
                    string uniqueFileName = DateTime.Now.Ticks.ToString() + "_" + fileName;
                    string savePath = Server.MapPath("~/CarImages/") + uniqueFileName;
                    fuNewImage.SaveAs(savePath);
                    imagePath = "~/CarImages/" + uniqueFileName;
                }
                vehicle.Image = imagePath; // Đảm bảo DB có cột VehicleImage

                db.Vehicles.InsertOnSubmit(vehicle);
                db.SubmitChanges();

                // Reset form
                txtNewLicensePlate.Text = "";
                txtNewNameVehicle.Text = "";
                txtNewPrice.Text = "";
                txtNewSeating.Text = "";
                lblMessage.Text = "Thêm xe thành công!";
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi thêm xe: " + ex.Message;
            }
        }

        // --- CHẾ ĐỘ SỬA ---
        protected void gvStaff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStaff.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvStaff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStaff.EditIndex = -1;
            LoadData();
        }

        // --- CẬP NHẬT DỮ LIỆU ---
        protected void gvStaff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string bienSo = gvStaff.DataKeys[e.RowIndex].Value.ToString();

                // Lấy các control trong GridView
                TextBox txtTenXe = (TextBox)gvStaff.Rows[e.RowIndex].Cells[2].Controls[0]; // Cột 2 là Tên xe
                TextBox txtChoNgoi = (TextBox)gvStaff.Rows[e.RowIndex].Cells[3].Controls[0]; // Cột 3 là Số chỗ
                TextBox txtNhienLieu = (TextBox)gvStaff.Rows[e.RowIndex].Cells[4].Controls[0]; // Cột 4 là Nhiên liệu
                TextBox txtGia = (TextBox)gvStaff.Rows[e.RowIndex].Cells[5].Controls[0]; // Cột 5 là Giá

                //CheckBox ckbTrangThai = (CheckBox)gvStaff.Rows[e.RowIndex].FindControl("chkTrangThai");
                FileUpload fuEditImg = (FileUpload)gvStaff.Rows[e.RowIndex].FindControl("fuEditImage");

                var vehicle = db.Vehicles.SingleOrDefault(v => v.LicensePlate == bienSo);

                if (vehicle != null)
                {
                    vehicle.NameVehicle = txtTenXe.Text;
                    vehicle.SeatingCapacity = int.Parse(txtChoNgoi.Text);
                    vehicle.FuelType = txtNhienLieu.Text;
                    vehicle.Price = int.Parse(txtGia.Text);
                    //vehicle.VehicleStatus = ckbTrangThai.Checked;

                    // Xử lý cập nhật ảnh (chỉ đổi nếu người dùng chọn file mới)
                    if (fuEditImg.HasFile)
                    {
                        string fileName = Path.GetFileName(fuEditImg.FileName);
                        string uniqueFileName = DateTime.Now.Ticks.ToString() + "_" + fileName;
                        string savePath = Server.MapPath("~/CarImages/") + uniqueFileName;
                        fuEditImg.SaveAs(savePath);
                        vehicle.Image = "~/CarImages/" + uniqueFileName;
                    }

                    db.SubmitChanges();
                    lblMessage.Text = "Cập nhật thành công!";
                }

                gvStaff.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi cập nhật: " + ex.Message;
            }
        }

        // --- XÓA XE ---
        protected void gvStaff_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string bienSo = gvStaff.DataKeys[e.RowIndex].Value.ToString();
                var vehicle = db.Vehicles.SingleOrDefault(v => v.LicensePlate == bienSo);
                if (vehicle != null)
                {
                    db.Vehicles.DeleteOnSubmit(vehicle);
                    db.SubmitChanges();
                    lblMessage.Text = "Đã xóa xe: " + bienSo;
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi xóa: " + ex.Message;
            }
        }

        // --- XỬ LÝ SỰ KIỆN NÚT (ĐĂNG XE) ---
        protected void gvStaff_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PostVehicle")
            {
                string bienSo = e.CommandArgument.ToString();

                // Kiểm tra lại trạng thái trong DB cho chắc chắn
                var v = db.Vehicles.FirstOrDefault(x => x.LicensePlate == bienSo);

                if (v != null)
                {
                    if (v.VehicleStatus == true) // Đã thuê
                    {
                        lblMessage.Text = "Xe này đang được thuê, không thể đăng!";
                        return;
                    }

                    // Chuyển hướng sang trang chủ (để đăng hoặc xem)
                    Response.Redirect("HomePage.aspx");
                }
            }
        }
    }
}