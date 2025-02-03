package com.community.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserLoginDAO {
    private final Connection connection;

    public UserLoginDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean registerUser(String username, String email, String password) {
        String query = "INSERT INTO user_login (username, email, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, password);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}