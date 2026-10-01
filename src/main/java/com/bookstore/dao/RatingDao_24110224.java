package com.bookstore.dao;

import com.bookstore.models.Rating_24110224;
import com.bookstore.utils.DBConnection_24110224;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RatingDao_24110224 {

    public List<Rating_24110224> getRatingsByBookId(int bookId) {
        List<Rating_24110224> ratings = new ArrayList<>();
        String query = "SELECT r.*, u.fullname FROM rating r JOIN users u ON r.userid = u.id WHERE r.bookid = ?";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Rating_24110224 rating = new Rating_24110224();
                    rating.setUserId(rs.getInt("userid"));
                    rating.setBookId(rs.getInt("bookid"));
                    rating.setRating(rs.getInt("rating"));
                    rating.setReviewText(rs.getString("review_text"));
                    rating.setUserFullname(rs.getString("fullname"));
                    ratings.add(rating);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ratings;
    }

    public boolean addRating(Rating_24110224 rating) {
        String query = "INSERT INTO rating (userid, bookid, rating, review_text) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, rating.getUserId());
            ps.setInt(2, rating.getBookId());
            ps.setInt(3, rating.getRating());
            ps.setString(4, rating.getReviewText());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}


