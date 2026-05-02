package com.library.service;

import com.library.entity.Author;
import java.util.List;

public interface AuthorService {
    List<Author> getAllAuthors();
    Author getById(Long id);
    Author save(Author author);
    Author update(Author author);
    void deleteById(Long id);
}
