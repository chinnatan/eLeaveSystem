<%-- 
    Document   : confirmmanage
    Created on : Apr 21, 2018, 8:57:25 PM
    Author     : kornc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String flag = request.getParameter("flag"); %>
<% String leaveid = request.getParameter("leaveid");%>
<% String classid = request.getParameter("classid"); %>
<% String section = request.getParameter("section"); %>

<div class="modal fade" id="manageModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">หมายเหตุ</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="manage.do" method="post">
                    <input type="hidden" name="flag" id="flag" value="<%= flag%>"/>
                    <input type="hidden" name="leaveid" id="leaveid" value="<%= leaveid%>"/>
                    <input type="hidden" name="classid" id="classid" value="<%= classid%>"/>
                    <input type="hidden" name="section" id="section" value="<%= section%>"/>
                    <textarea class="form-control" rows="5" id="noteLeave" name="noteLeave"></textarea>  
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">ยืนยัน</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">ยกเลิก</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>