package com.bookstore.controllers;

import com.bookstore.dao.BookDao_24110224;
import com.bookstore.models.Book_24110224;
import com.bookstore.models.CartItem_24110224;
import com.bookstore.models.Cart_24110224;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/cart"})
public class CartServlet_24110224 extends HttpServlet {
    private BookDao_24110224 bookDao;

    @Override
    public void init() throws ServletException {
        bookDao = new BookDao_24110224();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "view";
        }

        HttpSession session = req.getSession();
        Cart_24110224 cart = (Cart_24110224) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart_24110224();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "view":
                req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
                break;
            case "add":
                addToCart(req, resp, cart);
                break;
            case "remove":
                removeFromCart(req, resp, cart);
                break;
            case "update":
                updateCart(req, resp, cart);
                break;
            default:
                req.getRequestDispatcher("/views/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp, Cart_24110224 cart) throws IOException {
        try {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            int quantity = 1;
            if (req.getParameter("quantity") != null) {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            }

            Book_24110224 book = bookDao.getBookById(bookId);
            if (book != null) {
                // Check available quantity
                int availableQuantity = book.getQuantity();
                int currentCartQuantity = 0;
                for (CartItem_24110224 item : cart.getItems()) {
                    if (item.getBook().getBookId() == bookId) {
                        currentCartQuantity = item.getQuantity();
                        break;
                    }
                }
                
                if (currentCartQuantity + quantity <= availableQuantity) {
                    cart.addItem(new CartItem_24110224(book, quantity));
                    req.getSession().setAttribute("msg", "Đã thêm vào giỏ hàng.");
                } else {
                    req.getSession().setAttribute("err", "Số lượng trong kho không đủ.");
                }
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("err", "Sản phẩm không hợp lệ.");
        }
        
        String redirect = req.getParameter("redirect");
        if ("cart".equals(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }
        
        String referer = req.getHeader("referer");
        if (referer != null && !referer.contains("/cart")) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp, Cart_24110224 cart) throws IOException {
        try {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            cart.removeItem(bookId);
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("err", "Sản phẩm không hợp lệ.");
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void updateCart(HttpServletRequest req, HttpServletResponse resp, Cart_24110224 cart) throws IOException {
        try {
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            
            Book_24110224 book = bookDao.getBookById(bookId);
            if (book != null) {
                if (quantity <= book.getQuantity()) {
                    cart.updateQuantity(bookId, quantity);
                } else {
                    req.getSession().setAttribute("err", "Số lượng vượt quá trong kho (" + book.getQuantity() + ").");
                }
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("err", "Dữ liệu không hợp lệ.");
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
