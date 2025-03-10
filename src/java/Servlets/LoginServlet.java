package Servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;
import megacitycabs.db.DatabaseConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if admin login (fixed email check)
        if ("admin@admin.com".equals(email) && "admin123".equals(password)) {
            response.sendRedirect("admin_dashboard.jsp");
            return;
        }

        // Validate regular user login
        try (Connection conn = DatabaseConnection.getConnection()) {
            if (conn != null) {
                String query = "SELECT userID, name FROM users WHERE email = ? AND password = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                    pstmt.setString(1, email);
                    pstmt.setString(2, password);

                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            HttpSession session = request.getSession();
                            session.setAttribute("userID", rs.getInt("userID"));
                            session.setAttribute("username", rs.getString("name"));

                            System.out.println("User logged in - ID: " + rs.getInt("userID") + ", Name: " + rs.getString("name"));
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            response.sendRedirect("login.jsp?error=true");
                        }
                    }
                }
            } else {
                response.getWriter().println("❌ Database connection failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("❌ Database error: " + e.getMessage());
        }
    }
}
