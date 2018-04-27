/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.AccountInformation;
import model.Login;

/**
 *
 * @author kornc
 */
@WebServlet(name = "ManageServlet", urlPatterns = {"/manage.do"})
public class ManageServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private Connection conn;

    public void init() {
        conn = (Connection) getServletContext().getAttribute("connection");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            Login account = (Login) session.getAttribute("Account");
            AccountInformation accountInf = (AccountInformation) session.getAttribute("AccountInformation");

            //Get parameter
            String flag = request.getParameter("flag");
            String leaveid = request.getParameter("leaveid");
            String classid = request.getParameter("classid");
            String noteLeave = request.getParameter("noteLeave");
            String section = request.getParameter("section");

            //Create Variable
            String professorName = accountInf.getFirstname() + " " + accountInf.getLastname();
            Date curDate = new Date();
            String date = new SimpleDateFormat("yyyy-MM-dd").format(curDate);
            int checkSum;

            //Create Statement
            Statement stmt;

            if (account.getPerson_type().equals("professor")) {
                if (flag.equals("success")) {
                    String sqlUpdate = "update leavedocument_section "
                            + "set professor_name = '" + professorName + "', status = 'อนุมัติ', note = '" + noteLeave + "', "
                            + "date = '" + date + "' "
                            + "where leavedocument_leave_id = '" + leaveid + "' and subjectleave_id = '" + classid + "' and section_section_id = '" + section + "'";
                    try {
                        stmt = conn.createStatement();
                        checkSum = stmt.executeUpdate(sqlUpdate);
                        if (checkSum > 0) {
                            response.sendRedirect("managesuccess.html");
                        } else {
                            response.sendRedirect("managefail.html");
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ManageServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else if (flag.equals("unsuccess")) {
                    String sqlUpdate = "update leavedocument_section "
                            + "set professor_name = '" + professorName + "', "
                            + "status = 'ไม่อนุมัติ', "
                            + "note = '" + noteLeave + "' "
                            + "where leavedocument_leave_id = '" + leaveid + "' and subjectleave_id = '" + classid + "' and section_section_id = '" + section + "'";
                    try {
                        stmt = conn.createStatement();
                        checkSum = stmt.executeUpdate(sqlUpdate);
                        if (checkSum > 0) {
                            response.sendRedirect("managesuccess.html");
                        } else {
                            response.sendRedirect("managefail.html");
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ManageServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } else {
                response.sendRedirect("nopermission.html");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
