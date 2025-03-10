package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import megacitycabs.db.DatabaseConnection;

@WebServlet("/BookRideServlet")
public class BookRideServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");  // Get user ID from session
        String name = (String) session.getAttribute("username"); // Fetch user's name from session
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String destination = request.getParameter("destination");
        String date = request.getParameter("date"); // New field for ride date
        String time = request.getParameter("time"); // New field for ride time

        // Generate a unique Order Number
        String orderNumber = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            try {
                String query = "INSERT INTO bookings (user_id, order_number, name, address, phone, destination, ride_date, ride_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, userID);
                pstmt.setString(2, orderNumber);
                pstmt.setString(3, name);
                pstmt.setString(4, address);
                pstmt.setString(5, phone);
                pstmt.setString(6, destination);
                pstmt.setString(7, date);
                pstmt.setString(8, time);

                int rowsInserted = pstmt.executeUpdate();
                
                if (rowsInserted > 0) {
                    System.out.println("✅ Ride booked successfully!");
                    response.sendRedirect("view_booking.jsp"); // Redirect to booking details page
                } else {
                    response.getWriter().println("❌ Booking failed!");
                }

                pstmt.close();
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
