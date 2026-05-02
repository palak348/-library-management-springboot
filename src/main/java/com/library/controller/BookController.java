package com.library.controller;

import com.library.entity.Author;
import com.library.entity.Book;
import com.library.service.AuthorService;
import com.library.service.BookService;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class BookController {

    private final BookService bookService;
    private final AuthorService authorService;

    public BookController(BookService bookService, AuthorService authorService) {
        this.bookService = bookService;
        this.authorService = authorService;
    }

    @GetMapping({"/", "/books"})
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.getAllBooksWithAuthors());
        return "books/list";
    }

    @GetMapping("/books/new")
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("authors", authorService.getAllAuthors());
        return "books/form";
    }

    @PostMapping("/books/save")
    public String saveBook(@ModelAttribute Book book,
                           @RequestParam("authorId") Long authorId,
                           RedirectAttributes redirectAttrs) {
        try {
            Author author = authorService.getById(authorId);
            book.setAuthor(author);
            bookService.save(book);
            redirectAttrs.addFlashAttribute("successMessage", "Book added successfully!");
        } catch (DataIntegrityViolationException e) {
            redirectAttrs.addFlashAttribute("errorMessage", "ISBN already exists. Please use a different ISBN.");
            redirectAttrs.addFlashAttribute("selectedAuthorId", authorId);
            return "redirect:/books/new";
        }
        return "redirect:/books";
    }

    @GetMapping("/books/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        model.addAttribute("book", bookService.getById(id));
        model.addAttribute("authors", authorService.getAllAuthors());
        return "books/edit";
    }

    @PostMapping("/books/update")
    public String updateBook(@ModelAttribute Book book,
                             @RequestParam("authorId") Long authorId,
                             RedirectAttributes redirectAttrs) {
        try {
            Author author = authorService.getById(authorId);
            book.setAuthor(author);
            bookService.update(book);
            redirectAttrs.addFlashAttribute("successMessage", "Book updated successfully!");
        } catch (DataIntegrityViolationException e) {
            redirectAttrs.addFlashAttribute("errorMessage", "ISBN already exists. Please use a different ISBN.");
            return "redirect:/books/edit/" + book.getId();
        }
        return "redirect:/books";
    }

    @PostMapping("/books/delete/{id}")
    public String deleteBook(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        bookService.deleteById(id);
        redirectAttrs.addFlashAttribute("successMessage", "Book deleted successfully!");
        return "redirect:/books";
    }
}
