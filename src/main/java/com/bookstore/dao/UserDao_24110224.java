package com.bookstore.dao;

import com.bookstore.models.User_24110224;
import com.bookstore.utils.DBConnection_24110224;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao_24110224 {
    public User_24110224 login(String email, String passwd) {
        String query = "SELECT * FROM users WHERE email = ? AND passwd = ?";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, passwd);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User_24110224(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("fullname"),
                        rs.getInt("phone"),
                        rs.getString("passwd"),
                        rs.getTimestamp("signup_date"),
                        rs.getTimestamp("last_login"),
                        rs.getBoolean("is_admin")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(User_24110224 user) {
        String query = "INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin) VALUES (?, ?, ?, ?, GETDATE(), ?)";
        try (Connection conn = DBConnection_24110224.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFullname());
            ps.setInt(3, user.getPhone());
            ps.setString(4, user.getPasswd());
            ps.setBoolean(5, user.isAdmin());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}


