<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
</head>
<body>
    <h2>Welcome to Admin Dashboard</h2>
    <p>Admin logged in as: <%= request.getSession().getAttribute("username") %></p>

    <!-- Admin Links -->
    <a href="manage_users.jsp">Manage Users</a><br>
    <a href="admin_view_bookings.jsp">View Bookings</a><br>  <!-- New Link to View Bookings -->
    <a href="logout.jsp">Logout</a>
</body>
</html>
