<%-- 
    Document   : header
    Created on : Apr 2, 2018, 9:41:21 AM
    Author     : kornc
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="model.Login"%>
<% Login accHead = (Login) session.getAttribute("Account"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta property="title" content="Korn Chinnatan"/>
        <meta property="description" content="I’m 19 year-old. graduated from Prommanusorn Phetchaburi School.now studying in information technology at King Mongkut’s Institute of Technology Ladkrabang.interested in web development and programming."/>
        <meta name="keywords" content="Korn,Chinnatan,Chatthong,KMITL,IT,eLeave,System,eLeave System"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link rel="icon" href="images/itkmitl.ico">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script>window.jQuery || document.write('<script src="js/jquery-slim.min.js"><\/script>')</script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            $(function () {
                $('.navbar-nav li a').each(function () {
                    if ($(this).prop('href') == window.location.href) {
                        $(this).addClass('active');
                    }
                });
            });
        </script>
    </head>
    <body>

        <% if (accHead == null) { %>
        <% response.sendError(HttpServletResponse.SC_NOT_FOUND); %>
        <% } else { %>

        <nav class="navbar navbar-expand-md navbar-red fixed-top bg-red">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="images/logo.png" width="32" height="32" class="d-inline-block align-top" alt="">
                    ระบบลาเรียนออนไลน์
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="selection.jsp">หน้าหลัก <span class="sr-only">(current)</span></a>
                        </li>
                        <% if (accHead.getPerson_type() == null) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="summary.jsp">จัดทำสรุปรายวิชา <span class="sr-only">(current)</span></a>
                        </li>
                        <% } else { %>
                        <% if (accHead.getPerson_type().equals("professor")) {%>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                จัดการการลา
                            </a>
                            <div class="dropdown-menu" aria-labelledby="dropdown01">
                                <a class="dropdown-item" href="manage.jsp">แบบรายวิชา</a>
                                <%
                                    Connection connHeader = (Connection) getServletContext().getAttribute("connection");
                                    String sqlQuery = "select * from professor "
                                            + "join section_student "
                                            + "using (p_person_id)";
                                    Statement stmt = connHeader.createStatement();
                                    ResultSet rsHeader = stmt.executeQuery(sqlQuery);
                                    while(rsHeader.next()) {
                                    if(rsHeader.getString("p_person_id").equals(accHead.getUsername())) {
                                %>
                                <a class="dropdown-item" href="manageadvisor.jsp">แบบอาจารย์ที่ปรึกษา</a>
                                <% } }%>
                            </div>
                        </li>
                        <% } %>
                        <% if (accHead.getPerson_type().equals("student") || accHead.getPerson_type().equals("professor")) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="history.jsp">ประวัติการลา <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="studentleavedocument.jsp">จัดทำเอกสารการลา <span class="sr-only">(current)</span></a>
                        </li>
                        <% } %>
                        <% }%>
                        <li class="nav-item">
                            <a class="nav-link" href="#">คู่มือการใช้งาน</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%= accHead.getUsername()%></a>
                            <div class="dropdown-menu" aria-labelledby="dropdown01">
                                <a class="dropdown-item" href="profile.jsp?data=general">Profile</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="logout.do">Sign out</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <% }%>
    </body>
</html>
