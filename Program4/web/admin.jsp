<%-- 
    Document   : admin
    Created on : 11 Apr 2025, 1:50:12 am
    Author     : jayhe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% if ("admin".equals(session.getAttribute("role"))) {
        %>
        <h1>Admin page</h1>
        <% } else {
        %>
        <h1>Invalid Access</h1>
        <%
            }
        %>
    </body>
</html>
