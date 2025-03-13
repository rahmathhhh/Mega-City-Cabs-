<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="megacitycabs.db.DatabaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    <style>
        /* Reset some default styling */
        body, h2, p {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        /* Page background */
        body {
            background-color: #f4f7f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* Container for the page content */
        .container {
            background-color: #ffffff;
            width: 80%;
            max-width: 1000px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        td a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
            padding: 5px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        td a:hover {
            background-color: #007bff;
            color: white;
        }

        .form-container {
            margin-top: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }

        .form-container input[type="text"],
        .form-container input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-container input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .form-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .message {
            margin-top: 20px;
            padding: 10px;
            background-color: #e7f3fe;
            border: 1px solid #b3d4fc;
            color: #0056b3;
            border-radius: 5px;
        }

        .back-button {
            display: block;
            width: fit-content;
            margin: 20px auto;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            text-align: center;
        }

        .back-button:hover {
            background-color: #0056b3;
        }

        /* Mobile responsiveness */
        @media (max-width: 768px) {
            .container {
                width: 100%;
                padding: 20px;
            }

            .form-container input[type="text"],
            .form-container input[type="email"] {
                font-size: 14px;
            }

            .form-container input[type="submit"] {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Manage Users</h2>

        <!-- Display message if available -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="message"><%= message %></div>
        <%
            }
        %>

        <table>
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
                    <a href="manage_users.jsp?editUser=<%= userID %>">Edit</a> | 
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

        <!-- Back to Dashboard Button -->
        <a href="admin_dashboard.jsp" class="back-button">Back to Dashboard</a>

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

        <div class="form-container">
            <h3>Edit User</h3>
            <form action="manage_users.jsp" method="post">
                <input type="hidden" name="userID" value="<%= editUserID %>">
                <label>Name:</label>
                <input type="text" name="name" value="<%= name %>"><br>
                <label>Email:</label>
                <input type="email" name="email" value="<%= email %>"><br>
                <label>Phone:</label>
                <input type="text" name="phone" value="<%= phone %>"><br>
                <input type="submit" value="Update">
            </form>
        </div>

        <%
                }
                rsEdit.close();
                pstmtEdit.close();
                connEdit.close();
            }
        %>
    </div>

</body>
</html>
