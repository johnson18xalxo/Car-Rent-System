package com.carrental.servlet;

import com.carrental.dao.BookingDAO;
import com.carrental.model.Booking;
import com.carrental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class MyBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (loggedUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Show a success banner when redirected after a new booking
        String bookedId = req.getParameter("booked");
        if (bookedId != null) req.setAttribute("newBookingId", bookedId);

        // Cancel action
        String cancelId = req.getParameter("cancel");
        if (cancelId != null) {
            try {
                bookingDAO.cancelBooking(Integer.parseInt(cancelId), loggedUser.getUserId());
                req.setAttribute("cancelMsg", "Booking #" + cancelId + " has been cancelled.");
            } catch (Exception e) {
                req.setAttribute("error", "Could not cancel booking: " + e.getMessage());
            }
        }

        try {
            List<Booking> bookings = bookingDAO.getBookingsByUser(loggedUser.getUserId());
            req.setAttribute("bookings", bookings);
        } catch (Exception e) {
            req.setAttribute("error", "Could not load bookings: " + e.getMessage());
        }

        req.getRequestDispatcher("/my-bookings.jsp").forward(req, resp);
    }
}
