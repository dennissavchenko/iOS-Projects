using Books.DTOs;

namespace Books.Services;

public interface IBookService
{
    public Task<IEnumerable<BookDto>> GetBooksAsync();
    public Task AddBookAsync(BookDto book);
    public Task DeleteBookAsync(int bookId);
    public Task UpdateBookAsync(BookDto book);
    public Task<IEnumerable<BookDto>> GetAuthorBooksAsync(int authorId);
}