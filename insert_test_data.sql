USE BookStoreDB;
GO

INSERT INTO author (author_name, date_of_birth) VALUES
('J.K. Rowling', '1965-07-31'),
('George R.R. Martin', '1948-09-20'),
('J.R.R. Tolkien', '1892-01-03');
GO

INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES
(111, 'Harry Potter 1', 'Bloomsbury', 19.99, 'Boy wizard', '1997-06-26', 'https://via.placeholder.com/150', 100),
(222, 'Harry Potter 2', 'Bloomsbury', 20.99, 'Chamber of Secrets', '1998-07-02', 'https://via.placeholder.com/150', 120),
(333, 'Harry Potter 3', 'Bloomsbury', 21.99, 'Prisoner of Azkaban', '1999-07-08', 'https://via.placeholder.com/150', 80),
(444, 'Harry Potter 4', 'Bloomsbury', 22.99, 'Goblet of Fire', '2000-07-08', 'https://via.placeholder.com/150', 150),
(555, 'Game of Thrones', 'Bantam Books', 25.00, 'Ice and fire', '1996-08-01', 'https://via.placeholder.com/150', 200),
(666, 'Clash of Kings', 'Bantam Books', 26.00, 'Kings clashing', '1998-11-16', 'https://via.placeholder.com/150', 180),
(777, 'The Hobbit', 'Allen & Unwin', 15.00, 'There and back again', '1937-09-21', 'https://via.placeholder.com/150', 300);
GO

INSERT INTO book_author (bookid, author_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 3);
GO

INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin) VALUES
('admin@bookstore.com', 'Admin User', 123456789, '123', GETDATE(), 1),
('test@test.com', 'xhuy', 987654321, '123', GETDATE(), 0);
GO

INSERT INTO rating (userid, bookid, rating, review_text) VALUES
(2, 1, 5, 'Great book!'),
(2, 2, 4, 'Very good'),
(2, 5, 5, 'Winter is coming');
GO
