using Microsoft.AspNetCore.Mvc;
using NET_MVC_CRUD_INTERVIEW.Models;
using System.Data;
using System.Data.SqlClient;

namespace NET_MVC_CRUD_INTERVIEW.Controllers
{
    public class ProductController : Controller
    {
        private IConfiguration configuration;
        #region Configuration
        public ProductController(IConfiguration _configuration)
        {
            configuration = _configuration;
        }
        #endregion

        #region ProductListPage
        public IActionResult ProductListPage()
        {
            string connectionString = this.configuration.GetConnectionString("ConnectionString");
            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "PR_Product_SelectAll";
            SqlDataReader reader = command.ExecuteReader();
            DataTable table = new DataTable();
            table.Load(reader);
            return View(table);
        }
        #endregion

        #region DeleteProduct
        public IActionResult ProductDelete(int ProductId)
        {
            try {
                string connectionString = this.configuration.GetConnectionString("ConnectionString");
                SqlConnection connection = new SqlConnection(connectionString);
                connection.Open();
                SqlCommand command = connection.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "PR_Product_DeleteByPK";
                command.Parameters.AddWithValue("@ProductId", ProductId);
                command.ExecuteNonQuery();
                TempData["SuccessMessage"] = "Product Deleted Successfully..!!";
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                Console.WriteLine(ex.ToString());
            }
            return RedirectToAction("ProductListPage");
        }
        #endregion

        #region Add or Edit Product
        public IActionResult Add_Edit_Product(int? ProductId)
        {
            ProductModel productModel = new ProductModel();
            string connectionString = this.configuration.GetConnectionString("ConnectionString");
            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "PR_Product_SelectByPK";
            command.Parameters.Add("@ProductId", SqlDbType.Int).Value = (object)ProductId ?? DBNull.Value;

            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows && ProductId != null)
            {
                reader.Read();
                productModel.ProductId = Convert.ToInt32(reader["ProductId"]);
                productModel.ProductName = reader["ProductName"].ToString();
                productModel.ProductPrice = Convert.ToDecimal(reader["ProductPrice"]);
                productModel.ProductCode = reader["ProductCode"].ToString();
                productModel.Description = reader["Description"].ToString();
                productModel.UserID = Convert.ToInt32(reader["UserID"]);
            }



            return View(productModel);
        }
        #endregion

        #region SaveProduct

        [HttpPost]
        public IActionResult Save(ProductModel productModel)
        {
            string connectionString = this.configuration.GetConnectionString("ConnectionString");
            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            if (productModel.ProductId == null)
            {
                command.CommandText = "PR_Product_Insert";
            }
            else
            {
                command.CommandText = "PR_Product_UpdateByPK";
                command.Parameters.AddWithValue("@ProductId", productModel.ProductId);
            }
            command.Parameters.AddWithValue("@ProductName", productModel.ProductName);
            command.Parameters.AddWithValue("@ProductPrice", productModel.ProductPrice);
            command.Parameters.AddWithValue("@ProductCode", productModel.ProductCode);
            command.Parameters.AddWithValue("@Description", productModel.Description);
            command.Parameters.AddWithValue("@UserID", productModel.UserID);
            if (command.ExecuteNonQuery() > 0)
            {
                TempData["ProductInsertMessage"] = productModel.ProductId == null ? "Record Inserted Successfully" : "Record Updated Successfully";
            }
            connection.Close();
            return RedirectToAction("ProductListPage");
        }
        #endregion
    }
}