namespace Books.DTOs;

public class BookDto
{
    public int Id { get; set; }
    public String Name { get; set; }
    public String Description { get; set; }
    public String ReleaseDate { get; set; }
    public double Price { get; set; }
    public int NumPages { get; set; }
    public int InStock { get; set; }
    public String ImageURL { get; set; }
    public AuthorDto Author { get; set; }
    public IEnumerable<GenreDto> Genres { get; set; }
}