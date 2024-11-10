using Books.Services;
using Microsoft.AspNetCore.Mvc;

namespace Books.Controllers;

[ApiController]
[Route("/api/genres")]
public class GenresController : ControllerBase
{
    private readonly IGenreService _genreService;

    public GenresController(IGenreService genreService)
    {
        _genreService = genreService;
    }

    [HttpGet]
    public async Task<IActionResult> GetGenresAsync()
    {
        var genres = await _genreService.GetGenresAsync();
        return Ok(genres);
    }
    
}