
namespace Models;

public class Address
{
    //Individual Id
    public Guid AddressId { get; set; }
 
    //Model properties
    public  string StreetAddress { get; set; }
    public int ZipCode { get; set; }
    public string City { get; set; }
    public string Country { get; set; }

    //Model relationships
    public List<Friend> Residents { get; set; } = null;
}


