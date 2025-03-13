<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Driver to Booking</title>

    <!-- CSS Styles for the page -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 70%;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #007bff; /* Blue Color */
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-size: 1.1rem;
            color: #333;
        }

        select {
            padding: 8px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff; /* Blue Color */
            color: white;
            border: none;
            cursor: pointer;
            font-size: 1.1rem;
            padding: 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3; /* Darker Blue on Hover */
        }

        .form-group {
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
        }

        a {
            text-decoration: none;
            color: #007bff; /* Blue Color */
            font-size: 1.1rem;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>

    <!-- JavaScript for Alerts -->
    <script>
        function showAlert(type, message) {
            if (type === 'success') {
                alert("✅ " + message);
            } else if (type === 'error') {
                alert("❌ " + message);
            }
        }
    </script>

</head>
<body>

    <div class="container">
        <h2>Assign Driver to Booking</h2>

        <form action="assign_driver.jsp" method="POST">
            <div class="form-group">
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
                </select>
            </div>

            <div class="form-group">
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
                </select>
            </div>

            <div class="form-group">
                <button type="submit" name="assign" value="Assign Driver">Assign Driver</button>
            </div>
        </form>

        <div class="back-btn">
            <a href="admin_dashboard.jsp">Back to Dashboard</a>
        </div>

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
                        out.println("<script>showAlert('error', 'Error assigning driver. Please try again.');</script>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<script>showAlert('error', 'Error assigning driver: " + e.getMessage() + "');</script>");
                } finally {
                    if (conn != null) {
                        conn.close();
                    }
                }

                // Redirect if successful
                if (success) {
                    out.println("<script>showAlert('success', 'Driver successfully assigned to booking.');</script>");
                    response.sendRedirect("admin_view_bookings.jsp");
                }
            }
        %>
    </div>

</body>
</html>
