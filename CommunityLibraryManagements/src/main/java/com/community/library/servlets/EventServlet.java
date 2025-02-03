package com.community.library.servlets;

import com.community.library.dao.EventDAO;
import com.community.library.model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/events")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public void init() throws ServletException {
        String jdbcURL = "jdbc:postgresql://localhost:5432/library_db";
        String jdbcUsername = "postgres";
        String jdbcPassword = "8090";

        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            eventDAO = new EventDAO(connection);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database connection initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Event> events = eventDAO.getAllEvents();
            request.setAttribute("events", events);
            request.getRequestDispatcher("events.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database operation failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String dateStr = request.getParameter("date");
                String location = request.getParameter("location");

                Event event = new Event(name, dateStr, location);
                eventDAO.addEvent(event);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                eventDAO.deleteEvent(id);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String dateStr = request.getParameter("date");
                String location = request.getParameter("location");
                Event event = new Event(id, name, dateStr, location);
                eventDAO.updateEvent(event);
            }
            // Redirect to doGet to refresh the event list
            response.sendRedirect("events");
        } catch (SQLException e) {
            throw new ServletException("Database operation failed", e);
        }
    }
}