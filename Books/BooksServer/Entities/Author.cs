namespace Books.Entities;

public class Author
{
    public int IdAuthor { get; set; }
    public String Name { get; set; }
    public String Surname { get; set; }
    public virtual ICollection<Book> Books { get; set; }
}