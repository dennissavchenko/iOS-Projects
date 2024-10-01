using Microsoft.EntityFrameworkCore;
using Books.Entities;

namespace Books.Context;

public class BooksContext : DbContext
{
    
    public BooksContext(DbContextOptions options): base(options)
    {
        
    }
    
    public DbSet<Author> Authors { get; set; }
    public DbSet<Book> Books { get; set; }
    public DbSet<Genre> Genres { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        
        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(x => x.IdBook);
            entity.ToTable("Book");
            entity
                .Property(x => x.IdBook)
                .ValueGeneratedOnAdd()
                .IsRequired();
            entity
                .Property(x => x.ReleaseDate)
                .IsRequired();
            entity
                .Property(x => x.Name)
                .HasMaxLength(100)
                .IsRequired();
            entity
                .Property(x => x.Description)
                .HasMaxLength(300)
                .IsRequired();
            entity
                .Property(x => x.ImageURL)
                .HasMaxLength(300)
                .IsRequired();
            entity
                .Property(x => x.Price)
                .IsRequired();
            entity
                .Property(x => x.InStock)
                .IsRequired();
            entity
                .HasOne(x => x.Author)
                .WithMany(x => x.Books)
                .HasForeignKey(x => x.IdAuthor);
            entity
                .HasMany(x => x.Genres)
                .WithMany(x => x.Books)
                .UsingEntity(
                    "BooksGenres",
                    r => r.HasOne(typeof(Genre)).WithMany().HasForeignKey("IdGenre"),
                    l => l.HasOne(typeof(Book)).WithMany().HasForeignKey("IdBook"),
                    j => j.HasKey("IdBook", "IdGenre"));
        });
        
        modelBuilder.Entity<Genre>(entity =>
        {
            entity.HasKey(x => x.IdGenre);
            entity.ToTable("Genre");
            entity
                .Property(x => x.IdGenre)
                .ValueGeneratedOnAdd()
                .IsRequired();
            entity
                .Property(x => x.Name)
                .HasMaxLength(100)
                .IsRequired();
        });
        
        modelBuilder.Entity<Author>(entity =>
        {
            entity.HasKey(x => x.IdAuthor);
            entity.ToTable("Author");
            entity
                .Property(x => x.IdAuthor)
                .ValueGeneratedOnAdd()
                .IsRequired();
            entity
                .Property(x => x.Name)
                .HasMaxLength(100)
                .IsRequired();
            entity
                .Property(x => x.Surname)
                .HasMaxLength(100)
                .IsRequired();
        });
        
    }
    
}