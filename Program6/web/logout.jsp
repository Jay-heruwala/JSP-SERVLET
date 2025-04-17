<%-- logout.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <style>
        body {background-color: #F5F5F5; font-family: Arial; margin: 0; padding: 20px;}
        .container {max-width: 500px; margin: 50px auto; padding: 20px; background: #FFFFFF; 
                   border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-align: center;}
        h2 {color: #2196F3;}
        p {color: #666;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Thank You <%= request.getAttribute("username") %></h2>
        <p>You were logged in for: ${requestScope.duration}</p>
    </div>
</body>
</html>