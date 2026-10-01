package com.bookstore.dao;

import com.bookstore.models.CartItem_24110224;
import com.bookstore.models.Cart_24110224;
import com.bookstore.models.User_24110224;
import com.bookstore.utils.DBConnection_24110224;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class OrderDao_24110224 {

    public boolean createOrder(User_24110224 user, Cart_24110224 cart, String address) {
        Connection conn = null;
        try {
            conn = DBConnection_24110224.getConnection();
            conn.setAutoCommit(false); // start transaction

            // 1. Insert into orders
            String orderSql = "INSERT INTO orders (user_id, order_date, total_money, address, status) VALUES (?, GETDATE(), ?, ?, 'Pending')";
            PreparedStatement psOrder = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, user.getId());
            psOrder.setDouble(2, cart.getTotalMoney());
            psOrder.setString(3, address);
            psOrder.executeUpdate();

            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 2. Insert into order_details and update book quantity
            String detailSql = "INSERT INTO order_details (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(detailSql);
            
            String updateBookSql = "UPDATE books SET quantity = quantity - ? WHERE bookid = ?";
            PreparedStatement psUpdateBook = conn.prepareStatement(updateBookSql);

            for (CartItem_24110224 item : cart.getItems()) {
                // insert order_details
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, item.getBook().getBookId());
                psDetail.setInt(3, item.getQuantity());
                psDetail.setDouble(4, item.getBook().getPrice());
                psDetail.executeUpdate();

                // update book stock
                psUpdateBook.setInt(1, item.getQuantity());
                psUpdateBook.setInt(2, item.getBook().getBookId());
                psUpdateBook.executeUpdate();
            }

            conn.commit(); // commit transaction
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
