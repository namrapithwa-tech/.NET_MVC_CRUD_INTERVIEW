using System.ComponentModel.DataAnnotations;

namespace NET_MVC_CRUD_INTERVIEW.Models
{
    public class ProductModel
    {
        public int? ProductId { get; set; }
        [Required]
        public string ProductName { get; set; }
        [Required]
        public decimal ProductPrice { get; set; }
        [Required]
        public string ProductCode { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public int UserID { get; set; }

    }

    public class ProductDropdownModel
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
    }
}
