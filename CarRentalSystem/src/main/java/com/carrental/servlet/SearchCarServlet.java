package com.carrental.servlet;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class SearchCarServlet extends HttpServlet {

    private final CarDAO carDAO = new CarDAO();

    /** GET → render the search form (with all available cars on first load) */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pickupDate  = req.getParameter("pickupDate");
        String dropoffDate = req.getParameter("dropoffDate");

        try {
            List<Car> cars;
            if (pickupDate != null && !pickupDate.isEmpty()
                    && dropoffDate != null && !dropoffDate.isEmpty()) {
                cars = carDAO.searchAvailableCars(pickupDate, dropoffDate);
                req.setAttribute("pickupDate",  pickupDate);
                req.setAttribute("dropoffDate", dropoffDate);
                req.setAttribute("searched",    true);
            } else {
                cars = carDAO.getAvailableCars();
            }
            req.setAttribute("cars", cars);
        } catch (Exception e) {
            req.setAttribute("error", "Error fetching cars: " + e.getMessage());
        }

        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }
}
