<%-- 
    Document   : print
    Created on : Apr 22, 2018, 3:18:19 PM
    Author     : kornc
--%>

<%@page import="java.util.Date"%>
<%@page import="model.LeaveInformation"%>
<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account");%>
<% LeaveInformation printLeave = (LeaveInformation) session.getAttribute("PrintLeavedocument");%>
<jsp:useBean id="AccountInformation" scope="session" class="model.AccountInformation"/>
<jsp:useBean id="Account" scope="session" class="model.Login"/>
<jsp:useBean id="PrintLeavedocument" scope="session" class="model.LeaveInformation"/>
<jsp:useBean id="ClassDocument" scope="session" class="model.ClassDocument"/>
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
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Please Sign-in.");
        } else if (!account.getPerson_type().equals("student")) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You not have Permission.");
        } else {
    %>
    <body onload="window.print()">
        <div class="container">
            <div class="row">
                <div class="col-md-12 mb-4"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-3">
                            <img src="images/itkmitl.png" width="100" height="100"/>
                        </div>
                        <div class="col-md-4 text-center">
                            <p>แบบฟอร์มใบลาเรียนของนักศึกษา</p>
                        </div>
                        <div class="col-md-4 text-right">
                            <p>${PrintLeavedocument.leaveType}</p>
                            <fmt:setLocale value="th"></fmt:setLocale>
                                <p>
                                    วันที่ <fmt:formatDate pattern = "dd" value = "${PrintLeavedocument.dateDocument}" />
                                เดือน <fmt:formatDate pattern = "MMMM" value = "${PrintLeavedocument.dateDocument}" />
                                ปี <fmt:formatDate pattern = "yyyy" value = "${PrintLeavedocument.dateDocument}" />
                            </p>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <p>เรื่อง ขอ${PrintLeavedocument.category}</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <p>เรียน อาจารย์ประวิชา (ผ่านอาจารย์ที่ปรึกษา)</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1">

                        </div>
                        <div class="col-md-3">
                            <p>ข้าพเจ้า ${PrintLeavedocument.firstname} ${PrintLeavedocument.lastname}</p>
                        </div>
                        <div class="col-md-3">
                            <p>รหัสประจำตัว ${PrintLeavedocument.studentId}</p>
                        </div>
                        <div class="col-md-2">
                            <p>ภาคเรียนที่ ${PrintLeavedocument.studentTerm}</p>
                        </div>
                        <div class="col-md-3">
                            <p>ปีการศึกษา ${PrintLeavedocument.leaveYear}</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            เป็นนักศึกษาชั้นปีที่ ${PrintLeavedocument.studentYear}
                        </div>
                        <div class="col-md-2">
                            <p>รุ่น ${PrintLeavedocument.studentGeneration}</p>
                        </div>
                        <div class="col-md-3">
                            <p>สาขาวิชา ${PrintLeavedocument.studentBranch}</p>
                        </div>
                        <div class="col-md-3">
                            <p>ระดับ ${PrintLeavedocument.studentDegree}</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            มีความประสงค์จะขอลาเนื่องจาก ${PrintLeavedocument.studentDescription}
                        </div>
                        <div class="col-md-4">
                            <p>โดยได้แนบเอกสารการลาดังนี้</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1">

                        </div>
                        <div class="col-md-11">
                            <div class="row">
                                <div class="col-md-11">
                                    1) ${PrintLeavedocument.studentAttachment1}
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-11">
                                    2) ${PrintLeavedocument.studentAttachment2}
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-11">
                                    3) ${PrintLeavedocument.studentAttachment3}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <fmt:setLocale value="th"></fmt:setLocale>
                            จึงขอลาเรียนตั้งแต่วัน <fmt:formatDate pattern = "EEEE" value = "${PrintLeavedocument.studentDateFrom}" /> 
                            ที่ <fmt:formatDate pattern = "d" value = "${PrintLeavedocument.studentDateFrom}" />  
                            เดือน <fmt:formatDate pattern = "MMMM" value = "${PrintLeavedocument.studentDateFrom}" /> 
                            พ.ศ. <fmt:formatDate pattern = "yyyy" value = "${PrintLeavedocument.studentDateFrom}" />  
                            ถึง 
                            วัน <fmt:formatDate pattern = "EEEE" value = "${PrintLeavedocument.studentDateTo}" />  
                            ที่ <fmt:formatDate pattern = "d" value = "${PrintLeavedocument.studentDateTo}" /> 
                            เดือน <fmt:formatDate pattern = "MMMM" value = "${PrintLeavedocument.studentDateTo}" /> 
                            พ.ศ. <fmt:formatDate pattern = "yyyy" value = "${PrintLeavedocument.studentDateTo}" /> 
                            รวมเป็นเวลา ${PrintLeavedocument.studentDateTotal} วัน 
                            เมื่อครบกำหนดแล้วข้าพเข้าจะมาเรียนตามปกติและขอรับรองว่าเป็นความจริงทุกประการ 
                            <b>(หากข้อความข้างต้นเป็นเท็จข้าพเจ้าขอยอมรับผิดตามที่คณะเทคโนโลยีสารสนเทศ สจล. เห็นสมควร)</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1">

                        </div>
                        <div class="col-md-3">
                            จึงเรียนมาเพื่อโปรดพิจารณา
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-4"><br><br></div>
                    </div>
                    <div class="row">
                        <div class="col-md-5">

                        </div>
                        <div class="col-md-2">

                        </div>
                        <div class="col-md-5 text-center">
                            ขอแสดงความนับถือ
                            <br><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5">

                        </div>
                        <div class="col-md-2">

                        </div>
                        <div class="col-md-5 text-center">
                            ลงชื่อ.....................................................................นักศึกษา
                            <br>
                            (${PrintLeavedocument.firstname} ${PrintLeavedocument.lastname})
                            <br>
                            <c:set var="current" value="<%=new Date()%>"></c:set>
                            <fmt:setLocale value="th"/>
                            <fmt:formatDate pattern = "dd" value = "${current}" />/
                            <fmt:formatDate pattern = "MM" value = "${current}" />/
                            <fmt:formatDate pattern = "yyyy" value = "${current}" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-4">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5 text-center">
                            ลงชื่อ.....................................................................ผู้ปกครอง
                            <br>
                            (..........................................................................)
                            <br>
                            ............/................../……………..
                        </div>
                        <div class="col-md-2">
                            หรือ
                        </div>
                        <div class="col-md-5 text-center">
                            ลงชื่อ...............................................................อาจารย์ที่ปรึกษา
                            <br>
                            (${PrintLeavedocument.advisorName})
                            <br>
                            <fmt:formatDate pattern = "dd" value = "${current}" />/
                            <fmt:formatDate pattern = "MM" value = "${current}" />/
                            <fmt:formatDate pattern = "yyyy" value = "${current}" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-4">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive-md">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">
                                                ลำดับ
                                            </th>
                                            <th scope="col">
                                                รหัสวิชา
                                            </th>
                                            <th scope="col">
                                                ชื่อวิชา
                                            </th>
                                            <th scope="col">
                                                อาจารย์ผู้อนุมัติ
                                            </th>
                                            <th scope="col">
                                                สถานะ
                                            </th>
                                            <th scope="col">
                                                วัน / เดือน / ปี
                                            </th>
                                            <th scope="col">
                                                หมายเหตุ
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="rowClass" items="${ClassDocument.classDoc}" varStatus="loopCount">
                                            <tr>
                                                <th scope="row">
                                                    ${loopCount.count}
                                                </th>
                                                <td>
                                                    <div class="form-row">
                                                        <div class="col-md-12">
                                                            ${rowClass.classId}
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12">
                                                        ${rowClass.className}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12">
                                                        ${rowClass.classProfessor}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-row">
                                                        <div class="col-md-12">
                                                            <c:if test = "${rowClass.classStatus == 'อนุมัติ'}">
                                                                <p class="text-success">
                                                                    ${rowClass.classStatus}
                                                                </p>
                                                            </c:if>
                                                            <c:if test = "${rowClass.classStatus == 'รอการอนุมัติ'}">
                                                                <p class="">
                                                                    ${rowClass.classStatus}
                                                                </p>
                                                            </c:if>
                                                            <c:if test = "${rowClass.classStatus == 'ไม่อนุมัติ'}">
                                                                <p class="text-danger">
                                                                    ${rowClass.classStatus}
                                                                </p>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12">
                                                        <fmt:formatDate pattern = "dd/MM/yyyy" value = "${rowClass.classDate}" />
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12">
                                                        ${rowClass.classNote}
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
        <%
            }
        %>
    </body>
</html>
