package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import megacitycabs.db.DatabaseConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            try {
                // Check if the email is already registered
                String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
                PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailQuery);
                checkEmailStmt.setString(1, email);
                ResultSet rs = checkEmailStmt.executeQuery();

                if (rs.next()) {
                    // Email already exists
                    response.getWriter().println("❌ This email is already registered.");
                } else {
                    // Proceed to register the new user
                    String query = "INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);  // Plain-text password (no hashing)
                    pstmt.setString(4, phone);

                    int rowsInserted = pstmt.executeUpdate();
                    
                    if (rowsInserted > 0) {
                        System.out.println("✅ User registered successfully!");
                        response.sendRedirect("login.jsp"); // Redirect to login page after successful registration
                    } else {
                        response.getWriter().println("❌ Registration failed!");
                    }

                    pstmt.close();
                }

                checkEmailStmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("❌ Error: " + e.getMessage());
            }
        } else {
            response.getWriter().println("❌ Database connection failed!");
        }
    }
}
