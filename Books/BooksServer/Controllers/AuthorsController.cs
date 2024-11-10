using Books.Services;
using Microsoft.AspNetCore.Mvc;

namespace Books.Controllers;

[ApiController]
[Route("/api/authors")]
public class AuthorsController : ControllerBase
{
    private readonly IAuthorService _authorService;

    public AuthorsController(IAuthorService authorService)
    {
        _authorService = authorService;
    }

    [HttpGet]
    public async Task<IActionResult> GetAuthorsAsync()
    {
        var authors = await _authorService.GetAuthorsAsync();
        return Ok(authors);
    }
    
}