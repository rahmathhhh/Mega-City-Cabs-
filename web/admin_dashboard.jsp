<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Mega City Cabs</title>

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

        /* Dashboard Container */
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

        /* Navigation Buttons */
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
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        /* Logout Button (Now Visible) */
        .logout {
            margin-top: 20px;
            display: block;
            width: 100%;
            background-color: #ff4d4d; /* Red for logout */
            color: white;
            font-size: 18px;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .logout:hover {
            background-color: #cc0000; /* Darker red on hover */
        }

        /* Mobile Responsiveness */
        @media (max-width: 600px) {
            .dashboard-container {
                width: 80%;
            }

            h2 {
                font-size: 24px;
            }

            .btn, .logout {
                font-size: 16px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    
    <div class="dashboard-container">
        <h2>Welcome, Admin</h2>

        <div class="buttons">
            <a href="manage_users.jsp" class="btn"> Manage Users</a>
            <a href="admin_view_bookings.jsp" class="btn">View Bookings</a>
            <a href="manage_drivers_and_cars.jsp" class="btn"> Manage Drivers & Cars</a>
            <a href="assign_driver.jsp" class="btn"> Assign Driver</a>
        </div>

        <!-- Clearly Visible Logout Button -->
        <a href="logout.jsp" class="logout"> Logout</a>
    </div>

</body>
</html>
