<%-- 
    Document   : login
    Created on : Apr 3, 2018, 8:38:00 PM
    Author     : kornc
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="model.AccountInformation"%>
<%@page import="java.sql.*"%>
<%@page import="model.Login"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page language="java" session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Login"%>
<% Login accountCheck = (Login) session.getAttribute("Account"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta property="title" content="Korn Chinnatan"/>
        <meta property="description" content="I’m 19 year-old. graduated from Prommanusorn Phetchaburi School.now studying in information technology at King Mongkut’s Institute of Technology Ladkrabang.interested in web development and programming."/>
        <meta name="keywords" content="Korn,Chinnatan,Chatthong,KMITL,IT,eLeave,System,eLeave System"/>
        <meta charset="utf-8">
        <title>ระบบลาเรียนออนไลน์, คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง, Information Technology - KMITL</title>
        <link href="https://fonts.googleapis.com/css?family=Kanit" rel="stylesheet">
        <link rel="icon" href="images/itkmitl.ico">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script>window.jQuery || document.write('<script src="js/jquery-slim.min.js"><\/script>')</script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>

    </head>
    <%
        if (accountCheck == null || accountCheck.getUsername() == null) {
    %>
    <body class="signin login">
        <form action="login.jsp?action=signin" method="POST" class="form-signin text-center needs-validation" novalidate>
            <img class="mb-4" src="images/logo.png" alt="" width="72" height="72">
            <h1 class="h5 mb-3 font-weight-normal">ระบบลาเรียนออนไลน์</h1>
            <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
            <label for="inputUsername" class="sr-only">Username</label>
            <input type="text" id="inputUsername" name="inputUsername" class="form-control" placeholder="Username" required autofocus>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" name="inputPassword" class="form-control" placeholder="Password" required>
            <!-- 		<div class="checkbox mb-3">
                                    <label>
                                            <input type="checkbox" value="remember-me"> Remember me
                                    </label>
                            </div> -->
            <button class="btn btn-lg btn-signin btn-block" type="submit">Sign in</button>
            <p class="mt-5 mb-3">Copyright &copy; 2018 ระบบลาเรียนออนไลน์ </p><p class="text-muted">IT KMITL Powered by KCNT&trade;</p>
        </form>

        <!-- Popup -->
        <div class="modal fade" tabindex="-1" role="dialog" id="signin-unsuccess">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">แจ้งเตือน</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>ชื่อผู้ใช้งานหรือรหัสผ่านผิดพลาด.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-red" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <% } else {
                response.sendRedirect("selection.jsp");
            }
        %>

        <%
            if (request.getParameter("action") != null) {
                Connection conn = (Connection) getServletContext().getAttribute("connection");

                boolean loginFlag = false;

                // Get Information Login
                String username = request.getParameter("inputUsername");
                String password = request.getParameter("inputPassword");
                // Query and Check Information for Login
                String sqlCheck = "select * from person where person_id = ? and password = ?";
                PreparedStatement preStmt = conn.prepareStatement(sqlCheck);
                preStmt.setString(1, username);
                preStmt.setString(2, password);
                ResultSet rs = preStmt.executeQuery();
                if (!rs.next()) {
        %>
        <script type="text/javascript">
            $('#signin-unsuccess').modal('show')
        </script>
        <%
                } else {
                    // Create Var keep type
                    String person_type = rs.getString("person_type");
                    // Create Obj Login
                    Login account = new Login(username, password, person_type);
                    // Set Attribute to Session
                    session.setAttribute("Account", account);
                    if (account.getPerson_type() == null) {
                        loginFlag = true;
                        Statement stmtAccInf = conn.createStatement();
                        Statement stmtProfInf = conn.createStatement();
                        String sqlAccountInf = "select * from person "
                                + "where person_id = '" + account.getUsername() + "'";
                        ResultSet rsAccInf = stmtAccInf.executeQuery(sqlAccountInf);
                        while (rsAccInf.next()) {
                            String firstname = rsAccInf.getString("firstname");
                            String lastname = rsAccInf.getString("lastname");
                            String email = rsAccInf.getString("email");
                            AccountInformation accInf = new AccountInformation();
                            accInf.setFirstname(firstname);
                            accInf.setLastname(lastname);
                            accInf.setEmail(email);
                            session.setAttribute("AccountInformation", accInf);
                        }

                        // Set flag
                        session.setAttribute("loginFlag", loginFlag);
                        // Send Redirect.
                        response.sendRedirect("selection.jsp");
                    } else if (account.getPerson_type().equals("student")) {
                        loginFlag = true;
                        Statement stmtAccInf = conn.createStatement();
                        Statement stmtProfInf = conn.createStatement();
                        String sqlAccountInf = "select * from person "
                                + "join student on (person.person_id = student.p_person_id) "
                                + "join section_student on (section_student.section_student_id = student.section_student_section_student_id) "
                                + "where person_id = '" + account.getUsername() + "'";
                        ResultSet rsAccInf = stmtAccInf.executeQuery(sqlAccountInf);
                        if (rsAccInf.next()) {
                            String firstname = rsAccInf.getString("firstname");
                            String lastname = rsAccInf.getString("lastname");
                            String student_id = rsAccInf.getString("student_id");
                            String email = rsAccInf.getString("email");
                            String studentDegree = rsAccInf.getString("student_degree");
                            String studentBranch = rsAccInf.getString("student_branch");
                            int student_year = rsAccInf.getInt("student_year");
                            int student_term = rsAccInf.getInt("student_term");
                            int generation_id = rsAccInf.getInt("generation_id");
                            int section_no = rsAccInf.getInt("section_no");
                            String sqlProfInf = "select * from person where person_id = '" + rsAccInf.getString("p_person_id") + "'";
                            ResultSet rsProfInf = stmtProfInf.executeQuery(sqlProfInf);
                            if (rsProfInf.next()) {
                                String professor_name = rsProfInf.getString("firstname") + " " + rsProfInf.getString("lastname");
                                AccountInformation accInf = new AccountInformation(firstname, lastname, student_id, email, professor_name, studentDegree, studentBranch, student_year, student_term, generation_id, section_no);
                                session.setAttribute("AccountInformation", accInf);
                            }
                        }
                        // Set flag
                        session.setAttribute("loginFlag", loginFlag);
                        // Send Redirect.
                        response.sendRedirect("selection.jsp");
                    } else if (account.getPerson_type().equals("professor")) {
                        loginFlag = true;
                        Statement stmtAccInf = conn.createStatement();
                        Statement stmtProfInf = conn.createStatement();
                        String sqlAccountInf = "select * from person "
                                + "join professor "
                                + "on (person.person_id = professor.p_person_id) "
                                + "left outer join professor_class "
                                + "using (p_person_id) "
                                + "where person_id = '" + account.getUsername() + "'";
                        ResultSet rsAccInf = stmtAccInf.executeQuery(sqlAccountInf);
                        List<String> classid = new LinkedList<String>();
                        String firstname = "";
                        String lastname = "";
                        String email = "";
                        while (rsAccInf.next()) {
                            firstname = rsAccInf.getString("firstname");
                            lastname = rsAccInf.getString("lastname");
                            email = rsAccInf.getString("email");
                            classid.add(rsAccInf.getString("class_id"));
                        }
                        AccountInformation accInf = new AccountInformation();
                        accInf.setFirstname(firstname);
                        accInf.setLastname(lastname);
                        accInf.setEmail(email);
                        accInf.setClass_id(classid);
                        session.setAttribute("AccountInformation", accInf);
                        // Set flag
                        session.setAttribute("loginFlag", loginFlag);
                        // Send Redirect.
                        response.sendRedirect("selection.jsp");
                    }
                }
            }

        %>

        <script>
                    (function () {
                        'use strict';
                        window.addEventListener('load', function () {
                            // Fetch all the forms we want to apply custom Bootstrap validation styles to
                            var forms = document.getElementsByClassName('needs-validation');
                            // Loop over them and prevent submission
                            var validation = Array.prototype.filter.call(forms, function (form) {
                                form.addEventListener('submit', function (event) {
                                    if (form.checkValidity() === false) {
                                        event.preventDefault();
                                        event.stopPropagation();
                                    }
                                    form.classList.add('was-validated');
                                }, false);
                            });
                        }, false);
                    })();
        </script>
    </body>
</html>
