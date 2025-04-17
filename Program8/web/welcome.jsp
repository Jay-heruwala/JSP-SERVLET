<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    <% if(!"user".equalsIgnoreCase((String)session.getAttribute("role"))){
    request.setAttribute("error", "Invalid credential");
    %>
    <jsp:forward page="error.jsp" />
    <%
        } %>
    
    <div class="container">
        <h2>Welcome</h2>
        <!-- JSP Expression -->
        <p>Hello, <%= session.getAttribute("username") %>!</p>
        <p>This is your user dashboard.</p>
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>