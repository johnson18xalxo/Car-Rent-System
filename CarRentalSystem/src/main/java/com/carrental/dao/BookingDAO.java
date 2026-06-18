package com.carrental.dao;

import com.carrental.model.Booking;
import com.carrental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    /** Persist a new booking and return the generated booking_id (or -1 on failure). */
    public int createBooking(Booking b) throws SQLException {
        String sql =
            "INSERT INTO bookings (user_id, car_id, pickup_date, dropoff_date, " +
            "pickup_location, extra_info, total_amount, status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, 'Confirmed')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getCarId());
            ps.setDate(3, b.getPickupDate());
            ps.setDate(4, b.getDropoffDate());
            ps.setString(5, b.getPickupLocation());
            ps.setString(6, b.getExtraInfo());
            ps.setBigDecimal(7, b.getTotalAmount());

            int rows = ps.executeUpdate();
            if (rows == 0) return -1;

            try (ResultSet gk = ps.getGeneratedKeys()) {
                return gk.next() ? gk.getInt(1) : -1;
            }
        }
    }

    /** All bookings for one user, newest first, joined with car details. */
    public List<Booking> getBookingsByUser(int userId) throws SQLException {
        String sql =
            "SELECT b.*, c.car_name, c.brand AS car_brand, c.model AS car_model, " +
            "c.image_url AS car_image_url " +
            "FROM bookings b " +
            "JOIN cars c ON b.car_id = c.car_id " +
            "WHERE b.user_id = ? " +
            "ORDER BY b.booked_at DESC";

        List<Booking> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Single booking by its primary key (used for confirmation page). */
    public Booking getBookingById(int bookingId) throws SQLException {
        String sql =
            "SELECT b.*, c.car_name, c.brand AS car_brand, c.model AS car_model, " +
            "c.image_url AS car_image_url, u.full_name AS user_full_name " +
            "FROM bookings b " +
            "JOIN cars c ON b.car_id  = c.car_id " +
            "JOIN users u ON b.user_id = u.user_id " +
            "WHERE b.booking_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking bk = mapRow(rs);
                    bk.setUserFullName(rs.getString("user_full_name"));
                    return bk;
                }
            }
        }
        return null;
    }

    /** Cancel a booking (only if it belongs to the given user). */
    public boolean cancelBooking(int bookingId, int userId) throws SQLException {
        String sql = "UPDATE bookings SET status = 'Cancelled' " +
                     "WHERE booking_id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Mapping helper ───────────────────────────────────────────────────

    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setCarId(rs.getInt("car_id"));
        b.setPickupDate(rs.getDate("pickup_date"));
        b.setDropoffDate(rs.getDate("dropoff_date"));
        b.setPickupLocation(rs.getString("pickup_location"));
        b.setExtraInfo(rs.getString("extra_info"));
        b.setTotalAmount(rs.getBigDecimal("total_amount"));
        b.setStatus(rs.getString("status"));
        b.setBookedAt(rs.getTimestamp("booked_at"));

        // joined columns (may be absent in some queries)
        try { b.setCarName(rs.getString("car_name")); }      catch (SQLException ignored) {}
        try { b.setCarBrand(rs.getString("car_brand")); }    catch (SQLException ignored) {}
        try { b.setCarModel(rs.getString("car_model")); }    catch (SQLException ignored) {}
        try { b.setCarImageUrl(rs.getString("car_image_url")); } catch (SQLException ignored) {}
        return b;
    }
}
