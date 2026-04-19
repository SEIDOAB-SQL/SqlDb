namespace Models;
public class Artist
{
    public Guid ArtistId { get; set; }

    public string FirstName { get; set; }
    public string LastName { get; set; }

    public DateTime? BirthDay { get; set; }

    //Model relationships
    public List<MusicGroup> MusicGroups { get; set; } = new List<MusicGroup>();
}


