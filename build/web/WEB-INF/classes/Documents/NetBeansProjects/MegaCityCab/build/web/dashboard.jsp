<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
</head>
<body>
    <h2>Welcome to your Dashboard</h2>
    <p>You are logged in as: <%= request.getSession().getAttribute("username") %></p>
    <h2>Welcome to Your Dashboard</h2>

<a href="book_ride.jsp">
    <button>Book a Ride</button>
</a>

    <a href="view_booking.jsp">
    <button>View My Bookings</button>
</a>

    <a href="logout.jsp">Logout</a>
</body>
</html>
