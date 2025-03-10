package models;

import megacitycabs.db.DatabaseConnection;
import java.sql.*;

public class CustomerDAO {

    // Register a new customer
    public static boolean registerCustomer(Customer customer) {
        String sql = "INSERT INTO customers (name, email, password, phone) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPassword());
            stmt.setString(4, customer.getPhone());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Registration Failed: " + e.getMessage());
            return false;
        }
    }

    // Authenticate customer login
    public static Customer authenticate(String email, String password) {
        String sql = "SELECT * FROM customers WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customerID"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone")
                );
            }
        } catch (SQLException e) {
            System.err.println("❌ Login Failed: " + e.getMessage());
        }
        return null;
    }
}
