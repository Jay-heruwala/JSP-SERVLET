<%-- 
    Document   : home
    Created on : 27 Feb 2025, 10:35:33 am
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
        <h1>Hello World!</h1>
        
        <% if(request.getAttribute("error") == null) {  %>
        
        <h1><%= request.getAttribute("name") %> </h1>
        <h1><%= request.getAttribute("age") %> </h1>
        
        <% } else {  %>
         <h1><%= request.getAttribute("error") %> </h1>
         <% } %>
    </body>
</html>
