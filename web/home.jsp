<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to MegaCity Cabs</title>
</head>
<body>
    <h1>Welcome, <%= request.getAttribute("username") %>!</h1>
    <h3>What would you like to do today?</h3>
    <ul>
        <li><a href="bookRide.jsp">Book a Ride</a></li>
        <li><a href="viewBookings.jsp">View Your Bookings</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>
