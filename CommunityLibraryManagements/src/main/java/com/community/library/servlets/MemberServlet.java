package com.community.library.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import com.community.library.dao.MemberDAO;
import com.community.library.model.Member;

@WebServlet("/members")
public class MemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        String jdbcURL = "jdbc:postgresql://localhost:5432/library_db";
        String jdbcUsername = "postgres";
        String jdbcPassword = "8090";

        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            memberDAO = new MemberDAO(connection);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database connection initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Member> members = memberDAO.getAllMembers();
            request.setAttribute("members", members);
            request.getRequestDispatcher("members.jsp").forward(request, response);
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
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                Member member = new Member(name, email, phoneNumber);
                memberDAO.addMember(member);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                memberDAO.deleteMember(id);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phoneNumber");
                Member member = new Member(id, name, email, phoneNumber);
                memberDAO.updateMember(member);
            }
            // Redirect to doGet to refresh the member list
            response.sendRedirect("members");
        } catch (SQLException e) {
            throw new ServletException("Database operation failed", e);
        }
    }
}