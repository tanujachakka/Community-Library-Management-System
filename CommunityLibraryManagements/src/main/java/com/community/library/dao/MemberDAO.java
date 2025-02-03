package com.community.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.community.library.model.Member;

public class MemberDAO {
    private Connection connection;

    public MemberDAO(Connection connection) {
        this.connection = connection;
    }

    public void addMember(Member member) throws SQLException {
        String query = "INSERT INTO members (name, email, phoneNumber) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, member.getName());
            stmt.setString(2, member.getEmail());
            stmt.setString(3, member.getPhoneNumber());
            stmt.executeUpdate();
        }
    }

    public List<Member> getAllMembers() throws SQLException {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM members";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phoneNumber = rs.getString("phoneNumber");
                members.add(new Member(id, name, email, phoneNumber));
            }
        }
        return members;
    }

    public void deleteMember(int id) throws SQLException {
        String query = "DELETE FROM members WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
    public void updateMember(Member member) throws SQLException {
        String query = "UPDATE members SET name = ?, email = ?, phone_number = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, member.getName());
            stmt.setString(2, member.getEmail());
            stmt.setString(3, member.getPhoneNumber());
            stmt.setInt(4, member.getId());
            stmt.executeUpdate();
        }
    }
}