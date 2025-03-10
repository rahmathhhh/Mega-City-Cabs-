<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form action="RegisterServlet" method="POST">
        <label for="name">Name:</label>
        <input type="text" name="name" required><br><br> <!-- Changed "username" to "name" -->

        <label for="email">Email:</label>
        <input type="email" name="email" required><br><br> <!-- Added email field -->

        <label for="password">Password:</label>
        <input type="password" name="password" required><br><br>

        <label for="phone">Phone Number:</label>
        <input type="text" name="phone" required><br><br>

        <button type="submit">Register</button>
    </form>

    <br><a href="login.jsp">Login</a>
</body>
</html>
