using Microsoft.AspNetCore.Mvc;
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

        #endregion
    }
}
