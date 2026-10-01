package com.bookstore.controllers;

import com.bookstore.dao.BookDao_24110224;
import com.bookstore.dao.RatingDao_24110224;
import com.bookstore.models.Book_24110224;
import com.bookstore.models.Rating_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/book")
public class BookDetailServlet_24110224 extends HttpServlet {
    private BookDao_24110224 bookDao = new BookDao_24110224();
    private RatingDao_24110224 ratingDao = new RatingDao_24110224();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Book_24110224 book = bookDao.getBookById(id);
                if (book != null) {
                    List<Rating_24110224> ratings = ratingDao.getRatingsByBookId(id);
                    req.setAttribute("book", book);
                    req.setAttribute("ratings", ratings);
                    req.getRequestDispatcher("/views/book_detail.jsp").forward(req, resp);
                    return;
                }
            } catch (Exception e) {}
        }
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}


