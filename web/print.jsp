<%-- 
    Document   : print
    Created on : Apr 22, 2018, 3:18:19 PM
    Author     : kornc
--%>

<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account");%>
<jsp:useBean id="AccountInformation" scope="session" class="model.AccountInformation"/>
<jsp:useBean id="Account" scope="session" class="model.Login"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
                            <p>ลาล่วงหน้า/ลาย้อนหลัง</p>
                            <p>วันที่</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <p>เรื่อง ขอ</p>
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
                            <p>ข้าพเจ้า.....</p>
                        </div>
                        <div class="col-md-3">
                            <p>รหัสประจำตัว.....</p>
                        </div>
                        <div class="col-md-2">
                            <p>ภาคเรียนที่.....</p>
                        </div>
                        <div class="col-md-3">
                            <p>ปีการศึกษา.....</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            เป็นนักศึกษาชั้นปีที่....
                        </div>
                        <div class="col-md-2">
                            <p>รุ่น.....</p>
                        </div>
                        <div class="col-md-3">
                            <p>สาขาวิชา.....</p>
                        </div>
                        <div class="col-md-3">
                            <p>ระดับปริญญาตรี</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            มีความประสงค์จะขอลาเนื่องจาก......................
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
                                    1).............
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-11">
                                    2).............
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-11">
                                    3).............
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            จึงขอลาเรียนตั้งแต่วัน........ที่....เดือน.........พ.ศ. ...... ถึง วันที่ ................ เดือน ............................. พ.ศ. ....... รวมเป็นเวลา......วัน เมื่อครบกำหนดแล้วข้าพเข้าจะมาเรียนตามปกติและขอรับรองว่าเป็นความจริงทุกประการ 
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
                            (..........................................................................)
                            <br>
                            ............/................../……………..
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
                            ลงชื่อ...........................................................................อาจารย์ที่ปรึกษา
                            <br>
                            (..........................................................................)
                            <br>
                            ............/................../……………..
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
                                                อาจารย์ผู้สอน
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
                                        <c:forEach var="rowLeavedocument" items="${leavedocumentSql.rows}">
                                            <tr>
                                                <th scope="row">
                                                    ${rowLeavedocument.leave_id}
                                                </th>
                                                <td>
                                                    <div class="form-row">
                                                        <div class="col-md-12">
                                                            ${rowLeavedocument.class_name}
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="col-md-12">
                                                        ${rowLeavedocument.date}
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
                                                                ดูรายละเอียดการลา
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
    </body>
</html>
