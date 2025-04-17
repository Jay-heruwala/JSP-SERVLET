<%-- 
    Document   : info
    Created on : 8 Apr 2025, 12:27:55 am
    Author     : jayhe
--%>

<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="Core.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Student Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .student-card {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #3498db; /* Blue accent */
        }
        .student-card h2 {
            color: #2c3e50;
            margin-top: 0;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 10px;
        }
        .student-card p {
            margin: 10px 0;
            font-size: 16px;
            color: #333;
        }
        .label {
            font-weight: bold;
            color: #2c3e50;
            display: inline-block;
            width: 120px; /* Fixed width for alignment */
        }
        .value {
            color: #555;
        }
    </style>
</head>
<body>
    <div class="student-card">
        <h2>Student Information</h2>
        <jsp:useBean id="student" class="Core.Student" scope="session" />
        <p><span class="label">Name:</span> <span class="value"><jsp:getProperty name="student" property="name" /></span></p>
        <p><span class="label">Course:</span> <span class="value"><jsp:getProperty name="student" property="course" /></span></p>
        <p><span class="label">Institute:</span> <span class="value"><jsp:getProperty name="student" property="instituteName" /></span></p>
        <p><span class="label">Address:</span> <span class="value"><jsp:getProperty name="student" property="address" /></span></p>
    </div>
</body>
</html>