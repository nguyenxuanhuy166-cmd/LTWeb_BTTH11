package com.bookstore.controllers;

import com.bookstore.dao.UserDao_24110224;
import com.bookstore.models.User_24110224;
import com.bookstore.utils.MailUtil_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = {"/register", "/verify-otp"})
public class RegisterServlet_24110224 extends HttpServlet {
    private UserDao_24110224 userDao = new UserDao_24110224();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/register".equals(path)) {
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        } else if ("/verify-otp".equals(path)) {
            req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/register".equals(path)) {
            String email = req.getParameter("email");
            String fullname = req.getParameter("fullname");
            String phoneStr = req.getParameter("phone");
            String passwd = req.getParameter("passwd");

            int phone = 0;
            try { phone = Integer.parseInt(phoneStr); } catch (Exception e) {}

            User_24110224 tempUser = new User_24110224();
            tempUser.setEmail(email);
            tempUser.setFullname(fullname);
            tempUser.setPhone(phone);
            tempUser.setPasswd(passwd); // In real app, hash password
            tempUser.setAdmin(false);

            String otp = String.format("%06d", new Random().nextInt(999999));
            HttpSession session = req.getSession();
            session.setAttribute("tempUser", tempUser);
            session.setAttribute("otp", otp);

            MailUtil_24110224.sendOTP(email, otp);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else if ("/verify-otp".equals(path)) {
            String inputOtp = req.getParameter("otp");
            HttpSession session = req.getSession();
            String sessionOtp = (String) session.getAttribute("otp");
            User_24110224 tempUser = (User_24110224) session.getAttribute("tempUser");

            if (sessionOtp != null && sessionOtp.equals(inputOtp) && tempUser != null) {
                if (userDao.register(tempUser)) {
                    session.removeAttribute("otp");
                    session.removeAttribute("tempUser");
                    resp.sendRedirect(req.getContextPath() + "/login?msg=Registered successfully");
                } else {
                    req.setAttribute("error", "Database error");
                    req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("error", "Invalid OTP");
                req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
            }
        }
    }
}


