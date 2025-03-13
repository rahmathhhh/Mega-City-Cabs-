<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard | Mega City Cabs</title>

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

        /* Dashboard Box */
        .dashboard-container {
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

        p {
            font-size: 16px;
            margin-bottom: 20px;
            color: #777;
        }

        /* Buttons */
        .buttons {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 20px;
        }

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

        /* Logout Link */
        .logout {
            margin-top: 20px;
            display: block;
            color: #ff4d4d; /* Red color for logout */
            font-size: 14px;
            text-decoration: none;
            font-weight: bold;
        }

        .logout:hover {
            text-decoration: underline;
        }

        /* Mobile Responsiveness */
        @media (max-width: 600px) {
            .dashboard-container {
                width: 80%;
            }

            h2 {
                font-size: 24px;
            }

            .btn {
                font-size: 16px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <h2>Welcome, <%= request.getSession().getAttribute("username") %>! 👋</h2>
        <p>Choose an action below:</p>

        <div class="buttons">
            <a href="book_ride.jsp">
                <button class="btn">🚖 Book a Ride</button>
            </a>
            <a href="view_booking.jsp">
                <button class="btn">📜 View My Bookings & Bills</button>
            </a>
        </div>

        <a href="#" class="logout" onclick="confirmLogout()">🚪 Logout</a>
    </div>

    <script>
        function confirmLogout() {
            let confirmAction = confirm("Are you sure you want to log out?");
            if (confirmAction) {
                window.location.href = "index.jsp";
            }
        }
    </script>

</body>
</html>
