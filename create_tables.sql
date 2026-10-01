USE BookStoreDB;
GO

CREATE TABLE users (
    id int IDENTITY(1,1) PRIMARY KEY,
    email varchar(50),
    fullname nvarchar(50),
    phone int,
    passwd varchar(32),
    signup_date datetime,
    last_login datetime,
    is_admin bit
);
GO

CREATE TABLE books (
    bookid int IDENTITY(1,1) PRIMARY KEY,
    isbn int,
    title nvarchar(200),
    publisher nvarchar(100),
    price decimal(6, 2),
    description nvarchar(MAX),
    publish_date date,
    cover_image varchar(100),
    quantity int
);
GO

CREATE TABLE author (
    author_id int IDENTITY(1,1) PRIMARY KEY,
    author_name nvarchar(100),
    date_of_birth date
);
GO

CREATE TABLE book_author (
    bookid int FOREIGN KEY REFERENCES books(bookid),
    author_id int FOREIGN KEY REFERENCES author(author_id),
    PRIMARY KEY (bookid, author_id)
);
GO

CREATE TABLE rating (
    userid int FOREIGN KEY REFERENCES users(id),
    bookid int FOREIGN KEY REFERENCES books(bookid),
    rating tinyint,
    review_text nvarchar(MAX),
    PRIMARY KEY (userid, bookid)
);
GO
