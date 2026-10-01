package com.bookstore.controllers;

import com.bookstore.dao.RatingDao_24110224;
import com.bookstore.models.Rating_24110224;
import com.bookstore.models.User_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/review")
public class ReviewServlet_24110224 extends HttpServlet {
    private RatingDao_24110224 ratingDao = new RatingDao_24110224();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User_24110224 user = (session != null) ? (User_24110224) session.getAttribute("user") : null;
        
        String bookIdStr = req.getParameter("bookid");
        String reviewText = req.getParameter("review_text");
        
        if (user != null && bookIdStr != null && reviewText != null) {
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Rating_24110224 rating = new Rating_24110224();
                rating.setUserId(user.getId());
                rating.setBookId(bookId);
                rating.setRating(5); // Default rating
                rating.setReviewText(reviewText);
                
                ratingDao.addRating(rating);
                resp.sendRedirect(req.getContextPath() + "/book?id=" + bookId);
                return;
            } catch (Exception e) {}
        }
        
        resp.sendRedirect(req.getContextPath() + "/login?msg=Please+login+to+review");
    }
}


