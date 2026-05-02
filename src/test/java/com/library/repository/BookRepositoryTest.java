package com.library.repository;

import com.library.entity.Author;
import com.library.entity.Book;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
class BookRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private BookRepository bookRepository;

    private Author savedAuthor;

    @BeforeEach
    void setUp() {
        savedAuthor = entityManager.persist(new Author("Test Author", "testauthor@books.com", "British", 1970));
        entityManager.flush();
    }

    @Test
    void testSaveAndFindBook() {
        Book book = new Book("Test Book", "978-0000000001", "Fiction", 2020, 12.99, savedAuthor);
        Book saved = bookRepository.save(book);

        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getTitle()).isEqualTo("Test Book");
        assertThat(saved.getAuthor().getName()).isEqualTo("Test Author");
    }

    @Test
    void testFindAll() {
        entityManager.persist(new Book("Book One", "978-0000000002", "Drama", 2018, 10.99, savedAuthor));
        entityManager.persist(new Book("Book Two", "978-0000000003", "Thriller", 2019, 11.99, savedAuthor));
        entityManager.flush();

        List<Book> books = bookRepository.findAll();
        assertThat(books).hasSizeGreaterThanOrEqualTo(2);
    }

    @Test
    void testFindAllBooksWithAuthors() {
        entityManager.persist(new Book("Join Test Book", "978-0000000004", "Mystery", 2021, 9.99, savedAuthor));
        entityManager.flush();

        List<Book> books = bookRepository.findAllBooksWithAuthors();
        assertThat(books).isNotEmpty();
        books.forEach(b -> assertThat(b.getAuthor()).isNotNull());
    }

    @Test
    void testFindBooksByAuthorId() {
        entityManager.persist(new Book("Author Book 1", "978-0000000005", "Fiction", 2022, 14.99, savedAuthor));
        entityManager.persist(new Book("Author Book 2", "978-0000000006", "Fiction", 2023, 15.99, savedAuthor));
        entityManager.flush();

        List<Book> books = bookRepository.findBooksByAuthorId(savedAuthor.getId());
        assertThat(books).hasSizeGreaterThanOrEqualTo(2);
        books.forEach(b -> assertThat(b.getAuthor().getId()).isEqualTo(savedAuthor.getId()));
    }

    @Test
    void testExistsByIsbn() {
        entityManager.persist(new Book("ISBN Book", "978-9999999999", "Drama", 2020, 8.99, savedAuthor));
        entityManager.flush();

        assertThat(bookRepository.existsByIsbn("978-9999999999")).isTrue();
        assertThat(bookRepository.existsByIsbn("978-0000000000")).isFalse();
    }
}
