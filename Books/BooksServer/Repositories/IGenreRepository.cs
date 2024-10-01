using Books.Entities;

namespace Books.Repositories;

public interface IGenreRepository
{
    public Task<IEnumerable<Genre>> GetGenresAsync();
    public Task<Genre> GetGenreAsync(int idGenre);
    public Task<bool> GenreExistsAsync(int idGenre);
}