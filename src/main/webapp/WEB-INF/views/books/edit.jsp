<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .form-card { background: white; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); padding: 2rem; }
        .form-header { background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%); color: white; padding: 1.5rem 2rem; border-radius: 12px 12px 0 0; margin: -2rem -2rem 2rem -2rem; }
        .form-label { font-weight: 600; color: #495057; }
        .btn-update { background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%); border: none; padding: 0.6rem 2rem; }
        .btn-update:hover { opacity: 0.9; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <a class="navbar-brand" href="/books"><i class="bi bi-book-half me-2"></i>Library Manager</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/books"><i class="bi bi-journals me-1"></i>Books</a>
            <a class="nav-link" href="/authors"><i class="bi bi-people me-1"></i>Authors</a>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 700px;">
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="form-card">
        <div class="form-header">
            <h4 class="mb-0"><i class="bi bi-pencil-square me-2"></i>Edit Book</h4>
        </div>

        <form action="/books/update" method="post">
            <input type="hidden" name="id" value="${book.id}">
            <div class="row g-3">
                <div class="col-12">
                    <label class="form-label">Title <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" value="${book.title}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">ISBN <span class="text-danger">*</span></label>
                    <input type="text" name="isbn" class="form-control" value="${book.isbn}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Genre</label>
                    <input type="text" name="genre" class="form-control" value="${book.genre}">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Published Year</label>
                    <input type="number" name="publishedYear" class="form-control" value="${book.publishedYear}" min="1000" max="2099">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Price ($)</label>
                    <input type="number" name="price" class="form-control" value="${book.price}" step="0.01" min="0">
                </div>
                <div class="col-12">
                    <label class="form-label">Author <span class="text-danger">*</span></label>
                    <select name="authorId" class="form-select" required>
                        <option value="">-- Select an Author --</option>
                        <c:forEach var="author" items="${authors}">
                            <option value="${author.id}"
                                <c:if test="${author.id == book.author.id}">selected</c:if>>
                                ${author.name} (${author.nationality})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-12 mt-3 d-flex gap-2">
                    <button type="submit" class="btn btn-warning btn-update text-white">
                        <i class="bi bi-save me-2"></i>Update Book
                    </button>
                    <a href="/books" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
