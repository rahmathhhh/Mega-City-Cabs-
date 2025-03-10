<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="megacitycabs.db.DatabaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
</head>
<body>
    <h2>Manage Users</h2>
    <table border="1">
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>

        <%
            Connection conn = DatabaseConnection.getConnection();
            String query = "SELECT * FROM users";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                int userID = rs.getInt("userID");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
        %>
        <tr>
            <td><%= userID %></td>
            <td><%= name %></td>
            <td><%= email %></td>
            <td><%= phone %></td>
            <td>
                <!-- Edit action -->
                <a href="manage_users.jsp?editUser=<%= userID %>">Edit</a> | 

                <!-- Delete action -->
                <a href="manage_users.jsp?deleteUser=<%= userID %>">Delete</a>
            </td>
        </tr>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        %>
    </table>

    <%
        // Handle the 'deleteUser' action
        String deleteUserID = request.getParameter("deleteUser");
        if (deleteUserID != null) {
            // Proceed with deleting the user
            Connection connDelete = DatabaseConnection.getConnection();
            String deleteQuery = "DELETE FROM users WHERE userID = ?";
            PreparedStatement pstmtDelete = connDelete.prepareStatement(deleteQuery);
            pstmtDelete.setInt(1, Integer.parseInt(deleteUserID));
            int rowsAffected = pstmtDelete.executeUpdate();
            
            if (rowsAffected > 0) {
                request.setAttribute("message", "User deleted successfully.");
            } else {
                request.setAttribute("message", "Failed to delete user.");
            }

            pstmtDelete.close();
            connDelete.close();
        }

        // Display message if available (success/failure)
        String message = (String) request.getAttribute("message");
        if (message != null) {
            out.println("<p>" + message + "</p>");
        }

        // Check if 'editUser' query parameter is set
        String editUserID = request.getParameter("editUser");
        if (editUserID != null) {
            // Fetch user details for editing
            Connection connEdit = DatabaseConnection.getConnection();
            String editQuery = "SELECT * FROM users WHERE userID = ?";
            PreparedStatement pstmtEdit = connEdit.prepareStatement(editQuery);
            pstmtEdit.setInt(1, Integer.parseInt(editUserID));
            ResultSet rsEdit = pstmtEdit.executeQuery();
            
            if (rsEdit.next()) {
                String name = rsEdit.getString("name");
                String email = rsEdit.getString("email");
                String phone = rsEdit.getString("phone");
    %>

    <h3>Edit User</h3>
    <form action="manage_users.jsp" method="post">
        <input type="hidden" name="userID" value="<%= editUserID %>">
        <label>Name:</label><input type="text" name="name" value="<%= name %>"><br>
        <label>Email:</label><input type="email" name="email" value="<%= email %>"><br>
        <label>Phone:</label><input type="text" name="phone" value="<%= phone %>"><br>
        <input type="submit" value="Update">
    </form>

    <%
            }
            rsEdit.close();
            pstmtEdit.close();
            connEdit.close();
        }

        // If the form is submitted (update user)
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String userID = request.getParameter("userID");
            String updatedName = request.getParameter("name");
            String updatedEmail = request.getParameter("email");
            String updatedPhone = request.getParameter("phone");

            // Update user in the database
            Connection connUpdate = DatabaseConnection.getConnection();
            String updateQuery = "UPDATE users SET name = ?, email = ?, phone = ? WHERE userID = ?";
            PreparedStatement pstmtUpdate = connUpdate.prepareStatement(updateQuery);
            pstmtUpdate.setString(1, updatedName);
            pstmtUpdate.setString(2, updatedEmail);
            pstmtUpdate.setString(3, updatedPhone);
            pstmtUpdate.setInt(4, Integer.parseInt(userID));

            int rowsUpdated = pstmtUpdate.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("<p>User updated successfully!</p>");
            } else {
                out.println("<p>Failed to update user.</p>");
            }

            pstmtUpdate.close();
            connUpdate.close();
        }
    %>

</body>
</html>
