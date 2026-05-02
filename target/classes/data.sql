INSERT INTO author (id, name, email, nationality, birth_year) VALUES
(1, 'George Orwell', 'gorwell@books.com', 'British', 1903),
(2, 'J.K. Rowling', 'jkrowling@books.com', 'British', 1965),
(3, 'Ernest Hemingway', 'ehemingway@books.com', 'American', 1899),
(4, 'F. Scott Fitzgerald', 'fscott@books.com', 'American', 1896),
(5, 'Gabriel Garcia Marquez', 'ggmarquez@books.com', 'Colombian', 1927),
(6, 'Toni Morrison', 'tmorrison@books.com', 'American', 1931),
(7, 'Haruki Murakami', 'hmurakami@books.com', 'Japanese', 1949),
(8, 'Leo Tolstoy', 'ltolstoy@books.com', 'Russian', 1828),
(9, 'Jane Austen', 'jausten@books.com', 'British', 1775),
(10, 'Mark Twain', 'mtwain@books.com', 'American', 1835);

INSERT INTO book (id, title, isbn, genre, published_year, price, author_id) VALUES
(1, '1984', '978-0451524935', 'Dystopian', 1949, 12.99, 1),
(2, 'Animal Farm', '978-0451526342', 'Political Satire', 1945, 9.99, 1),
(3, 'Harry Potter and the Sorcerers Stone', '978-0590353427', 'Fantasy', 1997, 14.99, 2),
(4, 'The Old Man and the Sea', '978-0684801223', 'Literary Fiction', 1952, 11.99, 3),
(5, 'The Great Gatsby', '978-0743273565', 'Literary Fiction', 1925, 10.99, 4),
(6, 'One Hundred Years of Solitude', '978-0060883287', 'Magical Realism', 1967, 15.99, 5),
(7, 'Beloved', '978-1400033416', 'Historical Fiction', 1987, 13.99, 6),
(8, 'Norwegian Wood', '978-0375704024', 'Literary Fiction', 1987, 12.99, 7),
(9, 'War and Peace', '978-1400079988', 'Historical Fiction', 1869, 18.99, 8),
(10, 'Pride and Prejudice', '978-0141439518', 'Romance', 1813, 8.99, 9);

ALTER TABLE author ALTER COLUMN id RESTART WITH 11;
ALTER TABLE book ALTER COLUMN id RESTART WITH 11;
