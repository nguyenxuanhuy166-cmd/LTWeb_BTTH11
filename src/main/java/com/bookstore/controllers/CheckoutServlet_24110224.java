package com.bookstore.controllers;

import com.bookstore.dao.OrderDao_24110224;
import com.bookstore.models.Cart_24110224;
import com.bookstore.models.User_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutServlet_24110224 extends HttpServlet {
    private OrderDao_24110224 orderDao;

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDao_24110224();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User_24110224 user = (User_24110224) session.getAttribute("user");
        Cart_24110224 cart = (Cart_24110224) session.getAttribute("cart");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String address = req.getParameter("address");

        boolean success = orderDao.createOrder(user, cart, address);

        if (success) {
            cart.clear(); // clear cart after successful checkout
            session.setAttribute("msg", "Đặt hàng thành công! Chúng tôi sẽ giao hàng đến bạn sớm nhất.");
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            session.setAttribute("err", "Có lỗi xảy ra trong quá trình đặt hàng. Vui lòng thử lại.");
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
