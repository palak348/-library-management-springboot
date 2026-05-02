<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .navbar-brand { font-weight: 700; font-size: 1.4rem; }
        .page-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem; }
        .table-card { background: white; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); overflow: hidden; }
        .table thead { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .table thead th { border: none; font-weight: 600; padding: 1rem; }
        .table tbody tr:hover { background-color: #f0f4ff; }
        .badge-genre { background-color: #e8f4f8; color: #2980b9; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
        .btn-edit { background-color: #f39c12; border-color: #f39c12; color: white; }
        .btn-edit:hover { background-color: #d68910; border-color: #d68910; color: white; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <a class="navbar-brand" href="/books"><i class="bi bi-book-half me-2"></i>Library Manager</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link active" href="/books"><i class="bi bi-journals me-1"></i>Books</a>
            <a class="nav-link" href="/authors"><i class="bi bi-people me-1"></i>Authors</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="page-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-1"><i class="bi bi-journals me-2"></i>All Books</h2>
                <p class="mb-0 opacity-75">Browse and manage the book collection</p>
            </div>
            <a href="/books/new" class="btn btn-light btn-lg">
                <i class="bi bi-plus-circle me-2"></i>Add New Book
            </a>
        </div>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Genre</th>
                        <th>ISBN</th>
                        <th>Year</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}" varStatus="status">
                        <tr>
                            <td class="text-muted">${status.count}</td>
                            <td><strong>${book.title}</strong></td>
                            <td><i class="bi bi-person me-1 text-muted"></i>${book.author.name}</td>
                            <td><span class="badge-genre">${book.genre}</span></td>
                            <td><small class="text-muted">${book.isbn}</small></td>
                            <td>${book.publishedYear}</td>
                            <td><strong>$<fmt:formatNumber value="${book.price}" minFractionDigits="2" maxFractionDigits="2"/></strong></td>
                            <td class="d-flex gap-1">
                                <a href="/books/edit/${book.id}" class="btn btn-edit btn-sm">
                                    <i class="bi bi-pencil-square me-1"></i>Edit
                                </a>
                                <form action="/books/delete/${book.id}" method="post" onsubmit="return confirm('Delete this book?');">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash me-1"></i>Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty books}">
                        <tr>
                            <td colspan="8" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox display-6 d-block mb-2"></i>No books found. Add one!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <div class="px-3 py-2 text-muted border-top">
            <small><i class="bi bi-info-circle me-1"></i>Showing ${books.size()} book(s) — loaded via INNER JOIN with Authors</small>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
