<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Driver to Booking</title>
</head>
<body>
    <h2>Assign Driver to Booking</h2>

    <form action="assign_driver.jsp" method="POST">
        <label for="booking_id">Select Booking:</label>
        <select name="booking_id" required>
            <%
                Connection conn = DatabaseConnection.getConnection();
                if (conn != null) {
                    try {
                        String query = "SELECT booking_id, order_number, name FROM bookings WHERE status = 'Pending'";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        ResultSet rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int bookingId = rs.getInt("booking_id");
                            String orderNumber = rs.getString("order_number");
                            String customerName = rs.getString("name");
            %>
                            <option value="<%= bookingId %>">Order: <%= orderNumber %> - <%= customerName %></option>
            <%
                        }
                        rs.close();
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select><br><br>

        <label for="driver_id">Select Driver:</label>
        <select name="driver_id" required>
            <%
                try {
                    // Fetch available drivers
                    String driverQuery = "SELECT id, name FROM drivers WHERE availability = 'Available'";
                    PreparedStatement driverStmt = conn.prepareStatement(driverQuery);
                    ResultSet driverRs = driverStmt.executeQuery();

                    while (driverRs.next()) {
                        int driverId = driverRs.getInt("id");
                        String driverName = driverRs.getString("name");
            %>
                        <option value="<%= driverId %>"><%= driverName %></option>
            <%
                    }
                    driverRs.close();
                    driverStmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select><br><br>

        <button type="submit" name="assign" value="Assign Driver">Assign Driver</button>
    </form>

    <br><a href="admin_dashboard.jsp">Back to Dashboard</a>

    <%-- Handle Assign Driver Logic --%>
    <%
        if ("Assign Driver".equals(request.getParameter("assign"))) {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            int driverId = Integer.parseInt(request.getParameter("driver_id"));
            boolean success = false;

            try {
                // Update the booking with the assigned driver
                String updateQuery = "UPDATE bookings SET driver_id = ?, status = 'Accepted' WHERE booking_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, driverId);
                updateStmt.setInt(2, bookingId);
                
                int updated = updateStmt.executeUpdate();
                updateStmt.close();

                if (updated > 0) {
                    // Set driver availability to "Busy"
                    String driverUpdateQuery = "UPDATE drivers SET availability = 'Busy' WHERE id = ?";
                    PreparedStatement driverPstmt = conn.prepareStatement(driverUpdateQuery);
                    driverPstmt.setInt(1, driverId);
                    driverPstmt.executeUpdate();
                    driverPstmt.close();

                    success = true;
                } else {
                    out.println("<p>❌ Error assigning driver. Please try again.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>❌ Error assigning driver: " + e.getMessage() + "</p>");
            } finally {
                if (conn != null) {
                    conn.close();
                }
            }

            // Redirect if successful
            if (success) {
                response.sendRedirect("admin_view_bookings.jsp");
            }
        }
    %>
</body>
</html>
