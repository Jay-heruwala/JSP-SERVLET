<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
            <div>
                <a href="#" class="navbar-brand">User Management App</a>
            </div>
        </nav>
    </header>
    <div class="container">
        <h3 class="text-center">Error</h3>
        <hr>
        <div class="alert alert-danger">
            <h4>An error occurred!</h4>
            <p><%= exception.getMessage() %></p>
        </div>
        <a href="list" class="btn btn-primary">Back to User List</a>
    </div>
</body>
</html>