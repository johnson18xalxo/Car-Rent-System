package com.carrental.dao;

import com.carrental.model.Car;
import com.carrental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {

    /** All cars (admin-style; not used on public pages). */
    public List<Car> getAllCars() throws SQLException {
        return query("SELECT * FROM cars ORDER BY car_id");
    }

    /** Only available cars for the search page. */
    public List<Car> getAvailableCars() throws SQLException {
        return query("SELECT * FROM cars WHERE is_available = 1 ORDER BY car_id");
    }

    /**
     * Available cars whose car_id is NOT already booked during the
     * requested [pickupDate, dropoffDate] window.
     */
    public List<Car> searchAvailableCars(String pickupDate, String dropoffDate)
            throws SQLException {

        String sql =
            "SELECT * FROM cars c WHERE c.is_available = 1 " +
            "AND c.car_id NOT IN ( " +
            "  SELECT b.car_id FROM bookings b " +
            "  WHERE b.status != 'Cancelled' " +
            "  AND NOT (b.dropoff_date < ? OR b.pickup_date > ?) " +
            ") ORDER BY c.car_id";

        List<Car> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, pickupDate);
            ps.setString(2, dropoffDate);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Fetch a single car by its primary key. */
    public Car getCarById(int carId) throws SQLException {
        String sql = "SELECT * FROM cars WHERE car_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // ── Internal helpers ──────────────────────────────────────────────────

    private List<Car> query(String sql) throws SQLException {
        List<Car> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    private Car mapRow(ResultSet rs) throws SQLException {
        Car c = new Car();
        c.setCarId(rs.getInt("car_id"));
        c.setCarName(rs.getString("car_name"));
        c.setModel(rs.getString("model"));
        c.setBrand(rs.getString("brand"));
        c.setCategory(rs.getString("category"));
        c.setFuelType(rs.getString("fuel_type"));
        c.setSeats(rs.getInt("seats"));
        c.setPricePerDay(rs.getBigDecimal("price_per_day"));
        c.setImageUrl(rs.getString("image_url"));
        c.setAvailable(rs.getBoolean("is_available"));
        c.setDescription(rs.getString("description"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}
