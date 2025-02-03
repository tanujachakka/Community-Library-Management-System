<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.community.library.model.Loan" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loans</title>
    <script>
        function showAddForm() {
            document.getElementById('addForm').style.display = 'block';
        }

        function showUpdateForm(memberId, bookId, loanDate, returnDate) {
            document.getElementById('updateForm').style.display = 'block';
            document.getElementById('updateMemberId').value = memberId;
            document.getElementById('updateBookId').value = bookId;
            document.getElementById('updateLoanDate').value = loanDate;
            document.getElementById('updateReturnDate').value = returnDate;
            document.getElementById('oldMemberId').value = memberId;
            document.getElementById('oldBookId').value = bookId;
        }
    </script>
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
        form input[type="text"], form input[type="number"], form input[type="date"] {
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
        .loan-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .loan-item:last-child {
            border-bottom: none;
        }
        .loan-item button {
            background-color: #1c1819;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 10px;
        }
        .loan-item button:hover {
            background-color: #c82333;
        }
        #updateForm {
            display: none;
            margin: 20px 0;
            padding: 20px;
            border-radius: 8px;
            background-color: #1c1819;
            color: #fff;
        }
    </style>
</head>
<body>

<!-- Navigation Header -->
<div class="nav-header">
    <a href="Home.jsp">Home</a>
    <a href="members">Members</a>
    <a href="events">Events</a>
    <a href="books">Books</a>
</div>

<div class="container">
    <h2>Loans</h2>
    
    <!-- Button to show the form to add a new loan -->
    <button onclick="showAddForm()" style="margin-bottom: 20px; background-color: #b31c2b; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">Add Loan</button>

    <!-- Form to add a new loan -->
    <div id="addForm" class="form-container">
        <h3>Add Loan</h3>
        <form method="post" action="loans">
            <input type="hidden" name="action" value="add">
            <label for="memberId">Member ID:</label>
            <input type="number" id="memberId" name="memberId" placeholder="Member ID" required><br>

            <label for="bookId">Book ID:</label>
            <input type="number" id="bookId" name="bookId" placeholder="Book ID" required><br>

            <label for="loanDate">Loan Date:</label>
            <input type="date" id="loanDate" name="loanDate" required><br>

            <label for="returnDate">Return Date:</label>
            <input type="date" id="returnDate" name="returnDate" required><br>

            <button type="submit">Add Loan</button>
        </form>
    </div>

    <!-- Display existing loans -->
    <h2>Current Loans</h2>
    <ul id="loanList" style="list-style-type: none; padding: 0;">
        <% 
            @SuppressWarnings("unchecked")
            List<Loan> loanList = (List<Loan>) request.getAttribute("loans");
            if (loanList != null) {
                for (Loan loan : loanList) {
                    String loanDateStr = loan.getLoanDate().toString(); // Convert date to string
                    String returnDateStr = loan.getReturnDate().toString(); // Convert date to string
                    %>
                    <li class="loan-item">
                        <span>
                            Member ID: <%= loan.getMemberId() %>, 
                            Book ID: <%= loan.getBookId() %>, 
                            Loan Date: <%= loanDateStr %>, 
                            Return Date: <%= returnDateStr %>
                        </span>
                        <span>
                            <form method="post" action="loans" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="memberId" value="<%= loan.getMemberId() %>">
                                <input type="hidden" name="bookId" value="<%= loan.getBookId() %>">
                                <button type="submit">Delete</button>
                            </form>
                            <button onclick="showUpdateForm('<%= loan.getMemberId() %>', <%= loan.getBookId() %>, '<%= loanDateStr %>', '<%= returnDateStr %>')">Update</button>
                        </span>
                    </li>
                    <% 
                }
            }
        %>
    </ul>

    <!-- Form to update a loan -->
    <div id="updateForm" class="form-container">
        <h3>Update Loan</h3>
        <form method="post" action="loans">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="oldMemberId" name="oldMemberId">
            <input type="hidden" id="oldBookId" name="oldBookId">

            <label for="updateMemberId">Member ID:</label>
            <input type="number" id="updateMemberId" name="memberId" required><br>

            <label for="updateBookId">Book ID:</label>
            <input type="number" id="updateBookId" name="bookId" required><br>

            <label for="updateLoanDate">Loan Date:</label>
            <input type="date" id="updateLoanDate" name="loanDate" required><br>

            <label for="updateReturnDate">Return Date:</label>
            <input type="date" id="updateReturnDate" name="returnDate" required><br>

            <button type="submit">Update Loan</button>
        </form>
    </div>
</div>
</body>
</html>
