package com.carrental.servlet;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/my-bookings");
            return;
        }
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email    = req.getParameter("email").trim().toLowerCase();
        String password = req.getParameter("password");
        // Where to send the user after login (passed from booking flow)
        String redirect = req.getParameter("redirect");

        try {
            User user = userDAO.loginUser(email, password);
            if (user != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("loggedUser", user);
                session.setAttribute("userId",   user.getUserId());
                session.setAttribute("userName", user.getFullName());

                if (redirect != null && !redirect.isEmpty()) {
                    resp.sendRedirect(redirect);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/my-bookings");
                }
            } else {
                req.setAttribute("error", "Invalid email or password. Please try again.");
                req.setAttribute("redirectParam", redirect);
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Login failed: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
