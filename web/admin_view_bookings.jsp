<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin View Bookings</title>
    <style>
        /* General body styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 20px;
        }

        /* Header styles */
        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 30px;
        }

        /* Table styling */
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
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Links and buttons */
        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Form and button styling */
        form {
            display: inline-block;
            margin: 0;
        }

        select, input[type="submit"] {
            padding: 8px;
            margin: 5px 0;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            cursor: pointer;
            border: none;
            color: white;
        }

        input[type="submit"]:hover {
            opacity: 0.8;
        }

        /* Specific button styling */
        .assign-btn {
            background-color: #007bff;  /* Blue background for the Assign button */
            color: white;
            font-weight: bold;
        }

        .assign-btn:hover {
            background-color: #0056b3;  /* Darker blue for hover effect */
        }

        /* Success and error message styling */
        .success {
            color: green;
            font-weight: bold;
        }

        .error {
            color: red;
            font-weight: bold;
        }

        /* Link to Admin Dashboard */
        .dashboard-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            font-size: 16px;
        }
    </style>
</head>
<body>

    <h2>Admin - View All Bookings</h2>

    <!-- Success/Error messages can be shown here -->
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="<%= message.startsWith("Error") ? "error" : "success" %>">
            <%= message %>
        </div>
    <%
        }
    %>

    <table>
        <thead>
            <tr>
                <th>Order Number</th>
                <th>User Name</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Destination</th>
                <th>Ride Date</th>
                <th>Ride Time</th>
                <th>Status</th>
                <th>Driver</th>
                <th>Total Fare</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>

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
                        String assignedDriver = rs.getString("driver_id"); // Assigned driver
                        double totalFare = rs.getDouble("total_fare"); // Total fare
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
                    <!-- Driver Assignment Form -->
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
                        <input type="submit" value="Assign" class="assign-btn">
                    </form>
                </td>

                <td>₹<%= totalFare %></td> <!-- Display total fare -->

                <td>
                    <!-- Accept/Reject Actions -->
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
        </tbody>
    </table>

    <div class="dashboard-link">
        <a href="admin_dashboard.jsp">Go to Admin Dashboard</a>
    </div>

</body>
</html>
