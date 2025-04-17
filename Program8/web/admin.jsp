<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    
    <%
        if(!"admin".equalsIgnoreCase((String)session.getAttribute("role"))){
        request.setAttribute("error", "Invalid credential");
    %>
        <jsp:forward page="error.jsp" />
    <%
        }
    
    %>
    
    
    <div class="container">
        <h2>Admin Dashboard</h2>
        <!-- JSP Expression -->
        <p>Welcome, <%= session.getAttribute("username") %>!</p>
        <p>You have administrative privileges.</p>
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>