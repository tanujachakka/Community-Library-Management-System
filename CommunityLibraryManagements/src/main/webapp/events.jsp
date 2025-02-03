<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.community.library.model.Event" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Events</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-top: 20px;
        }
        .nav-header {
            background-color: #b31c2b;
            padding: 15px;
            text-align: center;
        }
        .nav-header a {
            margin: 0 15px;
            text-decoration: none;
            color: #fff;
            font-weight: bold;
        }
        .nav-header a:hover {
            text-decoration: underline;
        }
        h1, h2, h3 {
            color: #333;
        }
        .form-container {
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .form-container h2 {
            margin-bottom: 15px;
        }
        form {
            margin: 20px 0;
        }
        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        form input, form button {
            padding: 10px;
            margin-bottom: 10px;
            font-size: 16px;
            border-radius: 5px;
        }
        form input[type="text"], form input[type="date"] {
            width: calc(100% - 22px);
            border: 1px solid #ccc;
        }
        form button {
            background-color: #624f6e;
            color: #fff;
            border: none;
            cursor: pointer;
            width: 100%;
        }
        form button:hover {
            background-color: #c82333;
        }
        .item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .item:last-child {
            border-bottom: none;
        }
        .item button {
            background-color: #624f6e;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 10px;
        }
        .item button:hover {
            background-color: #c82333;
        }
        #updateForm, #addForm {
            display: none;
            margin: 20px 0;
            padding: 20px;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #updateForm {
            background-color: #f2f2f2;
        }
        #updateForm h3, #addForm h3 {
            margin-bottom: 15px;
        }
    </style>
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
        }

        function showUpdateForm(id, name, date, location) {
            document.getElementById('updateForm').style.display = 'block';
            document.getElementById('updateId').value = id;
            document.getElementById('updateName').value = name;
            document.getElementById('updateDate').value = date;
            document.getElementById('updateLocation').value = location;
        }
    </script>
</head>
<body>

<!-- Navigation Header -->
<div class="nav-header">
    <a href="Home.jsp">Home</a>
    <a href="members">Members</a>
    <a href="books">Books</a>
    <a href="loans">Loans</a>
</div>

<div class="container">
    <h1>Events</h1>
    <button onclick="showAddForm()" style="margin-bottom: 20px; background-color: #b31c2b; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">Add Event</button>
    <div id="addForm" class="form-container">
        <h2>Add Event</h2>
        <form action="events" method="post">
            <input type="hidden" name="action" value="add">
            <label for="name">Event Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required>
            <label for="location">Location:</label>
            <input type="text" id="location" name="location" required>
            <button type="submit">Add Event</button>
        </form>
    </div>
    <h2>Event List</h2>
    <ul style="list-style-type: none; padding: 0;">
        <c:forEach items="${events}" var="event">
            <li class="item">
                <span>${event.getName()} on ${event.getDate()} at ${event.getLocation()}</span>
                <span>
                    <form action="events" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${event.getId()}">
                        <button type="submit">Delete</button>
                    </form>
                    <button onclick="showUpdateForm('${event.getId()}', '${event.getName()}', '${event.getDate()}', '${event.getLocation()}')">Update</button>
                </span>
            </li>
        </c:forEach>
    </ul>

    <!-- Form to update an event -->
    <div id="updateForm" class="form-container">
        <h3>Update Event</h3>
        <form method="post" action="events">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="updateId" name="id">
            <label for="updateName">Event Name:</label>
            <input type="text" id="updateName" name="name" required><br>
            <label for="updateDate">Date:</label>
            <input type="date" id="updateDate" name="date" required><br>
            <label for="updateLocation">Location:</label>
            <input type="text" id="updateLocation" name="location" required><br>
            <button type="submit">Update Event</button>
        </form>
    </div>
</div>
</body>
</html>