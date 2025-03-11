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

    <table border="1" style="border-collapse: collapse;">
        <tr style="background-color: #f2f2f2;">
            <th>Order Number</th>
            <th>User Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Destination</th>
            <th>Ride Date</th>
            <th>Ride Time</th>
            <th>Status</th>
            <th>Driver</th>
            <th>Actions</th>
        </tr>

        <%
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null) {
                try {
                    String query = "SELECT * FROM bookings";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String orderNumber = rs.getString("order_number");
                        String name = rs.getString("name");
                        String address = rs.getString("address");
                        String phone = rs.getString("phone");
                        String destination = rs.getString("destination");
                        String rideDate = rs.getString("ride_date");
                        String rideTime = rs.getString("ride_time");
                        String status = rs.getString("status");
                        String assignedDriver = rs.getString("driver_id"); // Fetch assigned driver
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
                <form action="assign_driver.jsp" method="post">
                    <input type="hidden" name="orderNumber" value="<%= orderNumber %>">
                    <select name="driver_id">
                        <option value="">Select Driver</option>
                        <%
                            String driverQuery = "SELECT * FROM drivers WHERE availability='Available'";
                            Statement driverStmt = conn.createStatement();
                            ResultSet driverRs = driverStmt.executeQuery(driverQuery);

                            while (driverRs.next()) {
                                String driverId = driverRs.getString("id");
                                String driverName = driverRs.getString("name");
                                boolean isSelected = assignedDriver != null && assignedDriver.equals(driverId);
                        %>
                            <option value="<%= driverId %>" <%= isSelected ? "selected" : "" %>><%= driverName %></option>
                        <%
                            }
                            driverRs.close();
                            driverStmt.close();
                        %>
                    </select>
                    <input type="submit" value="Assign">
                </form>
            </td>

            <td>
                <form action="admin_view_bookings.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderNumber" value="<%= orderNumber %>">
                    <input type="submit" name="action" value="Accept" style="background-color: green; color: white;">
                </form>

                <form action="admin_view_bookings.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderNumber" value="<%= orderNumber %>">
                    <input type="submit" name="action" value="Reject" style="background-color: red; color: white;">
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

</body>
</html>
