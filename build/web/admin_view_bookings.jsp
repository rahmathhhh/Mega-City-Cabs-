<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin View Bookings</title>
</head>
<body>
    <h2>Admin - View All Bookings</h2>

    <table border="1">
        <tr>
            <th>Order Number</th>
            <th>User Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Destination</th>
            <th>Ride Date</th>
            <th>Ride Time</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
            // Fetch all bookings from the database
            Connection conn = DatabaseConnection.getConnection();  // Declare the connection once
            if (conn != null) {
                try {
                    String query = "SELECT * FROM bookings"; // Fetch all bookings
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int userID = rs.getInt("user_id");
                        String orderNumber = rs.getString("order_number");
                        String name = rs.getString("name");
                        String address = rs.getString("address");
                        String phone = rs.getString("phone");
                        String destination = rs.getString("destination");
                        String rideDate = rs.getString("ride_date");
                        String rideTime = rs.getString("ride_time");
                        String status = rs.getString("status"); // Assuming 'status' is a column in bookings table
        %>

        <tr>
            <td><%= orderNumber %></td>
            <td><%= name %></td>
            <td><%= address %></td>
            <td><%= phone %></td>
            <td><%= destination %></td>
            <td><%= rideDate %></td>
            <td><%= rideTime %></td>
            <td><%= status %></td>
            <td>
                <!-- Accept Form -->
                <form action="admin_view_bookings.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderNumber" value="<%= orderNumber %>">
                    <input type="submit" name="action" value="Accept">
                </form>

                <!-- Reject Form -->
                <form action="admin_view_bookings.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderNumber" value="<%= orderNumber %>">
                    <input type="submit" name="action" value="Reject">
                </form>
            </td>
        </tr>

        <%
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("❌ Error fetching bookings: " + e.getMessage());
                }
            } else {
                out.println("❌ Database connection failed!");
            }
        %>
    </table>

    <br><a href="admin_dashboard.jsp">Go to Admin Dashboard</a>

    <%-- Handle Accept and Reject actions --%>
    <%
        // If the form is submitted (accept or reject action)
        String orderNumber = request.getParameter("orderNumber");
        String action = request.getParameter("action");

        if (orderNumber != null && action != null) {
            try {
                String statusUpdate = "";
                if (action.equals("Accept")) {
                    statusUpdate = "Accepted";
                } else if (action.equals("Reject")) {
                    statusUpdate = "Rejected";
                }

                if (!statusUpdate.isEmpty()) {
                    // Update the status of the booking in the database
                    String query = "UPDATE bookings SET status = ? WHERE order_number = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query); // Use the existing connection here
                    pstmt.setString(1, statusUpdate);
                    pstmt.setString(2, orderNumber);

                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p>Booking " + action + " successfully!</p>");
                    } else {
                        out.println("<p>❌ Error updating booking status.</p>");
                    }

                    pstmt.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
                out.println("❌ Error updating booking status: " + e.getMessage());
            }
        }
    %>
</body>
</html>
