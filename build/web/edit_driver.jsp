<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="megacitycabs.db.DatabaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver</title>

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

        input, select {
            padding: 8px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #007bff; /* Blue Color */
            color: white;
            border: none;
            cursor: pointer;
            font-size: 1.1rem;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3; /* Darker Blue on Hover */
        }

        .form-group {
            margin-bottom: 20px;
        }

        .alerts {
            display: none;
            padding: 10px;
            margin: 20px 0;
            border-radius: 5px;
            text-align: center;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        a {
            text-decoration: none;
            color: #007bff; /* Blue Color */
            font-size: 1.1rem;
        }

        a:hover {
            text-decoration: underline;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Driver</h2>

        <%
            // ✅ Ensure driver_id is provided
            String driverIdParam = request.getParameter("driver_id");
            if (driverIdParam == null || driverIdParam.isEmpty()) {
                out.println("<script>alert('❌ Error: No driver selected.');</script>");
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
                        out.println("<script>alert('❌ Error: Driver not found.');</script>");
                        return;
                    }
                    rs.close();
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<script>alert('❌ Error fetching driver details: " + e.getMessage() + "');</script>");
                }
            }
        %>

        <!-- Alerts for Success and Error -->
        <div id="successAlert" class="alerts alert-success">
            ✅ Driver updated successfully!
        </div>
        <div id="errorAlert" class="alerts alert-error">
            ❌ Failed to update driver. Please try again.
        </div>

        <!-- Driver Edit Form -->
        <form action="edit_driver.jsp" method="post">
            <input type="hidden" name="driver_id" value="<%= driverId %>">

            <div class="form-group">
                <label>Name:</label> 
                <input type="text" name="name" value="<%= name %>" required>
            </div>
            <div class="form-group">
                <label>Phone:</label> 
                <input type="text" name="phone" value="<%= phone %>" required>
            </div>
            <div class="form-group">
                <label>License Number:</label> 
                <input type="text" name="license" value="<%= license %>" required>
            </div>
            
            <div class="form-group">
                <label>Car Type:</label>
                <select name="car_type">
                    <option value="Premier" <%= carType.equals("Premier") ? "selected" : "" %>>Premier</option>
                    <option value="Standard" <%= carType.equals("Standard") ? "selected" : "" %>>Standard</option>
                </select>
            </div>

            <div class="form-group">
                <label>Availability:</label>
                <select name="availability">
                    <option value="Available" <%= availability.equals("Available") ? "selected" : "" %>>Available</option>
                    <option value="Busy" <%= availability.equals("Busy") ? "selected" : "" %>>Busy</option>
                </select>
            </div>

            <div class="form-group">
                <input type="submit" name="action" value="Update Driver">
            </div>
        </form>

        <div class="back-btn">
            <a href="manage_drivers_and_cars.jsp">Cancel & Go Back</a>
        </div>

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
                        out.println("<script>alert('❌ Error: Invalid availability value.');</script>");
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
                        out.println("<script>document.getElementById('successAlert').style.display = 'block';</script>");
                        response.sendRedirect("manage_drivers_and_cars.jsp");
                    } else {
                        out.println("<script>document.getElementById('errorAlert').style.display = 'block';</script>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<script>alert('❌ Error updating driver: " + e.getMessage() + "');</script>");
                }
            }
        %>
    </div>
</body>
</html>
