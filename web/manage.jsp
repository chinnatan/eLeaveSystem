<%-- 
    Document   : manage
    Created on : Apr 21, 2018, 5:26:05 PM
    Author     : kornc
--%>

<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account"); %>
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
        <link href="https://fonts.googleapis.com/css?family=Kanit" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <link rel="icon" href="images/itkmitl.ico">
        <script>
            window.jQuery || document.write('<script src="js/jquery-slim.min.js"><\/script>')
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.datepicker.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </script>
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
    <div class="modal fade" tabindex="-1" role="dialog" id="nopermission">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">แจ้งเตือน</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>คุณไม่มีสิทธิ์เข้าถึงหน้านี้. <a href="selection.jsp" class="text-danger">คลิก</a></p> 
                </div>
                <div class="modal-footer">
                    <a href="login.jsp"><button type="button" class="btn btn-red">Close</button></a>
                </div>
            </div>
        </div>
    </div>
    <!--End PopUp Notification-->

    <!--Check Login Flag=True ?-->
    <% if (account == null || account.getPerson_type() == null) { %>
    <script type="text/javascript">
            $('#plssignin').modal('show');
    </script>
    <META HTTP-EQUIV="Refresh" CONTENT="2;URL=login.jsp">
    <% } else { %>
    <% if (!account.getPerson_type().equals("professor")) { %>
    <script type="text/javascript">
        $('#nopermission').modal('show');
    </script>
    <META HTTP-EQUIV="Refresh" CONTENT="2;URL=selection.jsp">
    <% } else {
    %>

    <!--Start Include Header-->
    <%@include file="header.jsp" %>
    <!--End Include Header-->


    <div class="container mx-auto">
        <div class="py-4 text-center manage-title">
            <h2>
                การจัดการการลา - แบบรายวิชา
            </h2>
        </div>

        <!-- การจัดการการลา -->
        <!--Query Class with Student-->
        <sql:query var="els" dataSource="webpro02test">
            select * from person
            join professor
            on (person.person_id = professor.p_person_id)
            join professor_class
            using (p_person_id)
            join class
            using (class_id)
            where p_person_id = '${Account.username}'
        </sql:query>
        <div class="row justify-content-md-center">
            <% String classAction = request.getParameter("class"); %>
            <% String className = request.getParameter("class_name"); %>
            <div class="col col-md-3">
                <form action="manage.jsp?class=true" method="post">
                    <div class="col col-md-12 bg-white form-content">
                        <label class="mr-sm-2" for="class_name">วิชา</label>
                        <% if (classAction != null) {%>
                        <select class="custom-select mr-sm-2" id="class_name" name="class_name">
                            <option selected><%= className%></option>
                            <c:forEach var="row" items="${els.rows}">
                                <option value="${row.class_name}">${row.class_name}</option>
                            </c:forEach>
                        </select>
                        <% } else { %>
                        <select class="custom-select mr-sm-2" id="class_name" name="class_name">
                            <option selected>ทั้งหมด</option>
                            <c:forEach var="row" items="${els.rows}">
                                <option value="${row.class_name}">${row.class_name}</option>
                            </c:forEach>
                        </select>
                        <% } %>
                        <div class="col-md-12 pt-3">
                            <button type="submit" class="btn btn-md btn-block btn-red" name="send_submit">
                                ยืนยัน
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="bg-white form-content col col-md-9">
                <% if (classAction == null) { %>
                <h4 class="col-md-12 mb-2">
                    ข้อมูลการลาประจำวิชา - ทั้งหมด
                </h4>
                <% } else {%>
                <h4 class="col-md-12 mb-2">
                    ข้อมูลการลาประจำวิชา - <%= className%>
                </h4>
                <% } %>
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

                                        </th>
                                        <th scope="col">
                                            อนุมัติ/ไม่อนุมัติ
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
                                    join class
                                    on (class.class_id = leavedocument_section.subjectleave_id)
                                    where subjectleave_id in (select class_id
                                    from professor
                                    join professor_class
                                    using (p_person_id) where p_person_id = '${Account.username}')
                                    and class_name = '<%= className%>' and status = 'รอการอนุมัติ'
                                    order by leave_id desc;
                                </sql:query>
                                <% } else { %>
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
                                    where subjectleave_id in (select class_id
                                    from professor
                                    join professor_class
                                    using (p_person_id) where p_person_id = '${Account.username}')
                                    and status = 'รอการอนุมัติ'
                                    order by leave_id desc;
                                </sql:query>
                                <% } %>
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
                                                <div class="form-row">
                                                    <div class="col-md-12">
                                                        <c:set var = "leaveDate" value = "${rowLeavedocument.leave_date}" />
                                                        <fmt:setLocale value="th"/>
                                                        <fmt:formatDate pattern = "dd/MM/yyyy" value = "${leaveDate}" /> 
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
                                            <td>
                                                <div class="form-row">
                                                    <div class="col-md-12 mb-1">
                                                        <a class="modellinkmanage btn btn-sm btn-success" data-toggle="modal" href="confirmmanage.jsp?flag=success&leaveid=${rowLeavedocument.leave_id}&classid=${rowLeavedocument.class_id}&section=${rowLeavedocument.section_id}">
                                                            อนุมัติ
                                                        </a>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <a class="modellinkmanage btn btn-sm btn-danger" data-toggle="modal" href="confirmmanage.jsp?flag=unsuccess&leaveid=${rowLeavedocument.leave_id}&classid=${rowLeavedocument.class_id}&section=${rowLeavedocument.section_id}">
                                                            ไม่อนุมัติ
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

        <!-- Modal Window Container -->
        <div class="modal-container">
        </div>

        <div class="modal-manage">
        </div>

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

    <% }
        }%>



</body>
<script type="text/javascript">
    $(document).ready(function (e) {
        jQuery('.modellink').click(function (e) {
            $('.modal-container').load($(this).attr("href"), function (result) {
                $('#leavedescriptionModal').modal({show: true});
            });
        });
    });

    $(document).ready(function (m) {
        jQuery('.modellinkmanage').click(function (m) {
            $('.modal-manage').load($(this).attr("href"), function (result) {
                $('#manageModal').modal({show: true});
            });
        });
    });
</script>
<!-- Load JS -->
<script src="js/date.js"></script>
<script type="text/javascript" src="js/sumdate.js"></script>
</html>
