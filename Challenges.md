# Challenges Faced & Solutions

## 1. JSTL ClassNotFoundException in Embedded Tomcat
**Problem:** JSP pages returned HTTP 500 — JSTL classes not found by embedded Tomcat's classloader.

**Solution:** Switched packaging from `jar` to `war` and extended `SpringBootServletInitializer`, which placed JSTL JARs in `WEB-INF/lib` where Tomcat could find them.

---

## 2. H2 Sequence Conflict with data.sql
**Problem:** Creating new records failed with primary key violation after pre-seeding 10 rows with explicit IDs.

**Solution:** Added sequence reset at the end of `data.sql`:
```sql
ALTER TABLE author ALTER COLUMN id RESTART WITH 11;
ALTER TABLE book ALTER COLUMN id RESTART WITH 11;
```

---

## 3. data.sql Running During Unit Tests
**Problem:** `@DataJpaTest` loaded `data.sql` before each test, causing ID conflicts.

**Solution:** Created `src/test/resources/application.properties` to disable data initialization during tests:
```properties
spring.sql.init.mode=never
```

---

## 4. Author Not Binding Correctly in Book Form
**Problem:** Selected author from dropdown was not saved — JPA treated it as a new entity.

**Solution:** Used `@RequestParam("authorId")` in the controller and loaded the managed `Author` entity from the service before saving the book.

---

## 5. Build Artifacts Committed to Git
**Problem:** `target/` folder and log files were accidentally committed.

**Solution:** Added `.gitignore` and removed tracked files using `git rm -r --cached target/`.
