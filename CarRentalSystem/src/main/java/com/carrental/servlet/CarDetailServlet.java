package com.carrental.servlet;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CarDetailServlet extends HttpServlet {

    private final CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String carIdStr    = req.getParameter("carId");
        String pickupDate  = req.getParameter("pickupDate");
        String dropoffDate = req.getParameter("dropoffDate");

        if (carIdStr == null) {
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        try {
            int carId = Integer.parseInt(carIdStr);
            Car car   = carDAO.getCarById(carId);

            if (car == null) {
                req.setAttribute("error", "Car not found.");
                req.getRequestDispatcher("/search.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("car",        car);
            req.setAttribute("pickupDate",  pickupDate  != null ? pickupDate  : "");
            req.setAttribute("dropoffDate", dropoffDate != null ? dropoffDate : "");
            req.getRequestDispatcher("/car-detail.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/search.jsp").forward(req, resp);
        }
    }
}
