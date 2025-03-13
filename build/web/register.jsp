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
            background-color: #f0f8ff; /* Light blue background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Registration Box */
        .register-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: 2px solid #007bff; /* Blue border */
        }

        /* Heading */
        h2 {
            color: #007bff; /* Blue heading */
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        /* Input Fields */
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input:focus {
            border-color: #007bff; /* Blue border on focus */
        }

        /* Register Button */
        .btn {
            width: 100%;
            background-color: #007bff;
            color: white;
            font-size: 18px;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        /* Login Link */
        .login-link {
            color: #007bff;
            margin-top: 15px;
            display: block;
            text-decoration: none;
            font-size: 14px;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        /* Mobile Responsiveness */
        @media (max-width: 600px) {
            .register-container {
                width: 80%;
            }
        }
    </style>
</head>
<body>

    <div class="register-container">
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

</body>
</html>
