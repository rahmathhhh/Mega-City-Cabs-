<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride | Mega City Cabs</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        /* General Page Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Form Container */
        .form-container {
            background-color: rgba(255, 255, 255, 0.95); /* White background with slight transparency */
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            width: 380px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            border: 2px solid #007bff; /* Blue border */
        }

        /* Heading */
        h2 {
            color: #007bff; /* Blue heading */
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        /* Form Styling */
        form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        label {
            font-size: 14px;
            font-weight: 500;
            text-align: left;
            display: block;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input:focus {
            border-color: #007bff; /* Blue border on focus */
        }

        /* Book Ride Button */
        .btn {
            background-color: #007bff; /* Blue background */
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

        /* Back to Dashboard */
        .back-link {
            margin-top: 20px;
            display: block;
            color: #007bff; /* Blue color for the link */
            font-size: 14px;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        /* Fade-in Effect */
        .fade-in {
            opacity: 1 !important;
            transform: translateY(0) !important;
        }

        /* Mobile Responsiveness */
        @media (max-width: 600px) {
            .form-container {
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

    <div class="form-container" id="formBox">
        <h2>Book a Ride</h2>
        <form action="BookRideServlet" method="POST">
            <label for="address">Pickup Location:</label>
            <input type="text" name="address" required>

            <label for="phone">Phone Number:</label>
            <input type="text" name="phone" required>

            <label for="destination">Destination:</label>
            <input type="text" name="destination" required>

            <label for="date">Ride Date:</label>
            <input type="date" name="date" required>

            <label for="time">Ride Time:</label>
            <input type="time" name="time" required>

            <label for="duration">Ride Duration (in minutes):</label>
            <input type="number" name="ride_duration" required>

            <button type="submit" class="btn">Book Ride</button>
        </form>

        <a href="dashboard.jsp" class="back-link">Back to Dashboard</a>
    </div>

    <script>
        // Add fade-in effect on page load
        window.onload = function () {
            document.getElementById("formBox").classList.add("fade-in");
        };
    </script>

</body>
</html>
