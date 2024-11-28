using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace BT27._11
{
    public partial class frmThemDV : Form
    {
        public frmThemDV()
        {
            InitializeComponent();
        }
        private void frmThemDV_Load(object sender, EventArgs e)
        {
            this.Invalidate();
        }
        private void InitValues()
        {
            string connectionString = "server=.; database = QuanLyDichVuKhachSan; Integrated Security = true;";
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "SELECT ID_LoaiDV, TenDV FROM DichVu";

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            conn.Open();

            adapter.Fill(ds, "DichVu");

            cbbLoaiDV.DataSource = ds.Tables["DichVu"];
            cbbLoaiDV.DisplayMember = "TenLoaiDV";
            cbbLoaiDV.ValueMember = "ID_LoaiDV";

            conn.Close();
            conn.Dispose();
        }
        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = "server=PC328\\SQLEXPRESS; database= QuanLyDichVuKhachSan; Integrated Security = true; ";
                SqlConnection conn = new SqlConnection(connectionString);

                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "EXECUTE InsertDV @id OUTPUT, @ten";


                cmd.Parameters.Add("@id", SqlDbType.NVarChar, 100);
                cmd.Parameters.Add("@ten", SqlDbType.NVarChar, 1000);

                cmd.Parameters["@id"].Direction = ParameterDirection.Output;

                // Truyền giá trị vào thủ tục qua tham số
                cmd.Parameters["@id"].Value = txtMaDV.Text;
                cmd.Parameters["@ten"].Value = txtTenMatHang.Text;

                // mở kết nối
                conn.Open();
                int numRowAffected = cmd.ExecuteNonQuery();

                // Thông báo kết quả
                if (numRowAffected > 0)
                {
                    string dichvuID = cmd.Parameters["@id"].Value.ToString();

                    MessageBox.Show("Successfully adding new food, DV ID = " + dichvuID, "Message");

                    this.ResetText();
                }
                else
                {
                    MessageBox.Show("Adding food failed");
                }

                // đóng kết nối
                conn.Close();
                conn.Dispose();
            }

            // Bắt lỗi SQL và các lỗi khác
            catch (SqlException exception)
            {
                MessageBox.Show(exception.Message, "SQL Eccor");
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message, "Error");
            }

        }
    }
}
