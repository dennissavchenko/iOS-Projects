using Books.DTOs;
using Books.Entities;

namespace Books.Services;

public interface IGenreService
{
    public Task<IEnumerable<GenreDto>> GetGenresAsync();
}