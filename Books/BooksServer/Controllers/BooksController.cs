using Books.DTOs;
using Books.Exceptions;
using Books.Services;
using Microsoft.AspNetCore.Mvc;

namespace Books.Controllers;

[ApiController]
[Route("/api/books")]
public class BooksController : ControllerBase
{
    private readonly IBookService _bookService;

    public BooksController(IBookService bookService)
    {
        _bookService = bookService;
    }

    [HttpGet]
    public async Task<IActionResult> GetBooksAsync()
    {
        var books = await _bookService.GetBooksAsync();
        return Ok(books);
    }
    
    [HttpGet("authors/{authorId:int}")]
    public async Task<IActionResult> GetAuthorBooksAsync(int authorId)
    {
        try
        {
            var books = await _bookService.GetAuthorBooksAsync(authorId);
            return Ok(books);
        }
        catch (NotFoundException e)
        {
            return NotFound(e.Message);
        }
    }
    
    [HttpPost]
    public async Task<IActionResult> AddBookAsync([FromBody] BookDto newBook)
    {
        try
        {
            await _bookService.AddBookAsync(newBook);
            return StatusCode(StatusCodes.Status201Created);
        }
        catch (BadRequestException e)
        {
            return BadRequest(e.Message);
        }
    }
    
    [HttpDelete("{bookId:int}")]
    public async Task<IActionResult> DeleteBookAsync(int bookId)
    {
        try
        {
            await _bookService.DeleteBookAsync(bookId);
            return StatusCode(StatusCodes.Status204NoContent);
        }
        catch (NotFoundException e)
        {
            return NotFound(e.Message);
        }
    }
    
    [HttpPut]
    public async Task<IActionResult> UpdateBookAsync([FromBody] BookDto updatedBook)
    {
        try
        {
            await _bookService.UpdateBookAsync(updatedBook);
            return StatusCode(StatusCodes.Status204NoContent);
        }
        catch (BadRequestException e)
        {
            return BadRequest(e.Message);
        }
        
    }
    
}