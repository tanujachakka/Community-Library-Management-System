<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession httpSession = request.getSession(false);
    String username = (httpSession != null) ? (String) httpSession.getAttribute("username") : "Guest";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community Library Management System - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            background: url('https://i.ytimg.com/vi/-w9I2zTS380/maxresdefault.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
        }
        .header {
            width: 100%;
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 10px 0;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .header h1 {
            margin: 10px 0;
            color: #fff;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
            font-size: 1.8em;
        }
        .header .logout {
            margin-top: 10px;
        }
        .logout button {
            background-color: rgba(28, 24, 25, 0.8);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
            font-size: 0.9em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .logout button:hover {
            background-color: rgba(121, 114, 116, 0.8);
        }
        nav {
            margin: 10px 0;
            width: 100%;
            display: flex;
            justify-content: center;
        }
        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }
        nav ul li {
            margin: 5px;
        }
        nav ul a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            padding: 8px 15px;
            background-color: rgba(28, 24, 25, 0.8);
            border-radius: 5px;
            display: block;
            transition: background-color 0.3s ease;
            font-size: 0.9em;
        }
        nav ul a:hover {
            background-color: rgba(121, 114, 116, 0.8);
        }
        @media (max-width: 600px) {
            body {
                align-items: flex-start;
            }
            .header {
                padding: 20px 0;
            }
            .header h1 {
                font-size: 1.5em;
            }
            nav ul {
                flex-direction: column;
                align-items: center;
            }
            nav ul li {
                width: 100%;
                text-align: center;
            }
            nav ul a {
                width: calc(100% - 40px);
            }
        }
    </style>
    
</head>
<body>
    <div class="header">
        <h1>Community Library Management System</h1>
        <nav>
            <ul>
                <li><a href="books">Books</a></li>
                <li><a href="members">Members</a></li>
                <li><a href="events">Events</a></li>
                <li><a href="loans">Loans</a></li>
            </ul>
        </nav>
        <div class="logout">
            <form action="logout" method="post">
                <button type="submit">Logout</button>
            </form>
        </div>
    </div>
    <div>
    <h1>Welcome, <%= username %>!</h1>
</div>
</body>
</html>