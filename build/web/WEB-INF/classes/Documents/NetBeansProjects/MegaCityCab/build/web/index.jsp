<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cabs - Home</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* General Page Styles */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to right, #007bff, #00d4ff);
            color: white;
            text-align: center;
            overflow: hidden;
        }

        /* Container Box */
        .container {
            background: rgba(255, 255, 255, 0.15);
            padding: 40px;
            border-radius: 10px;
            backdrop-filter: blur(10px);
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            opacity: 0;
            transform: translateY(-20px);
            transition: opacity 1s ease-in-out, transform 0.8s ease-in-out;
        }

        /* Title */
        h1 {
            font-size: 40px;
            font-weight: 600;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        /* Subtext */
        p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        /* Buttons */
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 12px 24px;
            font-size: 18px;
            color: white;
            background: #ffcc00;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s ease;
        }

        .btn:hover {
            background: #ffdd44;
            transform: scale(1.05);
        }

        /* Fade-in Effect */
        .fade-in {
            opacity: 1 !important;
            transform: translateY(0) !important;
        }
    </style>
</head>
<body>

    <div class="container" id="welcomeBox">
        <h1>Mega City Cabs</h1>
        <h2 id="greeting">🚖 Welcome to Your Trusted Ride Service</h2>
        <p>Your reliable ride, anytime, anywhere.</p>
        <a href="login.jsp" class="btn">Login</a>
        <a href="register.jsp" class="btn">Register</a>
    </div>

    <script>
        // Add fade-in effect on load
        window.onload = function () {
            document.getElementById("welcomeBox").classList.add("fade-in");
            updateGreeting();
        };

        
    </script>

</body>
</html>
