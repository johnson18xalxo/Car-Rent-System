package com.carrental.servlet;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class MyAccountServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (loggedUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.getRequestDispatcher("/my-account.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (loggedUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("updateProfile".equals(action)) {
                loggedUser.setFullName(req.getParameter("fullName").trim());
                loggedUser.setPhone(req.getParameter("phone").trim());
                loggedUser.setAddress(req.getParameter("address").trim());

                boolean ok = userDAO.updateProfile(loggedUser);
                if (ok) {
                    session.setAttribute("loggedUser", loggedUser);
                    session.setAttribute("userName",   loggedUser.getFullName());
                    req.setAttribute("successProfile", "Profile updated successfully.");
                } else {
                    req.setAttribute("errorProfile", "Could not update profile.");
                }

            } else if ("updatePassword".equals(action)) {
                String oldPass = req.getParameter("oldPassword");
                String newPass = req.getParameter("newPassword");

                boolean ok = userDAO.updatePassword(loggedUser.getUserId(), oldPass, newPass);
                if (ok) {
                    req.setAttribute("successPwd", "Password changed successfully.");
                } else {
                    req.setAttribute("errorPwd", "Current password is incorrect.");
                }
            }
        } catch (Exception e) {
            req.setAttribute("errorProfile", "Error: " + e.getMessage());
        }

        req.getRequestDispatcher("/my-account.jsp").forward(req, resp);
    }
}
