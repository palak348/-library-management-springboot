<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authors - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .page-header { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem; }
        .table-card { background: white; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); overflow: hidden; }
        .table thead { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; }
        .table thead th { border: none; font-weight: 600; padding: 1rem; }
        .table tbody tr:hover { background-color: #f0fff8; }
        .btn-edit { background-color: #f39c12; border-color: #f39c12; color: white; }
        .btn-edit:hover { background-color: #d68910; border-color: #d68910; color: white; }
        .nationality-badge { background-color: #e8f8f0; color: #27ae60; padding: 4px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <a class="navbar-brand" href="/books"><i class="bi bi-book-half me-2"></i>Library Manager</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/books"><i class="bi bi-journals me-1"></i>Books</a>
            <a class="nav-link active" href="/authors"><i class="bi bi-people me-1"></i>Authors</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="page-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-1"><i class="bi bi-people me-2"></i>All Authors</h2>
                <p class="mb-0 opacity-75">Browse and manage author profiles</p>
            </div>
            <a href="/authors/new" class="btn btn-light btn-lg">
                <i class="bi bi-person-plus me-2"></i>Add New Author
            </a>
        </div>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Nationality</th>
                        <th>Birth Year</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="author" items="${authors}" varStatus="status">
                        <tr>
                            <td class="text-muted">${status.count}</td>
                            <td><strong><i class="bi bi-person-circle me-1 text-muted"></i>${author.name}</strong></td>
                            <td><a href="mailto:${author.email}" class="text-decoration-none">${author.email}</a></td>
                            <td><span class="nationality-badge">${author.nationality}</span></td>
                            <td>${author.birthYear}</td>
                            <td class="d-flex gap-1">
                                <a href="/authors/edit/${author.id}" class="btn btn-edit btn-sm">
                                    <i class="bi bi-pencil-square me-1"></i>Edit
                                </a>
                                <form action="/authors/delete/${author.id}" method="post" onsubmit="return confirm('Delete this author? This will fail if they have books assigned.');">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash me-1"></i>Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty authors}">
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                <i class="bi bi-inbox display-6 d-block mb-2"></i>No authors found. Add one!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <div class="px-3 py-2 text-muted border-top">
            <small><i class="bi bi-info-circle me-1"></i>Showing ${authors.size()} author(s)</small>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
