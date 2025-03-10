package megacitycabs.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/megacitycabs"; // Change port if needed
    private static final String USER = "root"; // Your MySQL username
    private static final String PASSWORD = "Rahmath@1660"; // Your MySQL password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("❌ Database Connection Failed: " + e.getMessage());
        }
        return conn;
    }
}
