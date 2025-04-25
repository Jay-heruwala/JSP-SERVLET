<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page  import="java.util.*" %>
<html>
<head>
    <title>Message Board</title>
</head>
<body>
    <h1>Message Board</h1>

    <form action="MessageBoardServlet" method="post">
        Name: <input type="text" name="name" required><br><br>
        Message:<br>
        <textarea name="message" rows="4" cols="50" required></textarea><br><br>
        <input type="submit" value="Post Message">
    </form>

    <hr>

    <h2>Messages:</h2>
    <ul>
        <%
            List<String> messages = (List<String>) request.getAttribute("messages");
            if (messages != null) {
                for (String msg : messages) {
        %>
                    <li><%= msg %></li>
        <%
                }
            }
        %>
    </ul>
</body>
</html>