namespace Models;

public class Album
{
    public Guid AlbumId { get; set; }

    public string Name { get; set; }
    public int ReleaseYear { get; set; }
    public long CopiesSold { get; set; }

    //Model relationships
    public MusicGroup MusicGroup { get; set; } = null;
}


