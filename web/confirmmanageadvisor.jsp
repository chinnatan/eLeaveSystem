<%-- 
    Document   : confirmmanageadvisor
    Created on : Apr 27, 2018, 10:28:04 AM
    Author     : kornc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String flag = request.getParameter("flag"); %>
<% String leaveid = request.getParameter("leaveid");%>

<div class="modal fade" id="manageModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">แจ้งเตือน</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>ต้องการยืนยันหรือไม่</p>
                <form action="manageadvisor.do" method="post">
                    <input type="hidden" name="flag" id="flag" value="<%= flag%>"/>
                    <input type="hidden" name="leaveid" id="leaveid" value="<%= leaveid%>"/>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">ยืนยัน</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">ยกเลิก</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>