<%-- main.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hello Page</title>
    <style>
        body {background-color: #F5F5F5; font-family: Arial; margin: 0; padding: 20px;}
        .container {max-width: 600px; margin: 20px auto; padding: 20px; background: #FFFFFF; 
                   border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);}
        .header {display: flex; justify-content: space-between; align-items: center;}
        .time {color: #666; font-size: 14px;}
        h1 {color: #2196F3;}
        .info {margin: 20px 0; padding: 15px; background: #f0f8ff; border-radius: 4px;}
        .logout-btn {background: #4CAF50; color: white; padding: 10px 20px; border: none; 
                    border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block;}
        .logout-btn:hover {background: #45a049;}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <%  %>
            <h1>Hello <%= session.getAttribute("username") %></h1>
            <span class="time">
                <% 
                    Date startTime = (Date) session.getAttribute("startTime");
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
                    out.print("Started: " + sdf.format(startTime));
                %>
            </span>
        </div>
        <div class="info">
            <h3>Session Information:</h3>
            <p>Session ID: <%= session.getId() %></p>
            <p>Access Count: <%= session.getAttribute("accessCount") %></p>
        </div>
        <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>
</body>
</html>