namespace Books.Entities;

public class Genre
{
    public int IdGenre { get; set; }
    public String Name { get; set; }
    public virtual ICollection<Book> Books { get; set; }
}