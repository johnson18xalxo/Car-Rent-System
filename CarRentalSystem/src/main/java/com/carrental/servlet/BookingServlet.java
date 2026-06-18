package com.carrental.servlet;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.CarDAO;
import com.carrental.model.Booking;
import com.carrental.model.Car;
import com.carrental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

public class BookingServlet extends HttpServlet {

    private final CarDAO     carDAO     = new CarDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    /** GET: show the booking form – requires login */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        String carIdStr    = req.getParameter("carId");
        String pickupDate  = req.getParameter("pickupDate");
        String dropoffDate = req.getParameter("dropoffDate");

        if (carIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        // Build the post-login redirect URL
        String redirectUrl = req.getContextPath() + "/booking?carId=" + carIdStr
                + "&pickupDate="  + (pickupDate  != null ? pickupDate  : "")
                + "&dropoffDate=" + (dropoffDate != null ? dropoffDate : "");

        if (loggedUser == null) {
            // Not logged in – redirect to login with return URL
            resp.sendRedirect(req.getContextPath() + "/login?redirect="
                    + java.net.URLEncoder.encode(redirectUrl, "UTF-8"));
            return;
        }

        try {
            Car car = carDAO.getCarById(Integer.parseInt(carIdStr));
            if (car == null) {
                resp.sendRedirect(req.getContextPath() + "/search");
                return;
            }
            req.setAttribute("car",        car);
            req.setAttribute("pickupDate",  pickupDate  != null ? pickupDate  : "");
            req.setAttribute("dropoffDate", dropoffDate != null ? dropoffDate : "");
            req.setAttribute("loggedUser",  loggedUser);
            req.getRequestDispatcher("/booking.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/search.jsp").forward(req, resp);
        }
    }

    /** POST: save booking to the database */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User loggedUser = (session != null) ? (User) session.getAttribute("loggedUser") : null;

        if (loggedUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int    carId          = Integer.parseInt(req.getParameter("carId"));
            String pickupDateStr  = req.getParameter("pickupDate");
            String dropoffDateStr = req.getParameter("dropoffDate");
            String pickupLocation = req.getParameter("pickupLocation");
            String extraInfo      = req.getParameter("extraInfo");

            Car car = carDAO.getCarById(carId);
            if (car == null) throw new Exception("Car not found.");

            Date pickup  = Date.valueOf(pickupDateStr);
            Date dropoff = Date.valueOf(dropoffDateStr);

            long days        = Math.max(1, (dropoff.getTime() - pickup.getTime()) / (1000 * 60 * 60 * 24));
            BigDecimal total = car.getPricePerDay().multiply(BigDecimal.valueOf(days));

            Booking booking = new Booking();
            booking.setUserId(loggedUser.getUserId());
            booking.setCarId(carId);
            booking.setPickupDate(pickup);
            booking.setDropoffDate(dropoff);
            booking.setPickupLocation(pickupLocation);
            booking.setExtraInfo(extraInfo);
            booking.setTotalAmount(total);

            int newId = bookingDAO.createBooking(booking);
            if (newId > 0) {
                resp.sendRedirect(req.getContextPath() + "/my-bookings?booked=" + newId);
            } else {
                throw new Exception("Booking could not be saved.");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Booking failed: " + e.getMessage());
            req.getRequestDispatcher("/booking.jsp").forward(req, resp);
        }
    }
}
