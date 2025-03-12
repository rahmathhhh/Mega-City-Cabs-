<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Your Ride Bookings</h2>

    <%
        // Debugging session
        if (session.getAttribute("userID") == null) {
            out.println("<p class='error'>❌ Session expired! Redirecting to login...</p>");
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userID = (Integer) session.getAttribute("userID");
    %>

    <table>
        <thead>
            <tr>
                <th>Order Number</th>
                <th>Name</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Destination</th>
                <th>Ride Date</th>
                <th>Ride Time</th>
                <th>Status</th>
                <th>Assigned Driver</th>
                <th>Driver Phone</th>
                <th>Car Type</th>
                <th>Total Fare</th> <!-- Added column for total fare -->
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    conn = megacitycabs.db.DatabaseConnection.getConnection();
                    if (conn == null) {
                        out.println("<p class='error'>❌ Database connection failed!</p>");
                    } else {
                        // Updated query to include driver details and total fare
                        String query = "SELECT b.order_number, b.name, b.address, b.phone, b.destination, b.ride_date, b.ride_time, b.status, " +
                                       "d.name AS driver_name, d.phone AS driver_phone, d.car_type, b.total_fare " +  // Added total_fare column
                                       "FROM bookings b " +
                                       "LEFT JOIN drivers d ON b.driver_id = d.id " +
                                       "WHERE b.user_id = ? " +
                                       "ORDER BY b.ride_date DESC";

                        pstmt = conn.prepareStatement(query);
                        pstmt.setInt(1, userID);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String driverName = rs.getString("driver_name");
                            String driverPhone = rs.getString("driver_phone");
                            String carType = rs.getString("car_type");
                            double totalFare = rs.getDouble("total_fare");

                            // If no driver assigned yet, show "Not Assigned"
                            if (driverName == null) {
                                driverName = "Not Assigned";
                                driverPhone = "-";
                                carType = "-";
                            }
            %>
            <tr>
                <td><%= rs.getString("order_number") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("address") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("destination") %></td>
                <td><%= rs.getString("ride_date") %></td>
                <td><%= rs.getString("ride_time") %></td>
                <td><%= rs.getString("status") %></td>
                <td><%= driverName %></td>
                <td><%= driverPhone %></td>
                <td><%= carType %></td>
                <td>₹<%= String.format("%.2f", totalFare) %></td> <!-- Display total fare formatted to two decimal places -->
            </tr>
            <%
                        }
                    }
                } catch (SQLException e) {
                    out.println("<p class='error'>❌ Error fetching bookings. Please try again later.</p>");
                } finally {
                    // Ensure all resources are closed
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>

    <br><a href="dashboard.jsp">Go to Dashboard</a>
</body>
</html>
