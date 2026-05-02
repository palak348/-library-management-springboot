<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Author - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .form-card { background: white; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); padding: 2rem; }
        .form-header { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; padding: 1.5rem 2rem; border-radius: 12px 12px 0 0; margin: -2rem -2rem 2rem -2rem; }
        .form-label { font-weight: 600; color: #495057; }
        .btn-submit { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); border: none; padding: 0.6rem 2rem; color: white; }
        .btn-submit:hover { opacity: 0.9; color: white; }
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

<div class="container mt-4" style="max-width: 700px;">
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="form-card">
        <div class="form-header">
            <h4 class="mb-0"><i class="bi bi-person-plus me-2"></i>Add New Author</h4>
        </div>

        <form action="/authors/save" method="post">
            <div class="row g-3">
                <div class="col-12">
                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control" placeholder="Enter author's full name" required>
                </div>
                <div class="col-12">
                    <label class="form-label">Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" class="form-control" placeholder="author@example.com" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Nationality</label>
                    <input type="text" name="nationality" class="form-control" placeholder="e.g. British, American">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Birth Year</label>
                    <input type="number" name="birthYear" class="form-control" placeholder="e.g. 1980" min="1000" max="2025">
                </div>
                <div class="col-12 mt-3 d-flex gap-2">
                    <button type="submit" class="btn btn-submit">
                        <i class="bi bi-save me-2"></i>Save Author
                    </button>
                    <a href="/authors" class="btn btn-outline-secondary">
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
