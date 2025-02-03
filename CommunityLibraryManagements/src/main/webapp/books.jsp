<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.community.library.model.Book" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
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
            color: #ffffff;
            font-weight: bold;
        }
        .nav-header a:hover {
            text-decoration: underline;
        }
        h1, h2 {
            color: #333333;
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
        form input[type="text"], form input[type="number"] {
            width: 100%;
            border: 1px solid #ccc;
        }
        form button {
            background-color: #1c1819;
            color: #ffffff;
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
            border-bottom: 1px solid #dddddd;
        }
        .item:last-child {
            border-bottom: none;
        }
        .item button {
            background-color: #1c1819;
            color: #ffffff;
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
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #addForm {
            background-color: #f2f2f2;
        }
        #updateForm h3, #addForm h3 {
            margin-bottom: 15px;
        }
        #formError {
            color: red;
            margin-top: 10px;
        }
    </style>
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
        }

        function showUpdateForm(id, title, author, isbn, genre) {
            document.getElementById('updateForm').style.display = 'block';
            document.getElementById('updateId').value = id;
            document.getElementById('updateTitle').value = title;
            document.getElementById('updateAuthor').value = author;
            document.getElementById('updateIsbn').value = isbn;
            document.getElementById('updateGenre').value = genre;
        }

        function validateForm() {
            let title = document.getElementById('title').value.trim();
            if (title === "") {
                document.getElementById('formError').innerText = 'Title is required.';
                return false;
            }
            return true;
        }

        window.onload = function() {
            const addFailedMessage = "<%= (String) session.getAttribute("addFailed") %>";
            if (addFailedMessage && addFailedMessage !== "null") {
                alert(addFailedMessage);
                // Remove the error message from the session after displaying it
                <% session.removeAttribute("addFailed"); %>
            }
        }
    </script>
</head>
<body>

<!-- Navigation Header -->
<div class="nav-header">
    <a href="Home.jsp">Home</a>
    <a href="members">Members</a>
    <a href="events">Events</a>
    <a href="loans">Loans</a>
</div>

<div class="container">
    <h1>Books</h1>
    <button onclick="showAddForm()" style="margin-bottom: 20px; background-color: #b31c2b; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">Add Book</button>
    <div id="addForm" class="form-container">
        <h2>Add Book</h2>
        <form action="books" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="add">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required><br>
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required><br>
            <label for="isbn">ISBN:</label>
            <input type="number" id="isbn" name="isbn" required><br>
            <label for="genre">Genre:</label>
            <input type="text" id="genre" name="genre" required><br>
            <button type="submit">Add Book</button>
            <div id="formError"></div>
        </form>
    </div>
    
    <h2>Book List</h2>
    <ul style="list-style-type: none; padding: 0;">
        <c:forEach items="${books}" var="book">
            <li class="item">
                <span>${book.getTitle()} by ${book.getAuthor()} (ISBN: ${book.getIsbn()}, Genre: ${book.getGenre()})</span>
                <span>
                    <form action="books" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${book.getId()}">
                        <button type="submit">Delete</button>
                    </form>
                    <button onclick="showUpdateForm('${book.getId()}', '${book.getTitle()}', '${book.getAuthor()}', '${book.getIsbn()}', '${book.getGenre()}')">Update</button>
                </span>
            </li>
        </c:forEach>
    </ul>

    <!-- Form to update a book -->
    <div id="updateForm" class="form-container">
        <h3>Update Book</h3>
        <form method="post" action="books">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="updateId" name="id">
            <label for="updateTitle">Title:</label>
            <input type="text" id="updateTitle" name="title" required><br>
            <label for="updateAuthor">Author:</label>
            <input type="text" id="updateAuthor" name="author" required><br>
            <label for="updateIsbn">ISBN:</label>
            <input type="number" id="updateIsbn" name="isbn" required><br>
            <label for="updateGenre">Genre:</label>
            <input type="text" id="updateGenre" name="genre" required><br>
            <button type="submit">Update Book</button>
        </form>
    </div>
</div>
</body>
</html>
