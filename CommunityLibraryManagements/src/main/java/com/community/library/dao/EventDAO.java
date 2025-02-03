package com.community.library.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.community.library.model.Event;

public class EventDAO {
    private Connection connection;

    public EventDAO(Connection connection) {
        this.connection = connection;
    }

    public void addEvent(Event event) throws SQLException {
        String query = "INSERT INTO events (name, date, location) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, event.getName());
            stmt.setDate(2, Date.valueOf(event.getDate())); // Convert to java.sql.Date
            stmt.setString(3, event.getLocation());
            stmt.executeUpdate();
        }
    }

    public List<Event> getAllEvents() throws SQLException {
        List<Event> events = new ArrayList<>();
        String query = "SELECT * FROM events";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                Date date = rs.getDate("date");
                String location = rs.getString("location");
                events.add(new Event(id, name, date.toString(), location));
            }
        }
        return events;
    }

    public void deleteEvent(int id) throws SQLException {
        String query = "DELETE FROM events WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
    public void updateEvent(Event event) throws SQLException {
        String query = "UPDATE events SET name = ?, date = ?, location = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, event.getName());
            stmt.setString(2, event.getDate());
            stmt.setString(3, event.getLocation());
            stmt.setInt(4, event.getId());
            stmt.executeUpdate();
        }
    }
}