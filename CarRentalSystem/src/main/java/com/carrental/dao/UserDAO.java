package com.carrental.dao;

import com.carrental.model.User;
import com.carrental.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UserDAO {

    // ── Registration ─────────────────────────────────────────────────────

    /**
     * Inserts a new user into the database.
     * The plain-text password is hashed with BCrypt before storage.
     *
     * @return true on success, false if the email is already registered.
     */
    public boolean registerUser(User user) throws SQLException {
        if (emailExists(user.getEmail())) return false;

        String sql = "INSERT INTO users (full_name, email, password, phone, address) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(12));
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashed);
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            return ps.executeUpdate() > 0;
        }
    }

    // ── Authentication ───────────────────────────────────────────────────

    /**
     * Validates credentials and returns the matching User, or null on failure.
     */
    public User loginUser(String email, String plainPassword) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password");
                    if (BCrypt.checkpw(plainPassword, hashed)) {
                        return mapRow(rs);
                    }
                }
            }
        }
        return null;
    }

    // ── Lookup ───────────────────────────────────────────────────────────

    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM users WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ── Profile update ───────────────────────────────────────────────────

    public boolean updateProfile(User user) throws SQLException {
        String sql = "UPDATE users SET full_name=?, phone=?, address=? WHERE user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getUserId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updatePassword(int userId, String oldPlain, String newPlain) throws SQLException {
        // Fetch current hash
        String selectSql = "SELECT password FROM users WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(selectSql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return false;
                String currentHash = rs.getString("password");
                if (!BCrypt.checkpw(oldPlain, currentHash)) return false;
            }
        }

        // Update to new hash
        String updateSql = "UPDATE users SET password=? WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(updateSql)) {

            ps.setString(1, BCrypt.hashpw(newPlain, BCrypt.gensalt(12)));
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // ── Mapping helper ───────────────────────────────────────────────────

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }
}
