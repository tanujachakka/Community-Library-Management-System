<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Community Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: url('https://i.ytimg.com/vi/-w9I2zTS380/maxresdefault.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .registration-container {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .registration-container h2 {
            margin: 0 0 20px;
            color: #333;
            font-size: 1.8em;
        }
        .registration-container input[type="text"],
        .registration-container input[type="email"],
        .registration-container input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        .registration-container button {
            padding: 10px 20px;
            background-color: rgba(28, 24, 25, 0.8);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 1em;
        }
        .registration-container button:hover {
            background-color: rgba(121, 114, 116, 0.8);
        }
        .registration-container p {
            margin: 10px 0 0;
            color: #333;
        }
        .registration-container a {
            color: #007BFF;
            text-decoration: none;
        }
        .registration-container a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }
    </style>
    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const email = document.getElementById("email").value;

            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            if (password !== confirmPassword) {
                alert("Passwords do not match. Please try again.");
                return false;
            }
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="registration-container">
        <h2>Admin Registration</h2>
        <form method="post" action="register" onsubmit="return validateForm()">
            <input type="text" name="username" placeholder="Username" required autofocus>
            <input type="email" name="email" placeholder="Email" id="email" required>
            <input type="password" name="password" placeholder="Password" id="password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" id="confirmPassword" required>
            <button type="submit">Register</button>
        </form>
        <h3>Already have an account?</h3>
        <p><a href="userLogin.jsp">Back to Login</a></p>
        <%
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("Passwords do not match")) {
                    out.println("<p class='error-message'>Passwords do not match. Please try again.</p>");
                } else if (error.equals("Invalid email")) {
                    out.println("<p class='error-message'>Invalid email address. Please try again.</p>");
                } else {
                    out.println("<p class='error-message'>An error occurred. Please try again.</p>");
                }
            }
        %>
    </div>
</body>
</html>