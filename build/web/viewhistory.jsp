<%-- 
    Document   : viewhistory
    Created on : Apr 20, 2018, 2:46:41 PM
    Author     : kornc
--%>

<%@page import="model.Login"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="model.LeaveInformation"%>
<jsp:useBean id="AccountInformation" scope="session" class="model.AccountInformation"/>
<jsp:useBean id="Account" scope="session" class="model.Login"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib  uri = "http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Login account = (Login) session.getAttribute("Account"); %>

<%
    if(account == null || account.getUsername() == null) {
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
    } else {
%>


<% String leaveID = request.getParameter("leaveid");%>

<%
    Connection conn = (Connection) getServletContext().getAttribute("connection");
    Statement stmt = conn.createStatement();
    String sqlCheck = "select * from leavedocument "
            + "join leavedocument_section "
            + "on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id) "
            + "join person "
            + "on (leavedocument.student_p_person_id = person.person_id) "
            + "join student "
            + "on (person.person_id = student.p_person_id) "
            + "join section_student "
            + "on (section_student.section_student_id = student.section_student_section_student_id)"
            + "where leave_id = '" + leaveID + "'";
    ResultSet rs = stmt.executeQuery(sqlCheck);
    if (rs.next()) {
        LeaveInformation leaveInf = new LeaveInformation();
        leaveInf.setCategory(rs.getString("category"));
        leaveInf.setDateDocument(rs.getDate("leave_date"));
        leaveInf.setFirstname(rs.getString("firstname"));
        leaveInf.setLastname(rs.getString("lastname"));
        leaveInf.setStudentId(rs.getString("student_id"));
        leaveInf.setStudentYear(rs.getString("student_year"));
        leaveInf.setStudentTerm(rs.getString("student_term"));
        leaveInf.setStudentDegree(rs.getString("student_degree"));
        leaveInf.setStudentBranch(rs.getString("student_branch"));
        leaveInf.setStudentGeneration(rs.getString("generation_id"));
        leaveInf.setStudentDescription(rs.getString("leave_description"));
        leaveInf.setLeaveType(rs.getString("type_of_leave"));
        leaveInf.setStudentDateFrom(rs.getDate("start_leave_date"));
        leaveInf.setStudentDateTo(rs.getDate("end_leave_date"));
        leaveInf.setStudentDateTotal(rs.getString("total_time"));
        leaveInf.setStudentAttachment1(rs.getString("attachment1"));
        leaveInf.setStudentAttachment2(rs.getString("attachment2"));
        leaveInf.setStudentAttachment3(rs.getString("attachment3"));
        leaveInf.setLeaveYear(rs.getString("year"));

        session.setAttribute("ViewLeaveDoc", leaveInf);
    }
%>

<jsp:useBean id="ViewLeaveDoc" scope="session" class="model.LeaveInformation"/>
<!-- Leavedocument Description -->
<div class="modal fade" id="leavedescriptionModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">รายละเอียดการลา</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-6">
                                <h4>ข้อมูลการลา</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <p>เลขที่ใบลา : <%= leaveID%></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <fmt:setLocale value="th"/>
                                <p>วันที่ยื่นขอลา : <fmt:formatDate pattern = "dd/MM/yyyy" value = "${ViewLeaveDoc.dateDocument}" /></p>
                            </div>
                            <div class="col-md-6">
                                <p>ประเภทการลา : ${ViewLeaveDoc.leaveType}/${ViewLeaveDoc.category}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <p>ชื่อ : ${ViewLeaveDoc.firstname}</p>
                            </div>
                            <div class="col-md-6">
                                <p>นามสกุล : ${ViewLeaveDoc.lastname}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <p>ชั้นปี : ${ViewLeaveDoc.studentYear}</p>
                            </div>
                            <div class="col-md-6">
                                <p>ภาคเรียนที่ : ${ViewLeaveDoc.studentTerm}/${ViewLeaveDoc.leaveYear}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <p>ระดับการศึกษา : ${ViewLeaveDoc.studentDegree}</p>
                            </div>
                            <div class="col-md-6">
                                <p>สาขาวิชา : ${ViewLeaveDoc.studentBranch}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <h4>ความประสงค์ขอลาเรียนตั้งแต่ <fmt:formatDate pattern = "dd/MM/yyyy" value = "${ViewLeaveDoc.studentDateFrom}" /> ถึง 
                                    <fmt:formatDate pattern = "dd/MM/yyyy" value = "${ViewLeaveDoc.studentDateTo}" /> เนื่องจาก</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <p>${ViewLeaveDoc.studentDescription}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <c:if test = "${ViewLeaveDoc.studentAttachment1.length() <= 0 && ViewLeaveDoc.studentAttachment2.length() <= 0 && ViewLeaveDoc.studentAttachment3.length() <= 0}">
                                    <h4>เอกสารการลา - ไม่ได้แนบเอกสาร</h4>
                                </c:if>
                                <c:if test = "${ViewLeaveDoc.studentAttachment1.length() > 0 || ViewLeaveDoc.studentAttachment2.length() > 0 || ViewLeaveDoc.studentAttachment3.length() > 0}">
                                    <h4>เอกสารการลา</h4>
                                </c:if>
                            </div>
                        </div>
                        <div class="row">
                            <% int count = 0; %>
                            <c:if test = "${ViewLeaveDoc.studentAttachment1.length() > 0}">
                                <div class="col-md-4">
                                    <% count++;%>
                                    <p><%= count%> : <a href="viewattachment.jsp?leaveid=<%= leaveID%>&attach=1" class="text-success" target="_blank">คลิก</a></p>
                                </div>
                            </c:if>
                            <c:if test = "${ViewLeaveDoc.studentAttachment2.length() > 0}">
                                <div class="col-md-4">
                                    <% count++;%>
                                    <p><%= count%> : <a href="viewattachment.jsp?leaveid=<%= leaveID%>&attach=2" class="text-success" target="_blank">คลิก</a></p>
                                </div>
                            </c:if>
                            <c:if test = "${ViewLeaveDoc.studentAttachment3.length() > 0}">
                                <div class="col-md-4">
                                    <% count++;%>
                                    <p><%= count%> : <a href="viewattachment.jsp?leaveid=<%= leaveID%>&attach=3" class="text-success" target="_blank">คลิก</a></p>
                                </div>
                            </c:if>
                        </div>
                        <c:if test="${(Account.person_type == 'student') || (Account.person_type == 'professor')}">
                            <div class="row">
                                <div class="col-md-12">
                                    <h4>วิชาที่ขอลา</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
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
                                                        สถานะ
                                                    </th>
                                                    <th scope="col">
                                                        วันที่อนุมัติ
                                                    </th>
                                                    <th scope="col">
                                                        หมายเหตุ
                                                    </th>
                                                    <th scope="col">

                                                    </th>
                                                </tr>
                                            </thead>

                                            <!--Query Leavedocument with Student-->
                                            <% if(account.getPerson_type().equals("student")) { %>
                                            <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                                select * 
                                                from leavedocument 
                                                join leavedocument_section
                                                on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                                join class
                                                on (class.class_id = leavedocument_section.subjectleave_id)
                                                join section
                                                on (section.section_id = leavedocument_section.section_section_id)
                                                where student_p_person_id = '${Account.username}'
                                                and leavedocument_leave_id = '<%= leaveID%>'
                                                order by leave_id desc
                                            </sql:query>
                                            <% } else if (account.getPerson_type().equals("professor")) {%>
                                            <sql:query var="leavedocumentSql" dataSource="webpro02test">
                                                select * from professor
                                                join section_student
                                                using (p_person_id)
                                                join student
                                                on (student.section_student_section_student_id = section_student.section_student_id)
                                                join person
                                                on (person.person_id = student.p_person_id)
                                                join leavedocument
                                                on (leavedocument.student_p_person_id = student.p_person_id)
                                                join leavedocument_section
                                                on (leavedocument.leave_id = leavedocument_section.leavedocument_leave_id)
                                                join section
                                                on (leavedocument_section.section_section_id = section.section_id)
                                                join class
                                                on (class.class_id = leavedocument_section.subjectleave_id)
                                                where professor.p_person_id = '${Account.username}'
                                                and leavedocument_leave_id = '<%= leaveID%>'
                                                order by leave_id desc
                                            </sql:query>
                                            <% } %>
                                            <tbody>
                                                <c:forEach var="rowLeavedocument" items="${leavedocumentSql.rows}">
                                                    <tr>
                                                        <th scope="row">
                                                            ${rowLeavedocument.class_id}
                                                        </th>
                                                        <td scope="row">
                                                            ${rowLeavedocument.class_name} (${rowLeavedocument.section_name})
                                                        </td>
                                                        <td scope="row">
                                                            <c:if test="${rowLeavedocument.status == 'รอการอนุมัติ'}">
                                                                ${rowLeavedocument.status}
                                                            </c:if>
                                                            <c:if test="${rowLeavedocument.status == 'อนุมัติ'}">
                                                                <p class="text-success">${rowLeavedocument.status}</p>
                                                            </c:if>
                                                            <c:if test="${rowLeavedocument.status == 'ไม่อนุมัติ'}">
                                                                <p class="text-danger">${rowLeavedocument.status}</p>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <div class="col-md-12">
                                                                <c:set var = "current" value = "${rowLeavedocument.date}" />
                                                                <fmt:setLocale value="th"/>
                                                                <fmt:formatDate pattern = "dd/MM/yyyy" value = "${current}" />
                                                            </div>
                                                        </td>
                                                        <td>
                                                            ${rowLeavedocument.note}
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <% } %>
