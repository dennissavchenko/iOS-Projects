using Books.Context;
using Books.Entities;
using Microsoft.EntityFrameworkCore;

namespace Books.Repositories;

public class BookRepository : IBookRepository
{
    
    private readonly BooksContext _booksContext;

    public BookRepository(BooksContext booksContext)
    {
        _booksContext = booksContext;
    }
    
    public async Task<IEnumerable<Book>> GetBooksAsync()
    {
        var books = await _booksContext.Books
            .Include(x => x.Author)
            .Include(x => x.Genres)
            .ToListAsync();
        return books;
    }

    public async Task AddBookAsync(Book book)
    {
        await _booksContext.Books.AddAsync(book);
        await _booksContext.SaveChangesAsync();
    }

    public async Task DeleteBookAsync(int bookId)
    {
        var book = await _booksContext.Books.FirstAsync(x => x.IdBook == bookId);
        _booksContext.Books.Remove(book);
        await _booksContext.SaveChangesAsync();

    }

    public async Task<bool> BookExistsAsync(int bookId)
    {
        return await _booksContext.Books.AnyAsync(x => x.IdBook == bookId);
    }

    public async Task UpdateBookAsync(Book updatedBook)
    {
        
        var book = await _booksContext.Books.Include(x => x.Genres).FirstAsync(x => x.IdBook == updatedBook.IdBook);

        book.Name = updatedBook.Name;
        book.Description = updatedBook.Description;
        book.ImageURL = updatedBook.ImageURL;
        book.InStock = updatedBook.InStock;
        book.Price = updatedBook.Price;
        book.Genres.Clear();
        book.Genres = updatedBook.Genres;
        
        await _booksContext.SaveChangesAsync();
        
    }

    public async Task<IEnumerable<Book>> GetAuthorBooksAsync(int authorId)
    {
        var books = await _booksContext.Books
            .Where(x => x.IdAuthor == authorId)
            .Include(x => x.Author)
            .Include(x => x.Genres)
            .ToListAsync();
        return books;
    }
    
}