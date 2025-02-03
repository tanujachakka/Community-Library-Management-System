package com.community.library.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.community.library.dao.BookDAO;
import com.community.library.model.Book;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private Connection connection;

    @Override
    public void init() throws ServletException {
        String jdbcURL = "jdbc:postgresql://localhost:5432/library_db";
        String jdbcUsername = "postgres";
        String jdbcPassword = "8090";

        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            bookDAO = new BookDAO(connection);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database connection initialization failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            HttpSession session = request.getSession();
            if ("add".equals(action)) {
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String isbn = request.getParameter("isbn");
                String genre = request.getParameter("genre");

                if (bookDAO.doesBookTitleExist(title)) {
                    session.setAttribute("addFailed", "Title already exists. Please enter a new title.");
                } else {
                    Book book = new Book(0, title, author, isbn, genre);
                    bookDAO.addBook(book);
                    session.removeAttribute("addFailed"); // Clear previous message if any
                }
                response.sendRedirect("books");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                bookDAO.deleteBook(id);
                session.removeAttribute("addFailed"); // Clear previous message if any
                response.sendRedirect("books");
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String isbn = request.getParameter("isbn");
                String genre = request.getParameter("genre");
                Book book = new Book(id, title, author, isbn, genre);
                bookDAO.updateBook(book);
                session.removeAttribute("addFailed"); // Clear previous message if any
                response.sendRedirect("books");
            }
        } catch (SQLException e) {
            throw new ServletException("Database operation failed", e);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Book> books = bookDAO.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("/books.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database operation failed", e);
        }
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}