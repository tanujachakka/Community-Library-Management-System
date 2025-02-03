<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.community.library.model.Member" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Members</title>
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
        h2, h3 {
            margin-top: 0;
            color: #333;
        }
        .form-container {
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: none;
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
        form input[type="text"], form input[type="number"], form input[type="date"], form input[type="email"] {
            width: calc(100% - 22px);
            border: 1px solid #ccc;
        }
        form button {
            background-color: #1c1819;
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
            background-color: #1c1819;
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
        #updateForm {
            display: none;
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #1c1819;
            color: #fff;
        }
    </style>
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
        }

        function showUpdateForm(id, name, email, phoneNumber) {
            document.getElementById('updateForm').style.display = 'block';
            document.getElementById('updateName').value = name;
            document.getElementById('updateEmail').value = email;
            document.getElementById('updatePhoneNumber').value = phoneNumber;
            document.getElementById('oldId').value = id;
        }
    </script>
</head>
<body>

<!-- Navigation Header -->
<div class="nav-header">
    <a href="Home.jsp">Home</a>
    <a href="events">Events</a>
    <a href="books">Books</a>
    <a href="loans">Loans</a>
</div>

<div class="container">
    <h2>Members</h2>
    
    <!-- Button to show the form to add a new member -->
    <button onclick="showAddForm()" style="margin-bottom: 20px; background-color: #b31c2b; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">Add Member</button>

    <!-- Form to add a new member -->
    <div id="addForm" class="form-container">
        <h3>Add Member</h3>
        <form action="members" method="post">
            <input type="hidden" name="action" value="add">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required><br>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br>
            <label for="phoneNumber">Phone Number:</label>
            <input type="number" id="phoneNumber" name="phoneNumber" required><br>
            <button type="submit">Add Member</button>
        </form>
    </div>

    <!-- Display existing members -->
    <h2>Member List</h2>
    <ul style="list-style-type: none; padding: 0;">
        <c:forEach items="${members}" var="member">
            <li class="item">
                <span>
                    ${member.getName()} (${member.getEmail()}, ${member.getPhoneNumber()})
                </span>
                <span>
                    <form action="members" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${member.getId()}">
                        <input type="submit" value="Delete">
                    </form>
                    <button onclick="showUpdateForm('${member.getId()}', '${member.getName()}', '${member.getEmail()}', '${member.getPhoneNumber()}')">Update</button>
                </span>
            </li>
        </c:forEach>
    </ul>

    <!-- Form to update a member -->
    <div id="updateForm">
        <h3>Update Member</h3>
        <form action="members" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="oldId" name="id">

            <label for="updateName">Name:</label>
            <input type="text" id="updateName" name="name" required><br>

            <label for="updateEmail">Email:</label>
            <input type="email" id="updateEmail" name="email" required><br>

            <label for="updatePhoneNumber">Phone Number:</label>
            <input type="number" id="updatePhoneNumber" name="phoneNumber" required><br>

            <button type="submit">Update Member</button>
        </form>
    </div>
</div>
</body>
</html>