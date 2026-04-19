namespace Models;

public enum MusicGenre {Rock, Blues, Jazz, Metal}
public class MusicGroup
{
    public Guid MusicGroupId { get; set; }
    public string Name { get; set; }
    public int EstablishedYear { get; set; }

    public MusicGenre Genre { get; set; }

    //Model relationships
    public List<Album> Albums { get; set; } = new List<Album>();
    public List<Artist> Artists { get; set; } = new List<Artist>();
}


