<%-- 
    Document   : profile
    Created on : Apr 5, 2018, 3:10:31 PM
    Author     : kornc
--%>

<%@page import="model.AccountInformation"%>
<%@page import="model.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<% Login account = (Login) session.getAttribute("Account"); %>
<% AccountInformation accountInf = (AccountInformation) session.getAttribute("AccountInformation"); %>
<jsp:useBean id="AccountInformation" scope="session" class="model.AccountInformation"/>
<jsp:useBean id="Account" scope="session" class="model.Login"/>
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
        <script src="js/bootstrap.datepicker.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>

        <!-- Popup -->
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
                        <p>กรุณาเข้าสู่ระบบ หรือ <a href="login.jsp" class="text-danger">คลิก</a></p> 
                    </div>
                    <div class="modal-footer">
                        <a href="login.jsp"><button type="button" class="btn btn-red">Close</button></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Check Login -->
        <% if (account == null || account.getUsername() == null) { %>

        <script type="text/javascript">
            $('#plssignin').modal('show');
        </script>
        <meta http-equiv="Refresh" CONTENT="2;URL=login.jsp">

        <% } else {
           %>

        <%@include file="header.jsp" %>

        <% if (request.getParameter("data") == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "PAGE NOT FOUND");
            } else if (request.getParameter("data").equals("general")) { %>


        <!-- General Information -->
        <div class="container mx-auto">
            <div class="py-4 text-center title">
                <h2>
                    ข้อมูลส่วนตัว
                </h2>
            </div>

            <div class="row justify-content-md-center">
                <div class="col col-md-3" id="menuprofile">
                    <div class="list-group">
                        <a href="profile.jsp?data=general" class="list-group-item list-group-item-action active">
                            ข้อมูลทั่วไป
                        </a>
                    </div>
                    <div class="mb-2"></div>
                    <% if (account.getPerson_type() != null) { %>
                    <div class="list-group">
                        <a href="profile.jsp?data=class" class="list-group-item list-group-item-action">
                            ข้อมูลวิชา
                        </a>
                    </div>
                    <% } %>
                </div>

                <% if (account.getPerson_type() == null) { %>
                <div class="bg-white form-content col col-md-9">
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชื่อผู้ใช้งาน</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${Account.username}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชื่อ</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.firstname}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>นามสกุล</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.lastname}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>Email</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.email}"/></p>
                        </div>
                    </div>
                </div>
                <% } else if (account.getPerson_type().equals("student")) { %>
                <div class="bg-white form-content col col-md-9">
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชื่อผู้ใช้งาน</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${Account.username}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชื่อ</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.firstname}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>นามสกุล</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.lastname}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชั้นปี</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.student_year}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ระดับปริญญา</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.student_degree}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>สาขา</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.student_branch}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ภาคเรียนที่</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.student_term}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>Email</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.email}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>รุ่น</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.generation_id}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>กลุ่มเรียน</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.section_no}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>อาจารย์ที่ปรึกษา</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.professor_name}"/></p>
                        </div>
                    </div>
                </div>
                <% } else if (account.getPerson_type().equals("professor")) {%>
                <div class="bg-white form-content col col-md-9">
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชื่อผู้ใช้งาน</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${Account.username}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>ชื่อ</strong></p>
                        </div>
                        <div class="col">
                            <% AccountInformation accInf = (AccountInformation) session.getAttribute("AccountInformation"); %>
                            <% System.out.println(accInf.getFirstname()); %>
                            <p class="lead text-muted"><c:out value="${AccountInformation.firstname}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>นามสกุล</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.lastname}"/></p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-3">
                            <p class="lead"><strong>Email</strong></p>
                        </div>
                        <div class="col">
                            <p class="lead text-muted"><c:out value="${AccountInformation.email}"/></p>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <% } else if (request.getParameter("data").equals("class")) {
                if (account.getPerson_type() == null) {
                    response.sendRedirect("404.html");
                } else { %>

            <!-- Class Information -->
            <div class="container mx-auto">
                <div class="py-4 text-center title">
                    <h2>
                        ข้อมูลส่วนตัว
                    </h2>
                </div>

                <div class="row justify-content-md-center">
                    <div class="col col-md-3" id="menuprofile">
                        <div class="list-group">
                            <a href="profile.jsp?data=general" class="list-group-item list-group-item-action">
                                ข้อมูลทั่วไป
                            </a>
                        </div>
                        <div class="mb-2"></div>
                        <div class="list-group">
                            <a href="profile.jsp?data=class" class="list-group-item list-group-item-action active">
                                ข้อมูลวิชา
                            </a>
                        </div>
                    </div>

                    <% if (account.getPerson_type().equals("student")) { %>

                    <sql:query var="els" dataSource="webpro02test">
                        select * from student
                        join student_section
                        on (student.p_person_id = student_section.student_p_person_id)
                        join section
                        on (section.section_id = student_section.section_section_id)
                        join class
                        on (class.class_id = section.class_class_id)
                        where p_person_id = '${Account.username}'
                        and class_year = ${AccountInformation.student_year} and term = ${AccountInformation.student_term};
                    </sql:query>

                    <div class="bg-white form-content col col-md-9">
                        <div class="table-responsive-md">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">
                                            รหัสวิชา
                                        </th>
                                        <th scope="col">
                                            ชื่อวิชา
                                        </th>
                                        <th scope="col">
                                            กลุ่มเรียน
                                        </th>
                                        <th scope="col">
                                            เวลาเรียน
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${els.rows}">
                                        <tr>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.class_id}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.class_name}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.section_name}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.time}
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } else if (account.getPerson_type().equals("professor")) {%>
                    <sql:query var="els" dataSource="webpro02test">
                        select * from professor
                        join professor_class
                        using (p_person_id)
                        join class
                        using (class_id)
                        join section
                        on (class.class_id = section.class_class_id)
                        where p_person_id = '<%= account.getUsername()%>';
                    </sql:query>

                    <div class="bg-white form-content col col-md-9">
                        <div class="table-responsive-md">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">
                                            รหัสวิชา
                                        </th>
                                        <th scope="col">
                                            ชื่อวิชา
                                        </th>
                                        <th scope="col">
                                            กลุ่มเรียน
                                        </th>
                                        <th scope="col">
                                            เวลาเรียน
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (AccountInformation.getClass_id() != null) { %>
                                    <c:forEach var="row" items="${els.rows}">
                                        <tr>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.class_id}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.class_name}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.section_name}
                                                </div>
                                            </td>
                                            <td>
                                                <div class="col-md-12">
                                                    ${row.time}
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% }
                    }%>
                <% }%>

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



    </body>
    <!-- Load JS -->
    <script src="js/date.js"></script>
    <script type="text/javascript" src="js/sumdate.js"></script>
</html>
