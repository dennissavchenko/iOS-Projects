using Books.DTOs;

namespace Books.Services;

public interface IAuthorService
{
    public Task<IEnumerable<AuthorDto>> GetAuthorsAsync();
}