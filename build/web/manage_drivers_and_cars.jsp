<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Drivers & Cars</title>
</head>
<body>
    <h2>Manage Drivers & Cars</h2>

    <!-- Form to Add a New Driver -->
    <h3>Add Driver</h3>
    <form action="manage_drivers_and_cars.jsp" method="post">
        <label>Name:</label> <input type="text" name="name" required><br>
        <label>Phone:</label> <input type="text" name="phone" required><br>
        <label>License Number:</label> <input type="text" name="license" required><br>
        <label>Car Type:</label>
        <select name="car_type">
            <option value="Premier">Premier</option>
            <option value="Standard">Standard</option>
        </select><br>
        <input type="submit" name="action" value="Add Driver">
    </form>

    <hr>

    <!-- Display All Drivers -->
    <h3>All Drivers</h3>
    <table border="1">
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
            <td>
                <form action="manage_drivers_and_cars.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="driver_id" value="<%= id %>">
                    <input type="submit" name="action" value="Delete">
                </form>
                <form action="edit_driver.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="driver_id" value="<%= id %>">
                    <input type="submit" value="Edit">
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
                        out.println("<p>✅ Driver added successfully!</p>");
                        response.sendRedirect("manage_drivers_and_cars.jsp");
                    } else {
                        out.println("<p>❌ Failed to add driver.</p>");
                    }
                    pstmt.close();
                } else if (action.equals("Delete")) {
                    int driverId = Integer.parseInt(request.getParameter("driver_id"));

                    String deleteQuery = "DELETE FROM drivers WHERE id=?";
                    PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
                    pstmt.setInt(1, driverId);

                    int deleted = pstmt.executeUpdate();
                    if (deleted > 0) {
                        out.println("<p>✅ Driver deleted successfully!</p>");
                        response.sendRedirect("manage_drivers_and_cars.jsp");
                    } else {
                        out.println("<p>❌ Failed to delete driver.</p>");
                    }
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error processing request: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
