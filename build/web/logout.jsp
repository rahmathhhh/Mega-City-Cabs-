<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%
    // Invalidate the session to log the user out
    session.invalidate(); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
</head>
<body>
    <h2>Logout</h2>
    <p>You have successfully logged out.</p>
    
    <a href="login.jsp">Login again</a>

    <script>
        // After a few seconds, automatically redirect to the login page
        setTimeout(function() {
            window.location.href = "login.jsp";
        }, 3000); // Redirects after 3 seconds
    </script>
</body>
</html>
