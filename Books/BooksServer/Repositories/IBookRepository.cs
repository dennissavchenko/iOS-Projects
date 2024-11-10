using Books.Entities;

namespace Books.Repositories;

public interface IBookRepository
{
    public Task<IEnumerable<Book>> GetBooksAsync();
    public Task AddBookAsync(Book book);
    public Task DeleteBookAsync(int bookId);
    public Task<bool> BookExistsAsync(int bookId);
    public Task UpdateBookAsync(Book book);
    public Task<IEnumerable<Book>> GetAuthorBooksAsync(int authorId);
}