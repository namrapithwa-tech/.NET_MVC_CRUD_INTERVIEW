using Microsoft.AspNetCore.Mvc;
using NET_MVC_CRUD_INTERVIEW.Models;
using System.Data;
using System.Data.SqlClient;

namespace NET_MVC_CRUD_INTERVIEW.Controllers
{
    public class UserController : Controller
    {
        private IConfiguration configuration;
        #region Configuration
        public UserController(IConfiguration _configuration)
        {
            configuration = _configuration;
        }
        #endregion
        #region UserRegister
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public IActionResult UserRegister(UserModel userRegisterModel)
        {
            try {
                if (ModelState.IsValid)
                {
                    string connectionString = this.configuration.GetConnectionString("ConnectionString");
                    SqlConnection connection = new SqlConnection(connectionString); 
                    connection.Open();
                    SqlCommand command = connection.CreateCommand();
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "PR_User_Register";
                    command.Parameters.AddWithValue("@UserName", userRegisterModel.UserName);
                    command.Parameters.AddWithValue("@Password", userRegisterModel.Password);
                    command.Parameters.AddWithValue("@Email", userRegisterModel.Email);
                    command.Parameters.AddWithValue("@MobileNo", userRegisterModel.MobileNo);
                    command.Parameters.AddWithValue("@Address", userRegisterModel.Address);
                    command.ExecuteNonQuery();
                    TempData["SuccessMessage"] = "User Registered Successfully..!!";
                    return RedirectToAction("Login");
                }
            }
            catch (Exception e)
            {
                TempData["ErrorMessage"] = e.Message;
                return RedirectToAction("Register");
            }
            return RedirectToAction("Register");
        }
        #endregion

        #region UserLogin
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult UserLogin(UserLoginModel loginModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string connectionString = this.configuration.GetConnectionString("ConnectionString");
                    SqlConnection connection = new SqlConnection(connectionString);
                    connection.Open();
                    SqlCommand command = connection.CreateCommand();
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandText = "PR_User_Login";
                    command.Parameters.AddWithValue("@UserName", loginModel.UserName);
                    command.Parameters.AddWithValue("@Password", loginModel.Password);

                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        TempData["SuccessMessage"] = "Login Successful..!!";
                        return RedirectToAction("ProductListPage",  "Product"); // Redirect to Dashboard or appropriate page
                    }
                    else
                    {
                        TempData["ErrorMessage"] = "Invalid Username or Password.";
                        return RedirectToAction("Login");
                    }
                }
            }
            catch (Exception e)
            {
                TempData["ErrorMessage"] = e.Message;
            }
            return RedirectToAction("Login");
        }
        #endregion

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login");
        }
    }
}
