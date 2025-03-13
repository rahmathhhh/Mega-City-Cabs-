<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Mega City Cabs</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* General Page Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Container for the bookings */
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            width: 90%;
            max-width: 1200px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: 2px solid #007bff; /* Blue border */
        }

        /* Heading */
        h2 {
            color: #007bff; /* Blue heading */
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Table Wrapper */
        .table-container {
            width: 100%;
            max-height: 500px; /* Set max height for scrollable area */
            overflow-y: auto; /* Enable vertical scrolling */
            margin-top: 20px;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            table-layout: fixed;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
            color: #555;
            font-size: 14px;
        }

        th {
            background-color: #007bff; /* Blue header */
            color: white;
            font-weight: bold;
        }

        /* Make the table header fixed */
        thead {
            position: sticky;
            top: 0;
            z-index: 10;
            background-color: #007bff; /* Blue background for header */
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e8f4ff;
        }

        /* Back to Dashboard Button */
        .back-link {
            margin-top: 20px;
            display: inline-block;
            background-color: #007bff;
            color: white;
            font-size: 18px;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .back-link:hover {
            background-color: #0056b3;
        }

        /* Error Message */
        .error {
            color: #ff4d4d; /* Red color for error */
            font-weight: bold;
        }

        /* Mobile Responsiveness */
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 20px;
            }

            h2 {
                font-size: 24px;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 8px;
            }

            .back-link {
                font-size: 16px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>📋 Your Ride Bookings</h2>

        <%
            if (session.getAttribute("userID") == null) {
                out.println("<p class='error'>❌ Session expired! Redirecting to login...</p>");
                response.sendRedirect("login.jsp");
                return;
            }

            Integer userID = (Integer) session.getAttribute("userID");
        %>

        <div class="table-container"> <!-- Wrapper to handle table scrolling -->
            <table>
                <thead>
                    <tr>
                        <th>Order No.</th>
                        <th>Name</th>
                        <th>Pickup</th>
                        <th>Phone</th>
                        <th>Destination</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Driver</th>
                        <th>Driver Phone</th>
                        <th>Car</th>
                        <th>Total Fare</th>
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
                                String query = "SELECT b.order_number, b.name, b.address, b.phone, b.destination, b.ride_date, b.ride_time, b.status, " +
                                               "d.name AS driver_name, d.phone AS driver_phone, d.car_type, b.total_fare " +
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
                        <td>₹<%= String.format("%.2f", totalFare) %></td>
                    </tr>
                    <%
                                }
                            }
                        } catch (SQLException e) {
                            out.println("<p class='error'>❌ Error fetching bookings. Please try again later.</p>");
                        }
                    %>
                </tbody>
            </table>
        </div> <!-- End Table Wrapper -->

        <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
    </div>

</body>
</html>
