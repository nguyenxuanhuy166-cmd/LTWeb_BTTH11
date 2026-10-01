package com.bookstore.controllers;

import com.bookstore.dao.BookDao_24110224;
import com.bookstore.models.Book_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductsServlet_24110224 extends HttpServlet {
    private BookDao_24110224 bookDao = new BookDao_24110224();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 3;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try { page = Integer.parseInt(pageParam); } catch (Exception e) {}
        }
        
        int offset = (page - 1) * pageSize;
        List<Book_24110224> books = bookDao.getBooks(offset, pageSize);
        int totalBooks = bookDao.getTotalBooks();
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        
        req.setAttribute("books", books);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        
        req.getRequestDispatcher("/views/products.jsp").forward(req, resp);
    }
}


