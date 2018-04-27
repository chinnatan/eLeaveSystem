<%-- 
    Document   : selection
    Created on : Apr 2, 2018, 10:16:49 AM
    Author     : kornc
--%>

<%@page import="model.Login"%>
<% Login account = (Login) session.getAttribute("Account"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta property="title" content="Korn Chinnatan"/>
        <meta property="description" content="I’m 19 year-old. graduated from Prommanusorn Phetchaburi School.now studying in information technology at King Mongkut’s Institute of Technology Ladkrabang.interested in web development and programming."/>
        <meta name="keywords" content="Korn,Chinnatan,Chatthong,KMITL,IT,eLeave,System,eLeave System"/>
        <meta charset="utf-8">
        <title>ระบบลาเรียนออนไลน์, คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง, Information Technology - KMITL</title>
        <link href="https://fonts.googleapis.com/css?family=Kanit" rel="stylesheet">
        <link rel="icon" href="images/itkmitl.ico">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script>window.jQuery || document.write('<script src="js/jquery-slim.min.js"><\/script>')</script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>


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

        <%
            if (account == null) {
        %>
        <script type="text/javascript">
    $('#plssignin').modal('show');
        </script>
        <META HTTP-EQUIV="Refresh" CONTENT="2;URL=login.jsp">
        <%
        } else {
        %>


        <%@include file="header.jsp" %>

        <div class="container selection">
            <div class="card-deck mb-3">
                <div class="card mb-4 box-shadow">
                    <div class="card-header bg-red">
                        <h4 class="my-0 font-weight-normal text-white text-center">การลาป่วย</h4>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title pricing-card-title">หมายเหตุ</h5>
                        <ul class="list-unstyled mt-3 mb-5">
                            <ul>
                                <li>การลาป่วยในระหว่างเรียน นักศึกษาต้องยื่นใบลาในวันแรกที่กลับเข้ามาเรียน ในกรณีลาป่วยตั้งแต่ 5 วันขึ้นไป</li>
                                <li>ต้องมีใบรับรองแพทย์โดยยื่นต่ออาจารย์ประจำวิชา</li>
                            </ul>
                        </ul>

                    </div>
                    <% if (account.getPerson_type() != null) { %>
                    <% if (account.getPerson_type().equals("student")) {%>
                    <div class="card-footer">
                        <a href="form.jsp?data=stickleave"><button type="button" class="btn btn-lg btn-block btn-red">กรอกข้อมูล</button></a>
                    </div>
                    <% } %>
                    <% } %>
                </div>
                <div class="card mb-4 box-shadow">
                    <div class="card-header bg-red">
                        <h4 class="my-0 font-weight-normal text-white text-center">การลากิจ</h4>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title pricing-card-title">หมายเหตุ</h5>
                        <ul class="list-unstyled mt-3 mb-4">
                            <ul>
                                <li>นักศึกษาที่จำเป็นต้องลาระหว่างชั่วโมงเรียนต้องขออนุญาตจากอาจารย์ประจำวิชานั้น</li>
                                <li>นักศึกษาที่จะต้องลากิจตั้งแต่ 1 วันขึ้นไป ต้องยื่นใบลา <b><u>ก่อน</u></b> วันลาพร้อมด้วยเหตุผลและคำรับรองของผู้ปกครองหรืออาจารย์ที่ปรึกษาอย่างใดอย่างหนึ่ง โดยยื่นต่ออาจารย์ประจำวิชา</li>
                            </ul>
                        </ul>
                    </div>
                    <% if (account.getPerson_type() != null) { %>
                    <% if (account.getPerson_type().equals("student")) {%>
                    <div class="card-footer">
                        <a href="form.jsp?data=personalleave"><button type="button" class="btn btn-lg btn-block btn-red">กรอกข้อมูล</button></a>
                    </div>
                    <% } %>
                    <% } %>
                </div>
                <div class="card mb-4 box-shadow">
                    <div class="card-header bg-red">
                        <h4 class="my-0 font-weight-normal text-white text-center">การลาอื่นๆ</h4>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title pricing-card-title">หมายเหตุ</h5>
                        <ul class="list-unstyled mt-3 mb-4">
                            <li><b><u>การลาช่วงสอบกลางภาค</u></b> ระดับปริญญาตรีและระดับบัณฑิตศึกษา
                                <ul>
                                    <li>
                                        ถือปฏิบัติตามประกาศคณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง เรื่อง การขอเลื่อนสอบกลางภาคการศึกษา คณะเทคโนโลยีสารสนเทศ ประกาศ ณ วันที่ 7 พฤษภาคม 2558 (กรณีที่ไม่สามารถเข้าสอบกลางภาคได้ สามารถยื่นหลักฐานหรือเอกสารเพื่อขออนุมัติสอบนอกตาราง)
                                    </li>
                                </ul>
                            </li>
                            <li><b><u>การลาช่วงสอบปลายภาค</u></b> ระดับปริญญาตรีและระดับบัณฑิตศึกษา
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
                    </div>
                    <% if (account.getPerson_type() != null) { %>
                    <% if (account.getPerson_type().equals("student")) {%>
                    <div class="card-footer">
                        <a href="form.jsp?data=otherleave"><button type="button" class="btn btn-lg btn-block btn-red">กรอกข้อมูล</button></a>
                    </div>
                    <% } %>
                    <% } %>
                </div>
            </div>

            <% }%>
    </body>
</html>
