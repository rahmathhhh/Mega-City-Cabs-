<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver</title>
</head>
<body>
    <h2>Edit Driver</h2>

    <%
        // ✅ Ensure driver_id is provided
        String driverIdParam = request.getParameter("driver_id");
        if (driverIdParam == null || driverIdParam.isEmpty()) {
            out.println("<p>❌ Error: No driver selected.</p>");
            return;
        }

        int driverId = Integer.parseInt(driverIdParam);
        Connection conn = DatabaseConnection.getConnection();
        String name = "", phone = "", license = "", carType = "", availability = "";

        if (conn != null) {
            try {
                String query = "SELECT * FROM drivers WHERE id=?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, driverId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    name = rs.getString("name");
                    phone = rs.getString("phone");
                    license = rs.getString("license_number");
                    carType = rs.getString("car_type");
                    availability = rs.getString("availability");
                } else {
                    out.println("<p>❌ Error: Driver not found.</p>");
                    return;
                }
                rs.close();
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>❌ Error fetching driver details: " + e.getMessage() + "</p>");
            }
        }
    %>

    <!-- Driver Edit Form -->
    <form action="edit_driver.jsp" method="post">
        <input type="hidden" name="driver_id" value="<%= driverId %>">

        <label>Name:</label> <input type="text" name="name" value="<%= name %>" required><br>
        <label>Phone:</label> <input type="text" name="phone" value="<%= phone %>" required><br>
        <label>License Number:</label> <input type="text" name="license" value="<%= license %>" required><br>
        
        <label>Car Type:</label>
        <select name="car_type">
            <option value="Premier" <%= carType.equals("Premier") ? "selected" : "" %>>Premier</option>
            <option value="Standard" <%= carType.equals("Standard") ? "selected" : "" %>>Standard</option>
        </select><br>

        <label>Availability:</label>
        <select name="availability">
            <option value="Available" <%= availability.equals("Available") ? "selected" : "" %>>Available</option>
            <option value="Busy" <%= availability.equals("Busy") ? "selected" : "" %>>Busy</option>
        </select><br>

        <input type="submit" name="action" value="Update Driver">
    </form>

    <br><a href="manage_drivers_and_cars.jsp">Cancel & Go Back</a>

    <%-- Handle Update Logic --%>
    <%
        if ("Update Driver".equals(request.getParameter("action"))) {
            try {
                String newName = request.getParameter("name").trim();
                String newPhone = request.getParameter("phone").trim();
                String newLicense = request.getParameter("license").trim();
                String newCarType = request.getParameter("car_type").trim();
                String newAvailability = request.getParameter("availability").trim();

                // ✅ Ensure valid ENUM values
                if (!newAvailability.equals("Available") && !newAvailability.equals("Busy")) {
                    out.println("<p>❌ Error: Invalid availability value.</p>");
                    return;
                }

                String updateQuery = "UPDATE drivers SET name=?, phone=?, license_number=?, car_type=?, availability=? WHERE id=?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, newName);
                updateStmt.setString(2, newPhone);
                updateStmt.setString(3, newLicense);
                updateStmt.setString(4, newCarType);
                updateStmt.setString(5, newAvailability);
                updateStmt.setInt(6, driverId);

                int updated = updateStmt.executeUpdate();
                updateStmt.close();

                if (updated > 0) {
                    response.sendRedirect("manage_drivers_and_cars.jsp"); // ✅ Redirect after update
                } else {
                    out.println("<p>❌ Failed to update driver. Please try again.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>❌ Error updating driver: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
