<%-- 
    Document   : studentleavedocument
    Created on : Apr 27, 2018, 3:23:17 PM
    Author     : kornc
--%>

<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib  uri = "http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
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
        <!--Check Login Flag=True ?-->
        <%
            if (account == null || account.getUsername() == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please Sign-in.");
            } else if(!account.getPerson_type().equals("student")) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You not have Permission.");
            } else {
        %>
        <%@include file="header.jsp" %>
        <div class="container mx-auto">
            <div class="py-4 text-center manage-title">
                <h2>
                    จัดทำเอกสารการลา
                </h2>
            </div>

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
                                                        <form action="print.do" method="post" target="_blank">
                                                            <div class="form-row">
                                                                <div class="col-md-12">
                                                                    <input type="hidden" name="leaveid" id="leaveid" value="${rowLeavedocument.leave_id}">
                                                                    <button type="submit" class="btn btn-primary">
                                                                        พิมพ์
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </form>
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

            <%@include file="footer.jsp" %>    
        </div>

        <%
            }
        %>
    </body>
</html>
