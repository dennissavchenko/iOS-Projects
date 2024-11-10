using Books.Context;
using Books.Entities;
using Microsoft.EntityFrameworkCore;

namespace Books.Repositories;

public class GenreRepository: IGenreRepository
{
    private readonly BooksContext _booksContext;

    public GenreRepository(BooksContext booksContext)
    {
        _booksContext = booksContext;
    }

    public async Task<IEnumerable<Genre>> GetGenresAsync()
    {
        return await _booksContext.Genres.ToListAsync();
    }

    public async Task<Genre> GetGenreAsync(int idGenre)
    {
        return await _booksContext.Genres.SingleAsync(x => x.IdGenre == idGenre);
    }

    public async Task<bool> GenreExistsAsync(int idGenre)
    {
        return await _booksContext.Genres.AnyAsync(x => x.IdGenre == idGenre);
    }
}