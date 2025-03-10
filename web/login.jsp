<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="LoginServlet" method="POST">
        <label for="email">Email:</label> <!-- Change this to 'email' -->
        <input type="text" name="email" required><br><br> <!-- Also change this to 'email' -->

        <label for="password">Password:</label>
        <input type="password" name="password" required><br><br>

        <button type="submit">Login</button>
    </form>

    <!-- Show error message if login fails -->
    <%
        String error = request.getParameter("error");
        if ("true".equals(error)) {
    %>
    <p style="color: red;">Invalid username or password! Please try again.</p>
    <%
        }
    %>

    <br><a href="register.jsp">Register</a>
</body>
</html>
