import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import megacitycabs.db.DatabaseConnection;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Fetch user, driver, and ride details
            String query = "SELECT user_id, driver_id, vehicle_type, ride_duration FROM bookings WHERE booking_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, bookingId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                int driverId = rs.getInt("driver_id");
                String vehicleType = rs.getString("vehicle_type");
                int rideDuration = rs.getInt("ride_duration"); // Ride duration in minutes

                // Set fare based on vehicle type (in ₹)
                double baseFare = 0.0, perMinuteRate = 0.0;
                switch (vehicleType.toLowerCase()) {
                    case "standard":
                        baseFare = 50.0;
                        perMinuteRate = 10.0;
                        break;
                    case "premier":
                        baseFare = 100.0;
                        perMinuteRate = 20.0;
                        break;
                    default:
                        response.getWriter().println("❌ Invalid vehicle type.");
                        return;
                }

                // Calculate total fare
                double totalFare = baseFare + (rideDuration * perMinuteRate);

                // Insert bill into the billing table
                String insertQuery = "INSERT INTO billing (booking_id, user_id, driver_id, fare, payment_status, payment_method) VALUES (?, ?, ?, ?, 'Pending', 'Cash')";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, bookingId);
                insertStmt.setInt(2, userId);
                insertStmt.setInt(3, driverId);
                insertStmt.setDouble(4, totalFare);

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("user_billing.jsp"); // Redirect user to billing page
                } else {
                    response.getWriter().println("❌ Error generating bill.");
                }
                insertStmt.close();
            } else {
                response.getWriter().println("❌ Booking not found.");
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error: " + e.getMessage());
        }
    }
}
