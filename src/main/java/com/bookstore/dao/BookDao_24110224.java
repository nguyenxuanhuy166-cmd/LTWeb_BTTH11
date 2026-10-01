package com.bookstore.dao;

import com.bookstore.models.Author_24110224;
import com.bookstore.models.Book_24110224;
import com.bookstore.utils.DBConnection_24110224;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDao_24110224 {
    
    public List<Book_24110224> getBooks(int offset, int limit) {
        List<Book_24110224> books = new ArrayList<>();
        String query = "SELECT * FROM books ORDER BY (SELECT TOP 1 a.author_name FROM book_author ba JOIN author a ON ba.author_id = a.author_id WHERE ba.bookid = books.bookid), bookid OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book_24110224 book = mapRowToBook(rs);
                    book.setAuthors(getAuthorsByBookId(book.getBookId(), conn));
                    book.setReviewCount(getReviewCountByBookId(book.getBookId(), conn));
                    books.add(book);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }

    public int getTotalBooks() {
        String query = "SELECT COUNT(*) FROM books";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Book_24110224 getBookById(int id) {
        String query = "SELECT * FROM books WHERE bookid = ?";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book_24110224 book = mapRowToBook(rs);
                    book.setAuthors(getAuthorsByBookId(book.getBookId(), conn));
                    book.setReviewCount(getReviewCountByBookId(book.getBookId(), conn));
                    return book;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createBook(Book_24110224 book) {
        String query = "INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, book.getIsbn());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getPublisher());
            ps.setDouble(4, book.getPrice());
            ps.setString(5, book.getDescription());
            ps.setDate(6, book.getPublishDate());
            ps.setString(7, book.getCoverImage());
            ps.setInt(8, book.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBook(Book_24110224 book) {
        String query = "UPDATE books SET isbn=?, title=?, publisher=?, price=?, description=?, publish_date=?, cover_image=?, quantity=? WHERE bookid=?";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, book.getIsbn());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getPublisher());
            ps.setDouble(4, book.getPrice());
            ps.setString(5, book.getDescription());
            ps.setDate(6, book.getPublishDate());
            ps.setString(7, book.getCoverImage());
            ps.setInt(8, book.getQuantity());
            ps.setInt(9, book.getBookId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBook(int id) {
        // Must delete ratings and book_author first due to foreign keys
        try (Connection conn = DBConnection_24110224.getConnection()) {
            conn.setAutoCommit(false);
            try {
                try(PreparedStatement ps1 = conn.prepareStatement("DELETE FROM rating WHERE bookid=?")) {
                    ps1.setInt(1, id);
                    ps1.executeUpdate();
                }
                try(PreparedStatement ps2 = conn.prepareStatement("DELETE FROM book_author WHERE bookid=?")) {
                    ps2.setInt(1, id);
                    ps2.executeUpdate();
                }
                try(PreparedStatement ps3 = conn.prepareStatement("DELETE FROM books WHERE bookid=?")) {
                    ps3.setInt(1, id);
                    ps3.executeUpdate();
                }
                conn.commit();
                return true;
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Book_24110224 mapRowToBook(ResultSet rs) throws SQLException {
        Book_24110224 book = new Book_24110224();
        book.setBookId(rs.getInt("bookid"));
        book.setIsbn(rs.getInt("isbn"));
        book.setTitle(rs.getString("title"));
        book.setPublisher(rs.getString("publisher"));
        book.setPrice(rs.getDouble("price"));
        book.setDescription(rs.getString("description"));
        book.setPublishDate(rs.getDate("publish_date"));
        book.setCoverImage(rs.getString("cover_image"));
        book.setQuantity(rs.getInt("quantity"));
        return book;
    }

    private List<Author_24110224> getAuthorsByBookId(int bookId, Connection conn) throws SQLException {
        List<Author_24110224> authors = new ArrayList<>();
        String q = "SELECT a.* FROM author a JOIN book_author ba ON a.author_id = ba.author_id WHERE ba.bookid = ?";
        try (PreparedStatement ps = conn.prepareStatement(q)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Author_24110224 author = new Author_24110224();
                    author.setAuthorId(rs.getInt("author_id"));
                    author.setAuthorName(rs.getString("author_name"));
                    author.setDateOfBirth(rs.getDate("date_of_birth"));
                    authors.add(author);
                }
            }
        }
        return authors;
    }

    private int getReviewCountByBookId(int bookId, Connection conn) throws SQLException {
        String q = "SELECT COUNT(*) FROM rating WHERE bookid = ?";
        try (PreparedStatement ps = conn.prepareStatement(q)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }
}


