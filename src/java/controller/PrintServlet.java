/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.AccountInformation;
import model.ClassDocument;
import model.ClassInformation;
import model.LeaveInformation;
import model.Login;

/**
 *
 * @author kornc
 */
@WebServlet(name = "PrintServlet", urlPatterns = {"/print.do"})
public class PrintServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();

            //Get parameter
            String leaveid = request.getParameter("leaveid");

            //Create Variable
            List<ClassInformation> classInf = new LinkedList<ClassInformation>();
            String[] countClass = null;
            int checkSum;

            //Create Statement
            Statement stmt;
            Statement stmtClass;

            try {
                stmt = conn.createStatement();
                String sqlQuery = "select * from leavedocument "
                        + "join leavedocument_section "
                        + "on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id) "
                        + "join person "
                        + "on (leavedocument.student_p_person_id = person.person_id) "
                        + "join student "
                        + "on (person.person_id = student.p_person_id) "
                        + "join section_student "
                        + "on (section_student.section_student_id = student.section_student_section_student_id)"
                        + "where leave_id = '" + leaveid + "'";
                ResultSet rs = stmt.executeQuery(sqlQuery);
                if (rs.next()) {
                    LeaveInformation leaveInf = new LeaveInformation();
                    leaveInf.setLeaveId(rs.getString("leave_id"));
                    leaveInf.setCategory(rs.getString("category"));
                    leaveInf.setLeaveType(rs.getString("type_of_leave"));
                    leaveInf.setDateDocument(rs.getDate("leave_date"));
                    leaveInf.setFirstname(rs.getString("firstname"));
                    leaveInf.setLastname(rs.getString("lastname"));
                    leaveInf.setStudentId(rs.getString("student_id"));
                    leaveInf.setStudentTerm(rs.getString("student_term"));
                    leaveInf.setLeaveYear(rs.getString("year"));
                    leaveInf.setStudentYear(rs.getString("student_year"));
                    leaveInf.setStudentGeneration(rs.getString("generation_id"));
                    leaveInf.setStudentBranch(rs.getString("student_branch"));
                    leaveInf.setStudentDegree(rs.getString("student_degree"));
                    leaveInf.setStudentDescription(rs.getString("leave_description"));
                    leaveInf.setStudentAttachment1(rs.getString("attachment1name"));
                    leaveInf.setStudentAttachment2(rs.getString("attachment2name"));
                    leaveInf.setStudentAttachment3(rs.getString("attachment3name"));
                    leaveInf.setStudentDateFrom(rs.getDate("start_leave_date"));
                    leaveInf.setStudentDateTo(rs.getDate("end_leave_date"));
                    leaveInf.setStudentDateTotal(rs.getString("total_time"));
                    leaveInf.setAdvisorName(rs.getString("advisor"));

                    session.setAttribute("PrintLeavedocument", leaveInf);
                    
                    ClassDocument cd = new ClassDocument(conn);
                    cd.addClass(leaveid);

                    session.setAttribute("ClassDocument", cd);

                    response.sendRedirect("print.jsp");

                } else {
                    response.sendError(HttpServletResponse.SC_NO_CONTENT, "Not have document.");
                }

            } catch (SQLException ex) {
                Logger.getLogger(PrintServlet.class.getName()).log(Level.SEVERE, null, ex);
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
