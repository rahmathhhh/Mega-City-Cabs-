<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Drivers & Cars</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            padding: 20px;
            background-color: #0044cc;
            color: #fff;
            margin: 0;
        }
        h3 {
            color: #0044cc;
        }
        .container {
            width: 80%;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
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
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        .form-container {
            margin-bottom: 30px;
        }
        .form-container input, .form-container select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            width: auto;
        }
        .form-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .message {
            text-align: center;
            padding: 10px;
            margin-top: 20px;
            border-radius: 5px;
        }
        .success {
            background-color: #28a745;
            color: white;
        }
        .error {
            background-color: #dc3545;
            color: white;
        }
        .actions form {
            display: inline;
            margin-right: 10px;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2>Manage Drivers & Cars</h2>

    <div class="container">
        <!-- Form to Add a New Driver -->
        <div class="form-container">
            <h3>Add Driver</h3>
            <form action="manage_drivers_and_cars.jsp" method="post">
                <label for="name">Name:</label> <input type="text" name="name" id="name" required><br>
                <label for="phone">Phone:</label> <input type="text" name="phone" id="phone" required><br>
                <label for="license">License Number:</label> <input type="text" name="license" id="license" required><br>
                <label for="car_type">Car Type:</label>
                <select name="car_type" id="car_type">
                    <option value="Premier">Premier</option>
                    <option value="Standard">Standard</option>
                </select><br>
                <input type="submit" name="action" value="Add Driver">
            </form>
        </div>

        <hr>

        <!-- Display All Drivers -->
        <h3>All Drivers</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>License Number</th>
                <th>Car Type</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>

            <%
                Connection conn = DatabaseConnection.getConnection();
                if (conn != null) {
                    try {
                        String query = "SELECT * FROM drivers";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String phone = rs.getString("phone");
                            String license = rs.getString("license_number");
                            String carType = rs.getString("car_type");
                            String availability = rs.getString("availability");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= phone %></td>
                <td><%= license %></td>
                <td><%= carType %></td>
                <td><%= availability %></td>
                <td class="actions">
                    <form action="manage_drivers_and_cars.jsp" method="post">
                        <input type="hidden" name="driver_id" value="<%= id %>">
                        <input type="submit" name="action" value="Delete" style="background-color: #dc3545; color: white;">
                    </form>
                    <form action="edit_driver.jsp" method="get">
                        <input type="hidden" name="driver_id" value="<%= id %>">
                        <input type="submit" value="Edit" style="background-color: #007bff; color: white;">
                    </form>
                </td>
            </tr>
            <%
                        }
                        rs.close();
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error fetching drivers: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>Database connection failed!</p>");
                }
            %>
        </table>

        <br><a href="admin_dashboard.jsp">Back to Admin Dashboard</a>

        <%-- Handle Add/Delete Actions --%>
        <%
            String action = request.getParameter("action");

            if (action != null) {
                try {
                    if (action.equals("Add Driver")) {
                        String name = request.getParameter("name");
                        String phone = request.getParameter("phone");
                        String license = request.getParameter("license");
                        String carType = request.getParameter("car_type");

                        String insertQuery = "INSERT INTO drivers (name, phone, license_number, car_type, availability) VALUES (?, ?, ?, ?, 'Available')";
                        PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                        pstmt.setString(1, name);
                        pstmt.setString(2, phone);
                        pstmt.setString(3, license);
                        pstmt.setString(4, carType);

                        int added = pstmt.executeUpdate();
                        if (added > 0) {
                            request.setAttribute("message", "✅ Driver added successfully!");
                            response.sendRedirect("manage_drivers_and_cars.jsp");
                        } else {
                            request.setAttribute("message", "❌ Failed to add driver.");
                            response.sendRedirect("manage_drivers_and_cars.jsp");
                        }
                        pstmt.close();
                    } else if (action.equals("Delete")) {
                        int driverId = Integer.parseInt(request.getParameter("driver_id"));

                        String deleteQuery = "DELETE FROM drivers WHERE id=?";
                        PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
                        pstmt.setInt(1, driverId);

                        int deleted = pstmt.executeUpdate();
                        if (deleted > 0) {
                            request.setAttribute("message", "✅ Driver deleted successfully!");
                            response.sendRedirect("manage_drivers_and_cars.jsp");
                        } else {
                            request.setAttribute("message", "❌ Failed to delete driver.");
                            response.sendRedirect("manage_drivers_and_cars.jsp");
                        }
                        pstmt.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("message", "❌ Error processing request: " + e.getMessage());
                    response.sendRedirect("manage_drivers_and_cars.jsp");
                }
            }
        %>

        <%
            // Display success/error message (if any)
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="message <%= message.startsWith("❌") ? "error" : "success" %>">
                <%= message %>
            </div>
        <%
            }
        %>

    </div>

</body>
</html>
