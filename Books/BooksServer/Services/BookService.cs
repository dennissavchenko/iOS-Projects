using Books.DTOs;
using Books.Entities;
using Books.Repositories;
using Books.Exceptions;

namespace Books.Services;

public class BookService : IBookService
{
    private readonly IBookRepository _bookRepository;
    private readonly IGenreRepository _genreRepository;
    private readonly IAuthorRepository _authorRepository;

    public BookService(IBookRepository bookRepository, IGenreRepository genreRepository, IAuthorRepository authorRepository)
    {
        _bookRepository = bookRepository;
        _genreRepository = genreRepository;
        _authorRepository = authorRepository;
    }

    public async Task<IEnumerable<BookDto>> GetBooksAsync()
    {
        var books = await _bookRepository.GetBooksAsync();

        var booksDto = books.Select(x => new BookDto
        {
            Id = x.IdBook,
            Name = x.Name,
            Description = x.Description,
            ReleaseDate = x.ReleaseDate.ToString("yyyy-MM-dd"),
            ImageURL = x.ImageURL,
            InStock = x.InStock,
            NumPages = x.NumPages,
            Price = x.Price,
            Author = new AuthorDto
            {
                Id = x.Author.IdAuthor,
                Name = x.Author.Name,
                Surname = x.Author.Surname
            },
            Genres = x.Genres.Select(a => new GenreDto
            {
                Id = a.IdGenre,
                Name = a.Name
            }).ToList()
        }).ToList();
        return booksDto;
    }

    public async Task AddBookAsync(BookDto book)
    {
        
        var genres = new List<Genre>();
        
        foreach (var a in book.Genres)
        {
            if (!await _genreRepository.GenreExistsAsync(a.Id))
            {
                throw new BadRequestException("Genre with ID " + a.Id + " does not exist!");
            }
            
            genres.Add(await _genreRepository.GetGenreAsync(a.Id));
            
        }

        if (!await _authorRepository.AuthorExistsAsync(book.Author.Id))
        {
            throw new BadRequestException("Author with ID " + book.Author.Id + " does not exist!");
        }
        
        var newBook = new Book
        {
            Name = book.Name,
            Description = book.Description,
            ReleaseDate = DateTime.Parse(book.ReleaseDate),
            ImageURL = book.ImageURL,
            InStock = book.InStock,
            NumPages = book.NumPages,
            Price = book.Price,
            IdAuthor = book.Author.Id,
            Genres = genres
        };
        await _bookRepository.AddBookAsync(newBook);
    }

    public async Task DeleteBookAsync(int bookId)
    {
        if (!await _bookRepository.BookExistsAsync(bookId))
        {
            throw new NotFoundException("Book with such an ID was not found!");
        }

        await _bookRepository.DeleteBookAsync(bookId);

    }

    public async Task UpdateBookAsync(BookDto book)
    {
        
        var genres = new List<Genre>();
        
        foreach (var a in book.Genres)
        {
            
            Console.WriteLine(a.Name);
            if (!await _genreRepository.GenreExistsAsync(a.Id))
            {
                throw new NotFoundException("Genre with ID " + a.Id + " does not exist!");
            }
            
            genres.Add(await _genreRepository.GetGenreAsync(a.Id));
            
        }
        
        if (!await _bookRepository.BookExistsAsync(book.Id))
        {
            throw new BadRequestException("Book was not found!");
        }

        var updatedBook = new Book
        {
            IdBook = book.Id,
            Name = book.Name,
            Description = book.Description,
            ReleaseDate = DateTime.Parse(book.ReleaseDate),
            ImageURL = book.ImageURL,
            InStock = book.InStock,
            NumPages = book.NumPages,
            Price = book.Price,
            IdAuthor = book.Author.Id,
            Genres = genres
        };

        await _bookRepository.UpdateBookAsync(updatedBook);

    }

    public async Task<IEnumerable<BookDto>> GetAuthorBooksAsync(int authorId)
    {
        if (!await _authorRepository.AuthorExistsAsync(authorId))
        {
            throw new NotFoundException("Author with such an ID was not found!");
        }

        var books = await _bookRepository.GetAuthorBooksAsync(authorId);

        var booksDto = books.Select(x => new BookDto
        {
            Id = x.IdBook,
            Name = x.Name,
            Description = x.Description,
            ReleaseDate = x.ReleaseDate.ToString("yyyy-MM-dd"),
            ImageURL = x.ImageURL,
            InStock = x.InStock,
            NumPages = x.NumPages,
            Price = x.Price,
            Author = new AuthorDto
            {
                Id = x.Author.IdAuthor,
                Name = x.Author.Name,
                Surname = x.Author.Surname
            },
            Genres = x.Genres.Select(a => new GenreDto
            {
                Id = a.IdGenre,
                Name = a.Name
            }).ToList()
        }).ToList();
        
        return booksDto;

    }
    
}