<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - Community Library Management System</title>
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
        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .login-container h2 {
            margin: 0 0 20px;
            color: #333;
            font-size: 1.8em;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        .login-container button {
            padding: 10px 20px;
            background-color: rgba(28, 24, 25, 0.8);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 1em;
        }
        .login-container button:hover {
            background-color: rgba(121, 114, 116, 0.8);
        }
        .login-container p {
            margin: 10px 0 0;
            color: #333;
        }
        .login-container a {
            color: #007BFF;
            text-decoration: none;
        }
        .login-container a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <form method="post" action="login">
            <input type="text" name="username" placeholder="Username" required autofocus>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        <%
            String error = request.getParameter("error");
            if (error != null) {
                out.println("<p class='error-message'>Invalid credentials. Please try again.</p>");
            }
        %>
    </div>
</body>
</html>