namespace Models;

public class Friend
{
    //Individual Id
    public Guid FriendId { get; set; }

    //Model properties
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public DateTime? Birthday { get; set; } = null;


    //Model relationships
    public Address Address { get; set; } = null;  
    public List<Quote> Quotes { get; set; } = null;
    public List<Pet> Pets { get; set; } = null;
}
