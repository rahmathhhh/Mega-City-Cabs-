<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>
</head>
<body>
    <h2>Your Ride Bookings</h2>

    <table border="1">
        <tr>
            <th>Order Number</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Destination</th>
            <th>Ride Date</th>
            <th>Ride Time</th>
            <th>Status</th> <!-- New Status column -->
        </tr>

        <%
            out.println("Session Debug - userID: " + session.getAttribute("userID"));
            if (session.getAttribute("userID") == null) {
                    out.println("❌ Session userID is NULL. Redirecting...");
                    response.sendRedirect("login.jsp");
                    return;
            }

            Integer userID = (Integer) session.getAttribute("userID");

            Connection conn = megacitycabs.db.DatabaseConnection.getConnection();
            if (conn != null) {
                try {
                    // Updated query to include 'status' column
                    String query = "SELECT order_number, name, address, phone, destination, ride_date, ride_time, status FROM bookings WHERE user_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, userID);

                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("order_number") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("destination") %></td>
            <td><%= rs.getString("ride_date") %></td>
            <td><%= rs.getString("ride_time") %></td>
            <td><%= rs.getString("status") %></td> <!-- Display the booking status -->
        </tr>
        <%
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
        %>
        <tr>
            <td colspan="8">❌ Error fetching bookings: <%= e.getMessage() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="8">❌ Database connection failed!</td>
        </tr>
        <%
            }
        %>
    </table>

    <br><a href="dashboard.jsp">Go to Dashboard</a>
</body>
</html>
