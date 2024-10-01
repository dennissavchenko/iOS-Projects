using Books.DTOs;
using Books.Repositories;

namespace Books.Services;

public class GenreService: IGenreService
{
    private readonly IGenreRepository _genreRepository;

    public GenreService(IGenreRepository genreRepository)
    {
        _genreRepository = genreRepository;
    }

    public async Task<IEnumerable<GenreDto>> GetGenresAsync()
    {
        var genres =  await _genreRepository.GetGenresAsync();

        return genres.Select(x => new GenreDto
        {
            Id = x.IdGenre,
            Name = x.Name
        }).ToList();
    }
    
}