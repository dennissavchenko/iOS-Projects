using Books.Entities;

namespace Books.Repositories;

public interface IAuthorRepository
{
    public Task<IEnumerable<Author>> GetAuthorsAsync();
    public Task<bool> AuthorExistsAsync(int authorId);
}