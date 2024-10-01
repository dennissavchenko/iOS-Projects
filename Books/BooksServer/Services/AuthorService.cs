using Books.DTOs;
using Books.Repositories;

namespace Books.Services;

public class AuthorService: IAuthorService
{
    private readonly IAuthorRepository _authorRepository;

    public AuthorService(IAuthorRepository authorRepository)
    {
        _authorRepository = authorRepository;
    }

    public async Task<IEnumerable<AuthorDto>> GetAuthorsAsync()
    {
        var authors =  await _authorRepository.GetAuthorsAsync();
        return authors.Select(x => new AuthorDto
        {
            Id = x.IdAuthor,
            Name = x.Name,
            Surname = x.Surname
        }).ToList();
    }
    
}