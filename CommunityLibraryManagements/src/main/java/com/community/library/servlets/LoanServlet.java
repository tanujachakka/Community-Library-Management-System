package com.community.library.servlets;

import com.community.library.model.Loan;
import com.community.library.dao.LoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/loans")
public class LoanServlet extends HttpServlet implements Serializable {
    private static final long serialVersionUID = 1L;
    private LoanDAO loanDAO;

    @Override
    public void init() throws ServletException {
        loanDAO = new LoanDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Loan> loans = null;
        try {
            loans = loanDAO.getAllLoans();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        req.setAttribute("loans", loans);
        req.getRequestDispatcher("/loans.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addLoan(req, resp);
                    break;
                case "delete":
                    deleteLoan(req, resp);
                    break;
                case "update":
                    updateLoan(req, resp);
                    break;
                default:
                    resp.sendRedirect("loans");
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addLoan(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        int memberId = Integer.parseInt(req.getParameter("memberId"));
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        Date loanDate = parseDate(req.getParameter("loanDate"));
        Date returnDate = parseDate(req.getParameter("returnDate"));

        Loan newLoan = new Loan(0, bookId, memberId, loanDate, returnDate);
        loanDAO.addLoan(newLoan);
        resp.sendRedirect("loans");
    }

    private void deleteLoan(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        int memberId = Integer.parseInt(req.getParameter("memberId"));
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        loanDAO.deleteLoan(memberId, bookId);
        resp.sendRedirect("loans");
    }

    private void updateLoan(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        int oldMemberId = Integer.parseInt(req.getParameter("oldMemberId"));
        int oldBookId = Integer.parseInt(req.getParameter("oldBookId"));
        int memberId = Integer.parseInt(req.getParameter("memberId"));
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        Date loanDate = parseDate(req.getParameter("loanDate"));
        Date returnDate = parseDate(req.getParameter("returnDate"));

        Loan updatedLoan = new Loan(0, bookId, memberId, loanDate, returnDate);
        loanDAO.updateLoan(oldMemberId, oldBookId, updatedLoan);
        resp.sendRedirect("loans");
    }

    private Date parseDate(String dateStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return new Date(sdf.parse(dateStr).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
}
