using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.LinkLabel;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ProgressBar;

namespace BT27._11
{
    public partial class frmDanhSachDVKS : Form
    {
        public frmDanhSachDVKS()
        {
            InitializeComponent();
        }
        private DataTable dichvuTable;
        private void frmDanhSachDVKS_Load(object sender, EventArgs e)
        {
            this.LoadDichVu();
        }
        private void LoadDichVu()
        { 
            string connectionString = "server=PC328\\SQLEXPRESS; database = QuanLyDichVuKhachSan; Integrated Security = true;";
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT ID_LoaiDV, TenLoai FROM LoaiDV";

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            conn.Open();

            adapter.Fill(dt);

            conn.Close();
            conn.Dispose();

            cbbLoaiDV.DataSource = dt;

            cbbLoaiDV.DisplayMember = "TenDV";

            cbbLoaiDV.ValueMember = "ID_LoaiDV";

        }

        private void txtSearchByName_TextChanged(object sender, EventArgs e)
        {
            if (dichvuTable == null) return;
            string filterExpression = "Name like '%" + txtSearchByName.Text + "%'";
            string sortExpression = "Price DESC";
            DataViewRowState rowStateFilter = DataViewRowState.OriginalRows;
            DataView dataView = new DataView(dichvuTable, filterExpression, sortExpression, rowStateFilter);
            dgvDanhSachDichVu.DataSource = dataView;
        }

        private void cbbLoaiDV_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbbLoaiDV.SelectedIndex == -1) return;

            string connectionString = "server=PC328\\SQLEXPRESS; database = QuanLyDichVuKhachSan; Integrated Security = true; ";
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT * FROM LoaiDV WHERE ID_LoaiDV = @id";

            // Truyền tham số
            cmd.Parameters.Add("@id", SqlDbType.Int);

            if (cbbLoaiDV.SelectedValue is DataRowView)
            {
                DataRowView rowView = cbbLoaiDV.SelectedValue as DataRowView;
                cmd.Parameters["@id"].Value = rowView["ID_LoaiDV"];
            }
            else
            {
                cmd.Parameters["@id"].Value = cbbLoaiDV.SelectedValue;
            }
            // Tạo bộ điều phiếu dữ liệu
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            dichvuTable = new DataTable();

            // Mở kết nối
            conn.Open();

            // Lấy dữ liệu từ csdl đưa vào DataTable
            adapter.Fill(dichvuTable);

            // Đóng kết nối và giải phóng bộ nhớ
            conn.Close();
            conn.Dispose();

            // Đưa dữ liệu vào data gridview
            dgvDanhSachDichVu.DataSource = dichvuTable;

            // Tính số lượng mẫu tin
            lblTongDichVu.Text = dichvuTable.Rows.Count.ToString();
            lblLoaiDV.Text = cbbLoaiDV.Text;
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void label_Click(object sender, EventArgs e)
        {

        }
    }
}
