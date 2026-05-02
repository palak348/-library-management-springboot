# Library Management System

A Spring Boot web application to manage **Books** and **Authors** with full CRUD operations, built using Spring MVC, JPA, JSP, and H2 in-memory database.

## Tech Stack

- **Java 17**
- **Spring Boot 3.2.5**
- **Spring Data JPA** (Hibernate)
- **H2 In-Memory Database**
- **JSP + JSTL** (View Layer)
- **Bootstrap 5** (UI Styling)
- **Maven** (Build Tool)
- **JUnit 5 + Mockito** (Testing)

## Project Structure

```
src/
├── main/
│   ├── java/com/library/
│   │   ├── LibraryApplication.java
│   │   ├── entity/
│   │   │   ├── Author.java
│   │   │   └── Book.java
│   │   ├── repository/
│   │   │   ├── AuthorRepository.java
│   │   │   └── BookRepository.java
│   │   ├── service/
│   │   │   ├── AuthorService.java
│   │   │   ├── AuthorServiceImpl.java
│   │   │   ├── BookService.java
│   │   │   └── BookServiceImpl.java
│   │   └── controller/
│   │       ├── AuthorController.java
│   │       └── BookController.java
│   ├── resources/
│   │   ├── application.properties
│   │   └── data.sql
│   └── webapp/WEB-INF/views/
│       ├── authors/ (list, form, edit)
│       └── books/   (list, form, edit)
└── test/
    └── java/com/library/
        ├── repository/ (AuthorRepositoryTest, BookRepositoryTest)
        └── service/    (AuthorServiceTest, BookServiceTest)
```

## Entity Relationship

```
Author (1) ──────< Book (Many)
  - id              - id
  - name            - title
  - email (unique)  - isbn (unique)
  - nationality     - genre
  - birthYear       - publishedYear
                    - price
                    - author_id (FK)
```

## Features

- **Create** — Add new authors and books via forms with validation
- **Read** — List all books (loaded via INNER JOIN with authors) and all authors
- **Update** — Edit existing author and book details
- **Delete** — Remove books or authors (with FK constraint protection)
- **Exception Handling** — Duplicate email/ISBN violations shown as error messages
- **H2 Console** — Browse the database at `/h2-console`
- **Sample Data** — 10 authors and 10 books pre-loaded on startup

## Getting Started

### Prerequisites
- Java 17+
- Maven 3.6+

### Run the application

```bash
mvn package -DskipTests
java -jar target/library-management-0.0.1-SNAPSHOT.war
```

Then open: [http://localhost:8080](http://localhost:8080)

### H2 Database Console

URL: [http://localhost:8080/h2-console](http://localhost:8080/h2-console)

| Field    | Value              |
|----------|--------------------|
| JDBC URL | `jdbc:h2:mem:librarydb` |
| Username | `sa`               |
| Password | *(leave blank)*    |

### Run Tests

```bash
mvn test
```

All 24 tests should pass (6 repository tests + 5 service tests per entity).

## API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/books` | List all books |
| GET | `/books/new` | Add book form |
| POST | `/books/save` | Save new book |
| GET | `/books/edit/{id}` | Edit book form |
| POST | `/books/update` | Update book |
| POST | `/books/delete/{id}` | Delete book |
| GET | `/authors` | List all authors |
| GET | `/authors/new` | Add author form |
| POST | `/authors/save` | Save new author |
| GET | `/authors/edit/{id}` | Edit author form |
| POST | `/authors/update` | Update author |
| POST | `/authors/delete/{id}` | Delete author |
