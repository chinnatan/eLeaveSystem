<%-- 
    Document   : history
    Created on : Apr 18, 2018, 7:14:31 PM
    Author     : kornc
--%>

<%@page import="model.AccountInformation"%>
<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account"); %>
<% AccountInformation accountInf = (AccountInformation) session.getAttribute("AccountInformation"); %>
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
    <body class="manage">

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
        <% if (account == null || account.getUsername() == null) { %>
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
                    ประวัติการลา
                </h2>
            </div>

            <% if (account.getPerson_type().equals("student")) { %>
            <!-- ประวัติการลา นักศึกษา-->
            <!--Query Class with Student-->
            <sql:query var="els" dataSource="webpro02test">
                select * from class 
                join section 
                on (class.class_id = section.class_class_id) 
                where section_name = ${AccountInformation.section_no} and class_year = ${AccountInformation.student_year} and term = ${AccountInformation.student_term};
            </sql:query>
            <div class="row justify-content-md-center">
                <div class="bg-white form-content col col-md-9">
                    <div id="content">
                        <h4 class="col-md-12 mb-2">
                            ข้อมูลการลา
                        </h4>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive-md">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    เลขใบลา
                                                </th>
                                                <th scope="col">
                                                    วันที่ยื่นขอลา
                                                </th>
                                                <th scope="col">
                                                    อาจารย์ที่ปรึกษาลงชื่อ
                                                </th>
                                                <th scope="col">

                                                </th>
                                            </tr>
                                        </thead>
                                        <!--Query Leavedocument with Student-->
                                        <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                            select * 
                                            from leavedocument 
                                            where student_p_person_id = '${Account.username}'
                                            order by leave_id desc
                                        </sql:query>
                                            
                                        <tbody>
                                            <c:forEach var="rowLeavedocument" items="${leavedocumentSql.rows}">
                                                <tr>
                                                    <th scope="row">
                                                        ${rowLeavedocument.leave_id}
                                                    </th>
                                                    <td>
                                                        <div class="col-md-12">
                                                            <c:set var = "current" value = "${rowLeavedocument.leave_date}" />
                                                            <fmt:setLocale value="th"/>
                                                            <fmt:formatDate pattern = "dd/MM/yyyy" value = "${current}" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        ${rowLeavedocument.advisor}
                                                    </td>
                                                    <td>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <a class="modellink btn btn-primary" data-toggle="modal" href="viewhistory.jsp?leaveid=${rowLeavedocument.leave_id}">
                                                                    รายละเอียด
                                                                </a>
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
            <% } else if (account.getPerson_type().equals("professor")) { %>
            <!-- ประวัติการลา -->
            <!--Query Class with Student-->
            <sql:query var="els" dataSource="webpro02test">
                select * from professor
                join professor_class
                using (p_person_id)
                join class
                using (class_id)
                where p_person_id = '${Account.username}';
            </sql:query>
            <div class="row justify-content-md-center">

                <div class="bg-white form-content col col-md-9">
                    <div id="content">
                        <h4 class="col-md-12 mb-2">
                            ข้อมูลการลา
                        </h4>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive-md">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    เลขใบลา
                                                </th>
                                                <th scope="col">
                                                    ชื่อนักศึกษา
                                                </th>
                                                <th scope="col">
                                                    วันที่ยื่นขอลา
                                                </th>
                                                <th scope="col">
                                                    อนุมัติ/ไม่อนุมัติ
                                                </th>
                                                <th scope="col">

                                                </th>
                                            </tr>
                                        </thead>
                                        
                                        <%
                                            String classid = "";
                                            for(int i=0;i<accountInf.getClass_id().size();i++) {
                                                classid += "'";
                                                classid += accountInf.getClass_id().get(i);
                                                classid += "'";
                                                if(i<accountInf.getClass_id().size() - 1) {
                                                    classid += ",";
                                                } else {
                                                    classid += "";
                                                }
                                            }
                                        %>
                                        <!--Query Leavedocument with Student-->
                                        <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                            select * from leavedocument
                                            join leavedocument_section
                                            on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                            join person
                                            on (person.person_id = leavedocument.student_p_person_id)
                                            join class
                                            on (class.class_id = leavedocument_section.subjectleave_id)
                                            join section
                                            on (section.section_id = leavedocument_section.section_section_id)
                                            where class_id in (<%=classid%>)
                                            order by leave_id desc
                                        </sql:query>
                                        <tbody>
                                            <c:forEach var="rowLeavedocument" items="${leavedocumentSql.rows}">
                                                <tr>
                                                    <th scope="row">
                                                        ${rowLeavedocument.leave_id}
                                                        <br><p class="text-muted">${rowLeavedocument.class_name} (${rowLeavedocument.section_name})</p>
                                                    </th>
                                                    <td>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                ${rowLeavedocument.firstname} ${rowLeavedocument.lastname}
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="col-md-12">
                                                            <c:set var = "current" value = "${rowLeavedocument.leave_date}" />
                                                            <fmt:setLocale value="th"/>
                                                            <fmt:formatDate pattern = "dd/MM/yyyy" value = "${current}" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <c:if test = "${rowLeavedocument.status == 'อนุมัติ'}">
                                                                    <p class="text-success">
                                                                        ${rowLeavedocument.status}
                                                                    </p>
                                                                </c:if>
                                                                <c:if test = "${rowLeavedocument.status == 'รอการอนุมัติ'}">
                                                                    <p class="">
                                                                        ${rowLeavedocument.status}
                                                                    </p>
                                                                </c:if>
                                                                <c:if test = "${rowLeavedocument.status == 'ไม่อนุมัติ'}">
                                                                    <p class="text-danger">
                                                                        ${rowLeavedocument.status}
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="form-row">
                                                            <div class="col-md-12">
                                                                <a class="modellink btn btn-primary" data-toggle="modal" href="viewhistory.jsp?leaveid=${rowLeavedocument.leave_id}">
                                                                    รายละเอียด
                                                                </a>
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

        <!-- Modal Window Container -->
        <div class="modal-container">
        </div>

    </body>
    <script type="text/javascript">
        $(document).ready(function (e) {
            jQuery('.modellink').click(function (e) {
                $('.modal-container').load($(this).attr("href"), function (result) {
                    $('#leavedescriptionModal').modal({show: true});
                });
            });
        });
    </script>

    <!-- Load JS -->
    <script src="js/date.js"></script>
    <script type="text/javascript" src="js/sumdate.js"></script>
</html>
