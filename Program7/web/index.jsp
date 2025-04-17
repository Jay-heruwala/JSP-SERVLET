<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="header.jsp" %>
<%--<%@page import="Core.Student" %>--%>


<%!
    public String welcomeMessage() {
        return "Welcome to the JSP Demo!";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .student-form {
                max-width: 400px;
                margin: 20px auto;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: #333;
            }
            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                box-sizing: border-box;
            }
            input[type="text"]:focus, input[type="number"]:focus {
                border-color: #3498db;
                outline: none;
                box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
            }
            button {
                background-color: #2c3e50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            button:hover {
                background-color: #3498db;
            }
        </style>
    </head>
    <body>
        <h2><%= welcomeMessage()%></h2>

        <%
            String name = request.getParameter("name");
            String course = request.getParameter("course");
            String instituteName = request.getParameter("instituteName");
            String address = request.getParameter("address");

            if (name != null && course != null) {

        %>

        <jsp:useBean id="student" class="Core.Student" scope="session" />
        <jsp:setProperty name="student" property="name" value="<%= name%>" />
        <jsp:setProperty name="student" property="course" value="<%= course%>" />
        <jsp:setProperty name="student" property="instituteName" value="<%= instituteName%>" />
        <jsp:setProperty name="student" property="address"  value="<%= address%>" />

        <jsp:forward page="info.jsp" />


        <%
            }
        %>

        <form action="index.jsp" method="post">
            Name : <input type="text" name="name"><br>
            Course : <input type="text" name="course"><br>
            Institute Name : <input type="text" name="instituteName"><br>
            Address : <input type="text" name="address"><br>
            <input type="submit" value="Submit">
        </form>

    </body>
</html>
