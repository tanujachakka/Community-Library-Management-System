package com.community.library.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.community.library.dao.UserDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        String jdbcURL = "jdbc:postgresql://localhost:5432/library_db";
        String jdbcUsername = "postgres";
        String jdbcPassword = "8090";

        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            userDAO = new UserDAO(connection);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database connection initialization failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match");
            return;
        }

        if (!email.matches("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            response.sendRedirect("register.jsp?error=Invalid email");
            return;
        }

        boolean isUserRegistered = userDAO.registerUser(username, email, password);

        if (isUserRegistered) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("Home.jsp");
        } else {
            response.sendRedirect("register.jsp?error=User could not be registered");
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