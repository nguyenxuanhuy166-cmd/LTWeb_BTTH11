package com.bookstore.filters;

import com.bookstore.models.User_24110224;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter_24110224 implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User_24110224 user = (User_24110224) session.getAttribute("user");
            if (user.isAdmin()) {
                chain.doFilter(request, response);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/login?error=Access+Denied");
    }

    @Override
    public void destroy() {}
}


