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

        // Get session and user info
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        String name = (String) session.getAttribute("username"); 
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String destination = request.getParameter("destination");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        
        // Get the ride duration from the form and handle missing or invalid values
        String rideDurationStr = request.getParameter("ride_duration");
        int rideDuration = 0;
        
        if (rideDurationStr == null || rideDurationStr.isEmpty()) {
            response.getWriter().println("❌ Ride duration is required.");
            return;
        }
        
        try {
            rideDuration = Integer.parseInt(rideDurationStr);  // Duration in minutes
        } catch (NumberFormatException e) {
            response.getWriter().println("❌ Invalid ride duration.");
            return;
        }
        
        // Fare Calculation
        double baseFare = 50.0;  // Base fare in rupees
        double ratePerMinute = 1.0;  // Rate per minute in rupees
        double totalFare = baseFare + (rideDuration * ratePerMinute);  // Calculate total fare
        
        // Generate a unique Order Number
        String orderNumber = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            try {
                // Include ride_duration and total_fare in the query
                String query = "INSERT INTO bookings (user_id, order_number, name, address, phone, destination, ride_date, ride_time, ride_duration, total_fare, status) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, userID);
                pstmt.setString(2, orderNumber);
                pstmt.setString(3, name);
                pstmt.setString(4, address);
                pstmt.setString(5, phone);
                pstmt.setString(6, destination);
                pstmt.setString(7, date);
                pstmt.setString(8, time);
                pstmt.setInt(9, rideDuration);  // Use ride_duration here
                pstmt.setDouble(10, totalFare);  // Insert the calculated total fare
                pstmt.setString(11, "Pending");  // Explicitly set status to 'Pending'

                int rowsInserted = pstmt.executeUpdate();
                
                if (rowsInserted > 0) {
                    System.out.println("✅ Ride booked successfully!");

                    // Forward the booking details and total fare to view_booking.jsp
                    request.setAttribute("orderNumber", orderNumber);
                    request.setAttribute("name", name);
                    request.setAttribute("address", address);
                    request.setAttribute("destination", destination);
                    request.setAttribute("date", date);
                    request.setAttribute("time", time);
                    request.setAttribute("rideDuration", rideDuration);  // Changed from duration to rideDuration
                    request.setAttribute("totalFare", totalFare);

                    request.getRequestDispatcher("view_booking.jsp").forward(request, response);
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
