namespace Models;

public class Quote 
{
    //Individual Id
    public Guid QuoteId { get; set; }

    //Model properties
    public string QuoteText { get; set; }
    public string Author { get; set; }

    //Model relationships
    public List<Friend> Friends { get; set; } = null;
}


