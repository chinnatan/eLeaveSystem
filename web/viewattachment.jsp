<%-- 
    Document   : view
    Created on : Apr 17, 2018, 7:48:21 PM
    Author     : kornc
--%>

<%@page import="model.Login"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<% Login account = (Login) session.getAttribute("Account"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View File</title>
        <link rel="icon" href="images/itkmitl.ico">
    </head>
    <body>

        <% if (account == null || account.getUsername() == null) { %>
        <% response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized"); %>
        <% } else { %>

        <%
            String leaveid = (request.getParameter("leaveid"));
            String attachid = request.getParameter("attach");
            String attachname;

            File file = null;

            try {
                request.setCharacterEncoding("UTF-8");
                Connection conn = (Connection) getServletContext().getAttribute("connection");

                String sqlString = "SELECT * FROM leavedocument WHERE leave_id = '" + leaveid + "'";
                Statement myStatement = conn.createStatement();

                ResultSet rs = myStatement.executeQuery(sqlString);
                FileInputStream filePDF;

                if (rs.next()) {
                    String getUrl = "attachment" + attachid;
                    attachname = rs.getString(getUrl + "name");
                    file = new File(rs.getString(getUrl));
                    if (file.isFile()) {
                        filePDF = new FileInputStream(file);
                    } else {
                        response.sendRedirect("attachmentfail.html");
                        return;
                    }
                } else {
                    out.println("file not found!");
                    return;
                }

                response.setContentType("application/pdf;");
                response.setCharacterEncoding("UTF-8");
                response.setHeader("Content-Disposition", "inline; filename=" + attachname);
                response.setContentLengthLong(file.length());

                int len;
                OutputStream output = response.getOutputStream();
                while ((len = filePDF.read()) != -1) {
                    output.write(len);
                }

                output.flush();
                output.close();
                filePDF.close();

            } catch (SQLException ex) {
                Logger.getLogger(Logger.class.getName()).log(Level.SEVERE, null, ex);
            }
        %>

        <% }%>
    </body>
</html>
