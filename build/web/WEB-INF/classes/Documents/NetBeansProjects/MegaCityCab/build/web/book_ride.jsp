<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride</title>
</head>
<body>
    <h2>Book a Ride</h2>
    <form action="BookRideServlet" method="POST">
        <label for="address">Pickup Location:</label>
        <input type="text" name="address" required><br><br>

        <label for="phone">Phone Number:</label>
        <input type="text" name="phone" required><br><br>

        <label for="destination">Destination:</label>
        <input type="text" name="destination" required><br><br>

        <label for="date">Ride Date:</label>
        <input type="date" name="date" required><br><br>

        <label for="time">Ride Time:</label>
        <input type="time" name="time" required><br><br>

        <button type="submit">Book Ride</button>
</form>


    <br>
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>
