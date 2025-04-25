<!-- user-management/src/main/webapp/views/error.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Error</h1>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
        <a href="UserServlet" class="btn btn-primary">Back to User List</a>
    </div>
</body>
</html>