package com.library.service;

import com.library.entity.Author;
import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private BookServiceImpl bookService;

    private Author author;

    @BeforeEach
    void setUp() {
        author = new Author("Test Author", "test@books.com", "British", 1970);
        author.setId(1L);
    }

    @Test
    void testGetAllBooks() {
        Book b1 = new Book("Book One", "978-0000000001", "Fiction", 2020, 12.99, author);
        Book b2 = new Book("Book Two", "978-0000000002", "Drama", 2021, 9.99, author);
        when(bookRepository.findAll()).thenReturn(Arrays.asList(b1, b2));

        List<Book> result = bookService.getAllBooks();

        assertThat(result).hasSize(2);
        verify(bookRepository, times(1)).findAll();
    }

    @Test
    void testGetAllBooksWithAuthors() {
        Book b1 = new Book("Join Book", "978-0000000003", "Mystery", 2022, 11.99, author);
        when(bookRepository.findAllBooksWithAuthors()).thenReturn(List.of(b1));

        List<Book> result = bookService.getAllBooksWithAuthors();

        assertThat(result).hasSize(1);
        assertThat(result.get(0).getAuthor()).isNotNull();
        verify(bookRepository).findAllBooksWithAuthors();
    }

    @Test
    void testGetById_found() {
        Book book = new Book("Find Me", "978-0000000004", "Thriller", 2019, 13.99, author);
        book.setId(1L);
        when(bookRepository.findById(1L)).thenReturn(Optional.of(book));

        Book result = bookService.getById(1L);

        assertThat(result.getTitle()).isEqualTo("Find Me");
        verify(bookRepository).findById(1L);
    }

    @Test
    void testGetById_notFound() {
        when(bookRepository.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> bookService.getById(99L))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Book not found with id: 99");
    }

    @Test
    void testSaveBook() {
        Book book = new Book("New Book", "978-0000000005", "Romance", 2023, 8.99, author);
        Book saved = new Book("New Book", "978-0000000005", "Romance", 2023, 8.99, author);
        saved.setId(10L);
        when(bookRepository.save(any(Book.class))).thenReturn(saved);

        Book result = bookService.save(book);

        assertThat(result.getId()).isEqualTo(10L);
        verify(bookRepository).save(book);
    }

    @Test
    void testUpdateBook() {
        Book book = new Book("Updated Title", "978-0000000006", "Sci-Fi", 2024, 16.99, author);
        book.setId(3L);
        when(bookRepository.existsById(3L)).thenReturn(true);
        when(bookRepository.save(any(Book.class))).thenReturn(book);

        Book result = bookService.update(book);

        assertThat(result.getTitle()).isEqualTo("Updated Title");
        verify(bookRepository).existsById(3L);
        verify(bookRepository).save(book);
    }

    @Test
    void testUpdateBook_notFound() {
        Book book = new Book("Ghost Book", "978-0000000007", "Horror", 2020, 10.99, author);
        book.setId(99L);
        when(bookRepository.existsById(99L)).thenReturn(false);

        assertThatThrownBy(() -> bookService.update(book))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Book not found with id: 99");

        verify(bookRepository, never()).save(any());
    }
}
