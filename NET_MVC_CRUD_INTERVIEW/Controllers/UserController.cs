using Microsoft.AspNetCore.Mvc;

namespace NET_MVC_CRUD_INTERVIEW.Controllers
{
    public class UserController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
