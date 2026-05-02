package com.library.service;

import com.library.entity.Author;
import com.library.repository.AuthorRepository;
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
class AuthorServiceTest {

    @Mock
    private AuthorRepository authorRepository;

    @InjectMocks
    private AuthorServiceImpl authorService;

    @Test
    void testGetAllAuthors() {
        Author a1 = new Author("George Orwell", "gorwell@books.com", "British", 1903);
        Author a2 = new Author("J.K. Rowling", "jkrowling@books.com", "British", 1965);
        when(authorRepository.findAll()).thenReturn(Arrays.asList(a1, a2));

        List<Author> result = authorService.getAllAuthors();

        assertThat(result).hasSize(2);
        assertThat(result.get(0).getName()).isEqualTo("George Orwell");
        verify(authorRepository, times(1)).findAll();
    }

    @Test
    void testGetById_found() {
        Author author = new Author("Test Author", "test@books.com", "American", 1980);
        author.setId(1L);
        when(authorRepository.findById(1L)).thenReturn(Optional.of(author));

        Author result = authorService.getById(1L);

        assertThat(result.getName()).isEqualTo("Test Author");
        verify(authorRepository).findById(1L);
    }

    @Test
    void testGetById_notFound() {
        when(authorRepository.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> authorService.getById(99L))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Author not found with id: 99");
    }

    @Test
    void testSaveAuthor() {
        Author author = new Author("New Author", "new@books.com", "French", 1990);
        Author saved = new Author("New Author", "new@books.com", "French", 1990);
        saved.setId(5L);
        when(authorRepository.save(any(Author.class))).thenReturn(saved);

        Author result = authorService.save(author);

        assertThat(result.getId()).isEqualTo(5L);
        verify(authorRepository).save(author);
    }

    @Test
    void testUpdateAuthor() {
        Author author = new Author("Updated Name", "updated@books.com", "German", 1975);
        author.setId(2L);
        when(authorRepository.existsById(2L)).thenReturn(true);
        when(authorRepository.save(any(Author.class))).thenReturn(author);

        Author result = authorService.update(author);

        assertThat(result.getName()).isEqualTo("Updated Name");
        verify(authorRepository).existsById(2L);
        verify(authorRepository).save(author);
    }

    @Test
    void testUpdateAuthor_notFound() {
        Author author = new Author("Ghost", "ghost@books.com", "Unknown", 2000);
        author.setId(99L);
        when(authorRepository.existsById(99L)).thenReturn(false);

        assertThatThrownBy(() -> authorService.update(author))
                .isInstanceOf(RuntimeException.class)
                .hasMessageContaining("Author not found with id: 99");

        verify(authorRepository, never()).save(any());
    }
}
