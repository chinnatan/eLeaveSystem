<%-- 
    Document   : printsummary
    Created on : Apr 22, 2018, 6:18:59 PM
    Author     : kornc
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account");%>
<jsp:useBean id="AccountInformation" scope="session" class="model.AccountInformation"/>
<jsp:useBean id="Account" scope="session" class="model.Login"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib  uri = "http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport"/>
        <meta content="Korn Chinnatan" property="title"/>
        <meta content="I’m 19 year-old. graduated from Prommanusorn Phetchaburi School.now studying in information technology at King Mongkut’s Institute of Technology Ladkrabang.interested in web development and programming." property="description"/>
        <meta content="Korn,Chinnatan,Chatthong,KMITL,IT,eLeave,System,eLeave System" name="keywords"/>
        <meta charset="utf-8"/>
        <title>
            ระบบลาเรียนออนไลน์, คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง, Information Technology - KMITL
        </title>
        <link rel="icon" href="images/itkmitl.ico">
        <link href="https://fonts.googleapis.com/css?family=Kanit" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script>
            window.jQuery || document.write('<script src="js/jquery-slim.min.js"><\/script>')
        </script>
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.datepicker.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>

    <%
        if (account == null || account.getUsername() == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please Sign-in");
    %>


    <% } else if (account.getPerson_type() != null) { %>
    <% response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You not have permission."); %>
    <% } else { %>

    <!-- Current Date -->
    <% Date curDate = new Date(); %>
    <% SimpleDateFormat format = new SimpleDateFormat("dd MMMM yyyy", new Locale("th", "TH")); %>
    <% String DateToStr = format.format(curDate); %>
    <% String classname = request.getParameter("classname");%>

    <body onload="window.print()">
        <div class="container">
            <div class="row">
                <div class="col-md-12 mb-4"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <h3>รายงานสรุปการลา</h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <h5>วิชา <%= classname%></h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">                            
                            <h6>ประจำวันที่ <%= DateToStr%></h6>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive-md">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">
                                                <div class="text-center">
                                                    รหัสนักศึกษา
                                                </div>
                                            </th>
                                            <th scope="col">
                                                <div class="text-center">
                                                    ชื่อนักศึกษา
                                                </div>
                                            </th>
                                            <th scope="col">
                                                <div class="text-center">
                                                    วันที่ยื่นขอลา
                                                </div>
                                            </th>
                                            <th scope="col">
                                                <div class="text-center">
                                                    ประเภทการลา
                                                </div>
                                            </th>
                                            <th scope="col">
                                                <div class="text-center">
                                                    จำนวนวันที่ล่า
                                                </div>
                                            </th>
                                            <th scope="col">
                                                <div class="text-center">
                                                    สถานะการอนุมัติ
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <!--Query Data-->
                                    <% if (classname.equals("ทั้งหมด")) { %>
                                    <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                        select * from leavedocument
                                        join leavedocument_section
                                        on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                        join person
                                        on (person.person_id = leavedocument.student_p_person_id)
                                        join student
                                        on (person.person_id = student.p_person_id)
                                        join class
                                        on (class.class_id = leavedocument_section.subjectleave_id)
                                        where status != 'รอการอนุมัติ'
                                    </sql:query>
                                    <% } else {%>
                                    <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                        select * from leavedocument
                                        join leavedocument_section
                                        on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                        join person
                                        on (person.person_id = leavedocument.student_p_person_id)
                                        join student
                                        on (person.person_id = student.p_person_id)
                                        join class
                                        on (class.class_id = leavedocument_section.subjectleave_id)
                                        where class_name = '<%= classname%>' and status != 'รอการอนุมัติ'
                                    </sql:query>
                                    <% }%>
                                    <tbody>
                                        <c:forEach var="rowPrint" items="${leavedocumentSql.rows}">
                                            <tr>
                                                <th scope="row">
                                                    <div class="text-center">
                                                        ${rowPrint.student_id}
                                                    </div>
                                                </th>
                                                <td>
                                                    <div class="form-row">
                                                        <div class="col-md-12 text-center">
                                                            ${rowPrint.firstname} ${rowPrint.lastname}
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>                                                   
                                                    <div class="col-md-12 text-center">
                                                        <c:set var = "current" value = "${rowPrint.date}" />
                                                        <fmt:setLocale value="th"/>
                                                        <fmt:formatDate pattern = "dd/MM/yyyy" value = "${current}" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12 text-center">
                                                        ${rowPrint.category}/${rowPrint.type_of_leave}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12 text-center">
                                                        ${rowPrint.total_time} วัน
                                                        <br>
                                                        <c:set var = "startDate" value = "${rowPrint.start_leave_date}" />
                                                        <c:set var = "endDate" value = "${rowPrint.end_leave_date}" />
                                                        <fmt:setLocale value="th"/>
                                                        <fmt:formatDate pattern = "dd/MM/yyyy" value = "${startDate}" /> 
                                                        - 
                                                        <fmt:formatDate pattern = "dd/MM/yyyy" value = "${endDate}" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-row">
                                                        <div class="col-md-12 text-center">
                                                            <c:if test = "${rowPrint.status == 'อนุมัติ'}">
                                                                <p class="text-success">
                                                                    ${rowPrint.status}
                                                                </p>
                                                            </c:if>
                                                            <c:if test = "${rowPrint.status == 'รอการอนุมัติ'}">
                                                                <p class="">
                                                                    ${rowPrint.status}
                                                                </p>
                                                            </c:if>
                                                            <c:if test = "${rowPrint.status == 'ไม่อนุมัติ'}">
                                                                <p class="text-danger">
                                                                    ${rowPrint.status}
                                                                </p>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% }%>
    </body>
</html>
