<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Mega City Cabs</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* General Page Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #007bff, #00d4ff);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Login Box */
        .login-container {
            background: rgba(255, 255, 255, 0.15);
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transform: translateY(-20px);
            opacity: 0;
            transition: opacity 1s ease-in-out, transform 0.8s ease-in-out;
        }

        /* Heading */
        h2 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        /* Input Fields */
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        /* Login Button */
        .btn {
            width: 100%;
            background: #ffcc00;
            color: black;
            font-size: 18px;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .btn:hover {
            background: #ffdd44;
            transform: scale(1.05);
        }

        /* Error Message */
        .error {
            color: #ff3b3b;
            margin-top: 10px;
            font-size: 14px;
        }

        /* Register Link */
        .register-link {
            color: white;
            margin-top: 15px;
            display: block;
            text-decoration: none;
            font-size: 14px;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        /* Fade-in Effect */
        .fade-in {
            opacity: 1 !important;
            transform: translateY(0) !important;
        }
    </style>
</head>
<body>

    <div class="login-container" id="loginBox">
        <h2>Login</h2>
        <form action="LoginServlet" method="POST">
            <input type="email" name="email" placeholder="Enter your email" required>
            <input type="password" name="password" placeholder="Enter your password" required>
            <button type="submit" class="btn">Login</button>
        </form>

        <!-- Error Message -->
        <%
            String error = request.getParameter("error");
            if ("true".equals(error)) {
        %>
            <p class="error">❌ Invalid email or password! Please try again.</p>
        <%
            }
        %>

        <a href="register.jsp" class="register-link">New here? Register now</a>
    </div>

    <script>
        // Add fade-in effect on page load
        window.onload = function () {
            document.getElementById("loginBox").classList.add("fade-in");
        };
    </script>

</body>
</html>
