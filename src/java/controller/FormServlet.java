/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Login;

/**
 *
 * @author kornc
 */
@WebServlet(name = "FormServlet", urlPatterns = {"/form.do"})

@MultipartConfig
public class FormServlet extends HttpServlet {

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
    private static String UPLOAD_DIR;

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

            // Get Informataion with form.jsp
            String leaveId = request.getParameter("leave_id");
            String categoryType = request.getParameter("category_type");
            String leaveType = request.getParameter("leave_type");
            String leaveDate = request.getParameter("leave_date");
            String studentYear = request.getParameter("year");
            String studentId = request.getParameter("student_id");
            String studentBranch = request.getParameter("branch");
            String studentDegree = request.getParameter("degree");
            String studentDescription = request.getParameter("description_leave");

            // Manage Date
            String studentDateFrom = request.getParameter("start_date_leave");
            String studentDateTo = request.getParameter("end_date_leave");

            String studentDateTotal = request.getParameter("total_day_leave");
            // Get File with form.jsp
            InputStream inputStream1 = null;
            InputStream inputStream2 = null;
            InputStream inputStream3 = null;
            Part studentAttachment1 = request.getPart("leaveFile1");
            Part studentAttachment2 = request.getPart("leaveFile2");
            Part studentAttachment3 = request.getPart("leaveFile3");
            System.out.println(studentAttachment1);
            // Get Class Information for leave with form.jsp
            String[] className = {request.getParameter("class_name_1"),
                request.getParameter("class_name_2"),
                request.getParameter("class_name_3"),
                request.getParameter("class_name_4"),
                request.getParameter("class_name_5"),
                request.getParameter("class_name_6"),
                request.getParameter("class_name_7"),};
            String[] classSection = {request.getParameter("class_section_1"),
                request.getParameter("class_section_2"),
                request.getParameter("class_section_3"),
                request.getParameter("class_section_4"),
                request.getParameter("class_section_5"),
                request.getParameter("class_section_6"),
                request.getParameter("class_section_7"),};
            // Check path file
            if (studentAttachment1 != null || studentAttachment2 != null || studentAttachment3 != null) {
                inputStream1 = studentAttachment1.getInputStream();
                inputStream2 = studentAttachment2.getInputStream();
                inputStream3 = studentAttachment3.getInputStream();
            }
            // Get Connection and Insert data to database
            try {
                String sqlInformation = "insert into leavedocument (leave_id, student_p_person_id, leave_description, start_leave_date, end_leave_date, leave_date, total_time, "
                        + "type_of_leave, year, category, attachment1, attachment1name, attachment2, attachment2name, attachment3, attachment3name) values (?, ?, ?, ? , ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sqlInformation);
                stmt.setString(1, leaveId);
                stmt.setString(2, account.getUsername());
                stmt.setString(3, studentDescription);
                stmt.setString(4, studentDateFrom);
                stmt.setString(5, studentDateTo);
                stmt.setString(6, leaveDate);
                stmt.setString(7, studentDateTotal);
                stmt.setString(8, leaveType);
                stmt.setString(9, studentYear);
                stmt.setString(10, categoryType);
                stmt.setString(12, studentAttachment1.getSubmittedFileName());
                stmt.setString(14, studentAttachment2.getSubmittedFileName());
                stmt.setString(16, studentAttachment3.getSubmittedFileName());

                UPLOAD_DIR  = "uploads/" + leaveId; 
                // gets absolute path of the web application
                String applicationPath = request.getServletContext().getRealPath("");
                // constructs path of the directory to save uploaded file
                String uploadFilePath = applicationPath + UPLOAD_DIR;
                System.out.println(uploadFilePath);

                // creates upload folder if it does not exists
                File uploadFolder = new File(uploadFilePath);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }

                // write all files in upload folder
                if (studentAttachment1.getSubmittedFileName() != null && studentAttachment1.getSize() > 0) {
                    String fileName = studentAttachment1.getSubmittedFileName();
                    String contentType = studentAttachment1.getContentType();
                    studentAttachment1.write(uploadFilePath + File.separator + fileName);
                    stmt.setString(11, uploadFilePath + File.separator + fileName);
                } else {
                    stmt.setString(11, "");
                }

                if (studentAttachment2.getSubmittedFileName() != null && studentAttachment2.getSize() > 0) {
                    String fileName = studentAttachment2.getSubmittedFileName();
                    studentAttachment2.write(uploadFilePath + File.separator + fileName);
                    stmt.setString(13, uploadFilePath + File.separator + fileName);
                } else {
                    stmt.setString(13, "");
                }

                if (studentAttachment3.getSubmittedFileName() != null && studentAttachment3.getSize() > 0) {
                    String fileName = studentAttachment3.getSubmittedFileName();
                    studentAttachment3.write(uploadFilePath + File.separator + fileName);
                    stmt.setString(15, uploadFilePath + File.separator + fileName);
                } else {
                    stmt.setString(15, "");
                }

                int checkSuccessInf = stmt.executeUpdate();
                if (checkSuccessInf == 1) {
                    for (int i = 0; i < className.length; i++) {
                        Statement classStmt = conn.createStatement();
                        Statement classCheckStmt = conn.createStatement();
                        String sqlCheckSection = "select * "
                                + "from class "
                                + "join section "
                                + "on (class.class_id = section.class_class_id) "
                                + "where class_name = '" + className[i] + "' and section_name = '" + classSection[i] + "'";
                        ResultSet rsClass = classCheckStmt.executeQuery(sqlCheckSection);
                        if (rsClass.next()) {
                            String sqlClassSectionId = rsClass.getString("section_id");
                            String sqlClassId = rsClass.getString("class_id");
                            String sqlClass = "insert into leavedocument_section (leavedocument_leave_id, section_section_id, date, professor_name, status, subjectleave_id, note) "
                                    + "values ('" + leaveId + "', '" + sqlClassSectionId + "', null, '', 'รอการอนุมัติ', '" + sqlClassId + "', '')";
                            int checkSuccessClass = classStmt.executeUpdate(sqlClass);
                        }
                    }
                    response.sendRedirect("formsuccess.html");
                } else {
                    response.sendRedirect("formfail.html");
                }
            } catch (Exception e) {
                e.printStackTrace();
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
