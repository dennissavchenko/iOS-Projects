﻿// <auto-generated />
using System;
using Books.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace Books.Migrations
{
    [DbContext(typeof(BooksContext))]
    partial class BooksContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.5")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("Books.Entities.Author", b =>
                {
                    b.Property<int>("IdAuthor")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("IdAuthor"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("Surname")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("IdAuthor");

                    b.ToTable("Author", (string)null);
                });

            modelBuilder.Entity("Books.Entities.Book", b =>
                {
                    b.Property<int>("IdBook")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("IdBook"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasMaxLength(300)
                        .HasColumnType("nvarchar(300)");

                    b.Property<int>("IdAuthor")
                        .HasColumnType("int");

                    b.Property<string>("ImageURL")
                        .IsRequired()
                        .HasMaxLength(300)
                        .HasColumnType("nvarchar(300)");

                    b.Property<int>("InStock")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<int>("NumPages")
                        .HasColumnType("int");

                    b.Property<double>("Price")
                        .HasColumnType("float");

                    b.Property<DateTime>("ReleaseDate")
                        .HasColumnType("datetime2");

                    b.HasKey("IdBook");

                    b.HasIndex("IdAuthor");

                    b.ToTable("Book", (string)null);
                });

            modelBuilder.Entity("Books.Entities.Genre", b =>
                {
                    b.Property<int>("IdGenre")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("IdGenre"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.HasKey("IdGenre");

                    b.ToTable("Genre", (string)null);
                });

            modelBuilder.Entity("BooksGenres", b =>
                {
                    b.Property<int>("IdBook")
                        .HasColumnType("int");

                    b.Property<int>("IdGenre")
                        .HasColumnType("int");

                    b.HasKey("IdBook", "IdGenre");

                    b.HasIndex("IdGenre");

                    b.ToTable("BooksGenres");
                });

            modelBuilder.Entity("Books.Entities.Book", b =>
                {
                    b.HasOne("Books.Entities.Author", "Author")
                        .WithMany("Books")
                        .HasForeignKey("IdAuthor")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Author");
                });

            modelBuilder.Entity("BooksGenres", b =>
                {
                    b.HasOne("Books.Entities.Book", null)
                        .WithMany()
                        .HasForeignKey("IdBook")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Books.Entities.Genre", null)
                        .WithMany()
                        .HasForeignKey("IdGenre")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Books.Entities.Author", b =>
                {
                    b.Navigation("Books");
                });
#pragma warning restore 612, 618
        }
    }
}