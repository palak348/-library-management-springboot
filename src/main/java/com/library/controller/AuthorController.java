package com.library.controller;

import com.library.entity.Author;
import com.library.service.AuthorService;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthorController {

    private final AuthorService authorService;

    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping("/authors")
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.getAllAuthors());
        return "authors/list";
    }

    @GetMapping("/authors/new")
    public String showAddForm(Model model) {
        model.addAttribute("author", new Author());
        return "authors/form";
    }

    @PostMapping("/authors/save")
    public String saveAuthor(@ModelAttribute Author author, RedirectAttributes redirectAttrs) {
        try {
            authorService.save(author);
            redirectAttrs.addFlashAttribute("successMessage", "Author added successfully!");
        } catch (DataIntegrityViolationException e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Email already exists. Please use a different email.");
            return "redirect:/authors/new";
        }
        return "redirect:/authors";
    }

    @GetMapping("/authors/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        model.addAttribute("author", authorService.getById(id));
        return "authors/edit";
    }

    @PostMapping("/authors/update")
    public String updateAuthor(@ModelAttribute Author author, RedirectAttributes redirectAttrs) {
        try {
            authorService.update(author);
            redirectAttrs.addFlashAttribute("successMessage", "Author updated successfully!");
        } catch (DataIntegrityViolationException e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Email already exists. Please use a different email.");
            return "redirect:/authors/edit/" + author.getId();
        }
        return "redirect:/authors";
    }

    @PostMapping("/authors/delete/{id}")
    public String deleteAuthor(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        try {
            authorService.deleteById(id);
            redirectAttrs.addFlashAttribute("successMessage", "Author deleted successfully!");
        } catch (DataIntegrityViolationException e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Cannot delete author — they have books assigned. Remove the books first.");
        }
        return "redirect:/authors";
    }
}
