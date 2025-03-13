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
        body, h1, h2, p {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        /* Page layout */
        body {
            background-color: #f0f8ff; /* Light blue background */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        /* Container for the home page */
        .container {
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 40px;
            border-radius: 10px;
            width: 350px;
            text-align: center;
            border: 2px solid #007bff; /* Blue border */
        }

        h1 {
            color: #007bff; /* Blue title */
            font-size: 40px;
            margin-bottom: 10px;
        }

        h2 {
            color: #007bff;
            font-size: 24px;
            margin-bottom: 20px;
        }

        p {
            color: #777;
            margin-bottom: 20px;
        }

        /* Buttons */
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 12px 24px;
            font-size: 18px;
            color: white;
            background: #007bff; /* Blue button */
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s ease;
        }

        .btn:hover {
            background: #0056b3; /* Darker blue on hover */
        }

        /* Logout link styling */
        .logout {
            background-color: #ff4d4d; /* Red background for logout */
            color: white;
        }

        .logout:hover {
            background-color: #e60000;
        }

        /* Mobile responsiveness */
        @media (max-width: 600px) {
            .container {
                width: 80%;
            }

            h1 {
                font-size: 35px;
            }

            h2 {
                font-size: 20px;
            }

            .btn {
                font-size: 16px;
                padding: 12px 20px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Mega City Cabs</h1>
        <h2>🚖 Welcome to Your Trusted Ride Service</h2>
        <p>Your reliable ride, anytime, anywhere.</p>
        <a href="login.jsp" class="btn">Login</a>
        <a href="register.jsp" class="btn">Register</a>
    </div>

</body>
</html>
