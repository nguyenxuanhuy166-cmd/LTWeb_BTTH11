package com.bookstore.controllers;

import com.bookstore.dao.UserDao_24110224;
import com.bookstore.models.User_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet_24110224 extends HttpServlet {
    private UserDao_24110224 userDao = new UserDao_24110224();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String passwd = req.getParameter("passwd");

        User_24110224 user = userDao.login(email, passwd);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}


