namespace Books.Entities;

public class Book
{
    public int IdBook { get; set; }
    public String Name { get; set; }
    public String Description { get; set; }
    public DateTime ReleaseDate { get; set; }
    public double Price { get; set; }
    public int NumPages { get; set; }
    public int InStock { get; set; }
    public String ImageURL { get; set; }
    public int IdAuthor { get; set; }
    public virtual Author Author { get; set; }
    public virtual ICollection<Genre> Genres { get; set; }
}