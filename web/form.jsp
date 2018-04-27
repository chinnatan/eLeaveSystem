<%-- 
    Document   : form
    Created on : Apr 7, 2018, 7:03:39 PM
    Author     : kornc
--%>

<%@page import="model.AccountInformation"%>
<%@page import="model.Login"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<% Login account = (Login) session.getAttribute("Account"); %>
<% AccountInformation accInf = (AccountInformation) session.getAttribute("AccountInformation");%>
<sql:query var="classStudent" dataSource="webpro02test">
    select * from class where class_year = <%= accInf.getStudent_year()%>
</sql:query>
<%
    Calendar c = Calendar.getInstance();
    SimpleDateFormat df = new SimpleDateFormat("ddMMyyyyHHmmss");
    String currentDate = df.format(c.getTime());
%>
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
        </script>
    </head>
    <body>

        <% if (account == null) { %>
        <script type="text/javascript">
            $('#plssignin').modal('show');
        </script>
        <% } else { %>
        <%@include file="header.jsp" %>

        <div class="container">
            <form action="form.do" enctype="multipart/form-data" method="post">
                <div class="py-4 text-center form-title">
                    <h2>
                        <% if (request.getParameter("data") == null) { %>
                        <META HTTP-EQUIV="Refresh" CONTENT="0;URL=404.html">
                        <% } else if (request.getParameter("data").equals("stickleave")) { %>
                        <% String category = "ลาป่วย"; %>
                        แบบฟอร์มการลาป่วย
                        <% } else if (request.getParameter("data").equals("personalleave")) { %>
                        <% String category = "ลากิจ"; %>
                        แบบฟอร์มการลากิจ
                        <% } else if (request.getParameter("data").equals("otherleave")) { %>
                        <% String category = "ลาทั่วไป"; %>
                        แบบฟอร์มการลาทั่วไป
                        <% } %>
                    </h2>
                    <p class="lead text-danger">
                        *กรุณากรอกรายละเอียดให้ครบถ้วน*
                    </p>
                </div>
                <!-- ข้อมูลทั่วไป -->
                <div class="row bg-white form-content">
                    <h4 class="col-md-2 mb-2">
                        ข้อมูลทั่วไป
                    </h4>
                    <div class="col-md-12">
                        <div class="form-row">
                            <div class="col-md-2">
                                <% if (request.getParameter("data").equals("stickleave")) { %>
                                <input class="form-check-input" type="hidden" name="category_type" id="category_type" value="ลาป่วย" >
                                <% } else if (request.getParameter("data").equals("personalleave")) { %>
                                <input class="form-check-input" type="hidden" name="category_type" id="category_type" value="ลากิจ" >
                                <% } else if (request.getParameter("data").equals("otherleave")) { %>
                                <input class="form-check-input" type="hidden" name="category_type" id="category_type" value="ลาทั่วไป" >
                                <% }%>
                            </div>
                            <div class="col-md-3 mb-2">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="hidden" name="leave_id" id="leave_id" value="<%= accInf.getStudent_id() + currentDate%>" >
                                    <input class="form-check-input" type="radio" name="leave_type" id="leave_type_1" value="ลาล่วงหน้า" >
                                    <label class="form-check-label" for="leave_type_1">
                                        ลาล่วงหน้า
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-3 mb-2">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="leave_type" id="leave_type_2" value="ลาย้อนหลัง" >
                                    <label class="form-check-label " for="leave_type_2">
                                        ลาย้อนหลัง
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group row">
                                    <label class="col-md-4" for="leave_date">
                                        วันที่ยื่นขอลา
                                    </label>
                                    <input type="date" class="form-control form-control-sm col-6" name="leave_date" id="theDate" value="" readonly="readonly">
                                </div>               
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ข้อมูลส่วนตัว -->
                <div class="row bg-white form-content">
                    <h4 class="col-md-2 mb-2">
                        ข้อมูลส่วนตัว
                    </h4>
                    <div class="col-md-12">
                        <div class="form-row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="first_name">ชื่อ</label>
                                    <input type="text" class="form-control" id="first_name" name="first_name" value="<%= accInf.getFirstname()%>">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="last_name">นามสกุล</label>
                                    <input type="text" class="form-control" id="last_name" name="last_name" value="<%= accInf.getLastname()%>">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="student_id">รหัสประจำตัว</label>
                                    <input type="text" class="form-control" id="student_id" name="student_id" value="<%= accInf.getStudent_id()%>">
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="study_term">ภาคเรียนที่</label>
                                    <input type="text" class="form-control" id="study_term" name="study_term" value="<%= accInf.getStudent_term()%>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="year">ปีการศึกษา</label>
                                    <input type="text" class="form-control" id="study_year" name="year" value="">
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="senior_year">นักศึกษาชั้นปีที่</label>
                                    <input type="text" class="form-control" id="senior_year" name="senior_year" value="<%= accInf.getStudent_year()%>">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="generation">รุ่น</label>
                                    <input type="text" class="form-control" id="generation" name="generation" value="<%= accInf.getGeneration_id()%>">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="branch">สาขาวิชา</label>
                                    <input type="text" class="form-control" id="branch" name="branch" value="<%= accInf.getStudent_branch()%>">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="mr-sm-2" for="degree">ระดับปริญญา</label>
                                <select class="custom-select mr-sm-2" id="degree" name="degree">
                                    <option value="<%= accInf.getStudent_degree()%>" selected><%= accInf.getStudent_degree()%></option>
                                    <!--                            <option value="ปริญญาตรี">ปริญญาตรี</option>
                                                                <option value="ปริญญาโท">ปริญญาโท</option>
                                                                <option value="ปริญญาเอก">ปริญญาเอก</option>-->
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-12">
                                <label for="description_leave">ความประสงค์จะขอลาเรียนเนื่องจาก</label>
                                <textarea class="form-control" rows="5" id="description_leave" name="description_leave"></textarea>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-12">
                                <label for="attach_leave">เอกสารประกอบการลา</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="leaveFile1" name="leaveFile1" accept="application/pdf">
                                    <label class="custom-file-label" for="leaveFile1">Choose file</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="leaveFile2" name="leaveFile2" accept="application/pdf">
                                    <label class="custom-file-label" for="leaveFile2">Choose file</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="leaveFile3" name="leaveFile3" accept="application/pdf">
                                    <label class="custom-file-label" for="leaveFile3">Choose file</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-4">
                                <label for="start_date_leave">จึงขอลาเรียนตั้งแต่</label>
                                <input type="date" class="form-control" id="start_date_leave" name="start_date_leave" onchange="cal();">
                            </div>
                            <div class="col-md-4">
                                <label for="end_date_leave">ถึง</label>
                                <input type="date" class="form-control" id="end_date_leave" name="end_date_leave" onchange="cal();">
                            </div>
                            <div class="col-md-4">
                                <label for="total_day_leave">รวมเป็นเวลา (วัน)</label>
                                <input type="text" class="form-control" id="total_day_leave" name="total_day_leave" readonly="readonly">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ข้อมูลวิชาที่ต้องการลา -->
                <div class="row bg-white form-content">
                    <h4 class="col-md-2 mb-2">
                        ข้อมูลรายวิชา
                    </h4>
                    <div class="col-md-12">
                        <div class="table-responsive-md">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">
                                            ลำดับ
                                        </th>
<!--                                        <th scope="col">
                                            รหัสวิชา
                                        </th>-->
                                        <th scope="col">
                                            ชื่อวิชา
                                        </th>
                                        <th scope="col">
                                            กลุ่มเรียน
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 1; i <= 7; i++) {%>
                                    <tr>
                                        <th scope="row">
                                            <%= i%>
                                        </th>
                                        <td>
                                            <div class="form-row">
                                                <div class="col-md-12">
                                                    <select class="custom-select mr-sm-2" id="class_name_<%= i%>" name="class_name_<%= i%>">
                                                        <option selected></option>
                                                        <c:forEach var="row" items="${classStudent.rows}">
                                                            <option value="${row.class_name}">${row.class_name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-row">
                                                <div class="col-md-12">
                                                    <select class="custom-select mr-sm-2" id="class_section_<%= i%>" name="class_section_<%= i%>">
                                                        <option selected></option>
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                        <option value="5">5</option>
                                                        <option value="6">6</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- หมายเหตุ -->
                <div class="row bg-white form-content">
                    <h4 class="col-md-2 mb-2">
                        หมายเหตุ
                    </h4>
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12">
                                <ul class="list-unstyled">
                                    <li class="h6"><b>- การลาป่วย</b></li>
                                    <ul>
                                        <li>การลาป่วยในระหว่างเรียน นักศึกษาต้องยื่นใบลาในวันแรกที่กลับเข้ามาเรียน ในกรณีลาป่วยตั้งแต่ 5 วันขึ้นไป</li>
                                        <li>ต้องมีใบรับรองแพทย์โดยยื่นต่ออาจารย์ประจำวิชา</li>
                                    </ul>
                                    </li>
                                    <li class="h6"><b>- การลากิจ</b></li>
                                    <ul>
                                        <li>นักศึกษาที่จำเป็นต้องลาระหว่างชั่วโมงเรียนต้องขออนุญาตจากอาจารย์ประจำวิชานั้น</li>
                                        <li>นักศึกษาที่จะต้องลากิจตั้งแต่ 1 วันขึ้นไป ต้องยื่นใบลา <b><u>ก่อน</u></b> วันลาพร้อมด้วยเหตุผลและคำรับรองของผู้ปกครองหรืออาจารย์ที่ปรึกษาอย่างใดอย่างหนึ่ง โดยยื่นต่ออาจารย์ประจำวิชา</li>
                                    </ul>
                                    </li>
                                    <li class="h6"><b>- การลาอื่นๆ</b></li>
                                    <ul>
                                        <li>การลาช่วงสอบกลางภาค ระดับปริญญาตรีและระดับบัณฑิตศึกษา
                                            <ul>
                                                <li>
                                                    ถือปฏิบัติตามประกาศคณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง เรื่อง การขอเลื่อนสอบกลางภาคการศึกษา คณะเทคโนโลยีสารสนเทศ ประกาศ ณ วันที่ 7 พฤษภาคม 2558 (กรณีที่ไม่สามารถเข้าสอบกลางภาคได้ สามารถยื่นหลักฐานหรือเอกสารเพื่อขออนุมัติสอบนอกตาราง)
                                                </li>
                                            </ul>
                                        </li>
                                        <li>การลาช่วงสอบปลายภาค ระดับปริญญาตรีและระดับบัณฑิตศึกษา
                                            <ul>
                                                <li>
                                                    <b><u>ระดับปริญญาตรี</u></b> ถือปฏิบัติตามข้อบังคับ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง ว่าด้วยการศึกษาระดับปริญญาตรี พ.ศ. 2559 (ข้อ 22 การสอบปลายภาค)
                                                </li>
                                                <li>
                                                    <b><u>ระดับบัณฑิตศึกษา</u></b>ถือปฏิบัติตามข้อบังคับ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง ว่าด้วยการศึกษาระดับบัณฑิตศึกษา พ.ศ. 2559 (ข้อ 29 การสอบปลายภาค)
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-3 mb-2">
                        <button type="submit" class="btn btn-lg btn-block btn-red" name="send_document">
                            ยื่นขอลา
                        </button>
                    </div>
                    <div class="col-md-3">
                        <a href="selection.jsp">
                            <button type="button" class="btn btn-lg btn-block" name="cancle_document">
                                ยกเลิก
                            </button>
                        </a>
                    </div>
                    <div class="col-md-3"></div>
                </div>
            </form>

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
    <!-- Load JS -->
    <script src="js/date.js"></script>
    <script type="text/javascript" src="js/sumdate.js"></script>
    <script>
            $('#leaveFile1').on('change',function(){
                //get the file name
                var fileName = $(this).val();
                //replace the "Choose a file" label
                $(this).next('.custom-file-label').html(fileName);
            })
            
            $('#leaveFile2').on('change',function(){
                //get the file name
                var fileName = $(this).val();
                //replace the "Choose a file" label
                $(this).next('.custom-file-label').html(fileName);
            })
            
            $('#leaveFile3').on('change',function(){
                //get the file name
                var fileName = $(this).val();
                //replace the "Choose a file" label
                $(this).next('.custom-file-label').html(fileName);
            })
    </script>
</html>
