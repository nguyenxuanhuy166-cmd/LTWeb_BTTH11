package com.bookstore.controllers;

import com.bookstore.dao.BookDao_24110224;
import com.bookstore.models.Book_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/admin/books/form")
public class AdminBookFormServlet_24110224 extends HttpServlet {
    private BookDao_24110224 bookDao = new BookDao_24110224();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Book_24110224 book = bookDao.getBookById(id);
                req.setAttribute("book", book);
            } catch (Exception e) {}
        }
        req.getRequestDispatcher("/views/admin_book_form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("bookid");
        String title = req.getParameter("title");
        String isbnStr = req.getParameter("isbn");
        String publisher = req.getParameter("publisher");
        String priceStr = req.getParameter("price");
        String description = req.getParameter("description");
        String publishDateStr = req.getParameter("publish_date");
        String coverImage = req.getParameter("cover_image");
        String quantityStr = req.getParameter("quantity");

        try {
            Book_24110224 book = new Book_24110224();
            book.setTitle(title);
            book.setIsbn(Integer.parseInt(isbnStr));
            book.setPublisher(publisher);
            book.setPrice(Double.parseDouble(priceStr));
            book.setDescription(description);
            book.setPublishDate(Date.valueOf(publishDateStr));
            book.setCoverImage(coverImage);
            book.setQuantity(Integer.parseInt(quantityStr));

            if (idStr != null && !idStr.isEmpty()) {
                book.setBookId(Integer.parseInt(idStr));
                bookDao.updateBook(book);
            } else {
                bookDao.createBook(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/admin/books");
    }
}


