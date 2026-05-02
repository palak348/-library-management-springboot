package com.library.repository;

import com.library.entity.Author;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
class AuthorRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private AuthorRepository authorRepository;

    @Test
    void testSaveAndFindAuthor() {
        Author author = new Author("Test Author", "test@books.com", "British", 1980);
        Author saved = authorRepository.save(author);

        assertThat(saved.getId()).isNotNull();
        assertThat(saved.getName()).isEqualTo("Test Author");
        assertThat(saved.getEmail()).isEqualTo("test@books.com");
    }

    @Test
    void testFindAll() {
        entityManager.persist(new Author("Author One", "one@books.com", "American", 1970));
        entityManager.persist(new Author("Author Two", "two@books.com", "French", 1975));
        entityManager.flush();

        List<Author> authors = authorRepository.findAll();
        assertThat(authors).hasSizeGreaterThanOrEqualTo(2);
    }

    @Test
    void testFindById() {
        Author author = entityManager.persist(new Author("Find Me", "findme@books.com", "Italian", 1965));
        entityManager.flush();

        Optional<Author> found = authorRepository.findById(author.getId());
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("Find Me");
    }

    @Test
    void testFindByEmail() {
        entityManager.persist(new Author("Email Author", "unique@books.com", "Spanish", 1990));
        entityManager.flush();

        Optional<Author> found = authorRepository.findByEmail("unique@books.com");
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("Email Author");
    }

    @Test
    void testExistsByEmail() {
        entityManager.persist(new Author("Exists Author", "exists@books.com", "German", 1985));
        entityManager.flush();

        assertThat(authorRepository.existsByEmail("exists@books.com")).isTrue();
        assertThat(authorRepository.existsByEmail("notexists@books.com")).isFalse();
    }

    @Test
    void testUpdateAuthor() {
        Author author = entityManager.persist(new Author("Old Name", "old@books.com", "Russian", 1950));
        entityManager.flush();

        author.setName("New Name");
        Author updated = authorRepository.save(author);

        assertThat(updated.getName()).isEqualTo("New Name");
    }
}
