<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Mega City Cabs</title>

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

        /* Registration Box */
        .register-container {
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

        /* Register Button */
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

        /* Login Link */
        .login-link {
            color: white;
            margin-top: 15px;
            display: block;
            text-decoration: none;
            font-size: 14px;
        }

        .login-link:hover {
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

    <div class="register-container" id="registerBox">
        <h2>Register</h2>
        <form action="RegisterServlet" method="POST">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="text" name="phone" placeholder="Phone Number" required>
            <button type="submit" class="btn">Register</button>
        </form>

        <a href="login.jsp" class="login-link">Already have an account? Login</a>
    </div>

    <script>
        // Add fade-in effect on page load
        window.onload = function () {
            document.getElementById("registerBox").classList.add("fade-in");
        };
    </script>

</body>
</html>
