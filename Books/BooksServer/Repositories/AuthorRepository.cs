using Books.Context;
using Books.Entities;
using Microsoft.EntityFrameworkCore;

namespace Books.Repositories;

public class AuthorRepository: IAuthorRepository
{
    private readonly BooksContext _booksContext;

    public AuthorRepository(BooksContext booksContext)
    {
        _booksContext = booksContext;
    }
    
    public async Task<IEnumerable<Author>> GetAuthorsAsync()
    {
        return await _booksContext.Authors.ToListAsync();
    }

    public async Task<bool> AuthorExistsAsync(int authorId)
    {
        return await _booksContext.Authors.AnyAsync(x => x.IdAuthor == authorId);
    }
}