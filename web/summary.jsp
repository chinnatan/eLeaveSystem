<%-- 
    Document   : summary
    Created on : Apr 22, 2018, 5:40:07 PM
    Author     : kornc
--%>

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
    <body>
        <!--Start PopUp Notification-->
        <div class="modal fade" tabindex="-1" role="dialog" id="plssignin">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">แจ้งเตือน</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>กรุณาเข้าสู่ระบบ. <a href="login.jsp" class="text-danger">คลิก</a></p> 
                    </div>
                    <div class="modal-footer">
                        <a href="login.jsp"><button type="button" class="btn btn-red">Close</button></a>
                    </div>
                </div>
            </div>
        </div>
        <!--End PopUp Notification-->
        <!--Check Login Flag=True ?-->
        <% if (account.getUsername() == null) { %>
        <script type="text/javascript">
            $('#plssignin').modal('show');
        </script>
        <META HTTP-EQUIV="Refresh" CONTENT="2;URL=login.jsp">
        <% } else {
        %>
        <!--Start Include Header-->
        <%@include file="header.jsp" %>
        <!--End Include Header-->

        <div class="container mx-auto">
            <div class="py-4 text-center manage-title">
                <h2>
                    สรุปรายงานของแต่ละวิชา
                </h2>
            </div>

            <% if (account.getPerson_type() != null) { %>
            <% response.sendRedirect("404.html"); %>
            <% } else { %>
            <!-- ประวัติการลา นักศึกษา-->
            <!--Query Class with Student-->
            <sql:query var="els" dataSource="webpro02test">
                select * from class;
            </sql:query>
            <div class="row justify-content-md-center">
                <% String classAction = request.getParameter("class"); %>
                <% String className = request.getParameter("class_name"); %>
                <% String summaryDateFrom = request.getParameter("summaryDateFrom"); %>
                <% String summaryDateTo = request.getParameter("summaryDateTo"); %>
                <div class="col col-md-3">
                    <form action="summary.jsp?class=true" method="post">
                        <div class="col col-md-12 bg-white form-content">
                            <label class="mr-sm-2" for="class_name">วิชา</label>
                            <% if (classAction != null) {%>
                            <select class="custom-select mr-sm-2" id="class_name" name="class_name">
                                <option selected><%= className%> <--</option>
                                <c:forEach var="row" items="${els.rows}">
                                    <option value="${row.class_name}">${row.class_name}</option>
                                </c:forEach>
                            </select>
                            <% } else { %>
                            <select class="custom-select mr-sm-2" id="class_name" name="class_name">
                                <option selected></option>
                                <c:forEach var="row" items="${els.rows}">
                                    <option value="${row.class_name}">${row.class_name}</option>
                                </c:forEach>
                            </select>
                            <% } %>
                            <div class="col-md-12 pt-3">
                                <label class="mr-sm-2" for="summaryDateFrom">ตั้งแต่</label>
                                <input type="date" class="form-control form-control-sm col-md-12" name="summaryDateFrom" id="summaryDateFrom">
                            </div>
                            <div class="col-md-12 pt-3">
                                <label class="mr-sm-2" for="summaryDateTo">ถึง</label>
                                <input type="date" class="form-control form-control-sm col-md-12" name="summaryDateTo" id="summaryDateTo">
                            </div>
                            <div class="col-md-12 pt-3">
                                <button type="submit" class="btn btn-md btn-block btn-red" name="send_submit">
                                    ยืนยัน
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="bg-white form-content col col-md-9">
                    <div id="content">
                        <% if (classAction == null) { %>
                        <h4 class="col-md-8 mb-2">
                            ข้อมูลการลา - ทั้งหมด
                        </h4>
                        <% } else {%>
                        <h4 class="col-md-12 mb-2">
                            ข้อมูลการลา - <%= className%>
                        </h4>
                        <% } %>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive-md">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    รหัสนักศึกษา
                                                </th>
                                                <th scope="col">
                                                    ชื่อนักศึกษา
                                                </th>
                                                <th scope="col">
                                                    วันที่ยื่นขอลา
                                                </th>
                                                <th scope="col">
                                                    สถานะการอนุมัติ
                                                </th>
                                                <th scope="col">
                                                    ประเภทการลา
                                                </th>
                                            </tr>
                                        </thead>
                                        <!--Query Leavedocument with Student-->
                                        <% if (classAction != null) {%>
                                        <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                            select * from leavedocument
                                            join leavedocument_section
                                            on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                            join person
                                            on (person.person_id = leavedocument.student_p_person_id)
                                            join student
                                            using (person_id)
                                            join class
                                            on (class.class_id = leavedocument_section.subjectleave_id)
                                            where class_name = '<%= className%>' 
                                            and (start_leave_date >= '<%=summaryDateFrom%>' and end_leave_date <= '<%=summaryDateTo%>')
                                        </sql:query>
                                        <% } else { %>
                                        <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                            select * from leavedocument
                                            join leavedocument_section
                                            on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                            join person
                                            on (person.person_id = leavedocument.student_p_person_id)
                                            join student
                                            using (person_id)
                                        </sql:query>
                                        <% } %>
                                        <tbody>
                                            <c:forEach var="rowSummary" items="${leavedocumentSql.rows}">
                                                <tr>
                                                    <th scope="row">
                                                        ${rowSummary.student_id}
                                                    </th>
                                                    <td>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                ${rowSummary.firstname} ${rowSummary.lastname}
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="col-md-12">
                                                            <c:set var = "current" value = "${rowSummary.date}" />
                                                            <fmt:setLocale value="th"/>
                                                            <fmt:formatDate pattern = "dd/MM/yyyy" value = "${current}" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <c:if test = "${rowSummary.status == 'อนุมัติ'}">
                                                                    <p class="text-success">
                                                                        ${rowSummary.status}
                                                                    </p>
                                                                </c:if>
                                                                <c:if test = "${rowSummary.status == 'รอการอนุมัติ'}">
                                                                    <p class="">
                                                                        ${rowSummary.status}
                                                                    </p>
                                                                </c:if>
                                                                <c:if test = "${rowSummary.status == 'ไม่อนุมัติ'}">
                                                                    <p class="text-danger">
                                                                        ${rowSummary.status}
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="col-md-12">
                                                            ${rowSummary.category}/${rowSummary.type_of_leave}
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 text-center">
                                <% if (className != null) {%>
                                <a class="btn btn-sm btn-primary" href="printsummary.jsp?classname=<%= className%>" target="_blank">
                                    พิมพ์
                                </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>

            <!-- Footer -->
            <div class="row">
                <div class="col-md-12 text-center">
                    <footer class="my-5 pt-2 text-muted text-center text-small">
                        <p class="mb-1 text-danger">
                            © 2018 KCNT.
                        </p>
                        <!-- <ul class="list-inline">
                            <li class="list-inline-item">
                                <a href="#" class="text-danger">
                                    Privacy
                                </a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#" class="text-danger">
                                    Terms
                                </a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#" class="text-danger">
                                    Support
                                </a>
                            </li>
                        </ul> -->
                    </footer>
                </div>
            </div>  
        </div>
        <% }%>
    </body>
</html>
