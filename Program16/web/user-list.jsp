<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@page import="dao.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management Application</title>
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
    <br>
    <div class="container">
        <h3 class="text-center">List of Users</h3>
        <hr>
        <div class="container text-left">
            <a href="user-form.jsp" class="btn btn-success">Add New User</a>
        </div>
        <br>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Mobile Number</th>
                    <th>Address</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    UserDAO userDAO = new UserDAO();
                    List<User> listUser = (List<User>) userDAO.selectAllUsers() ;
                    if (listUser != null) {
                        for (User user : listUser) {
                %>
                    <tr>
                        <td><%= user.getFirstName() %></td>
                        <td><%= user.getLastName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getMobileNumber() %></td>
                        <td><%= user.getAddress() %></td>
                        <td><%= user.getRole() %></td>
                        <td>
                            <a href="UserServlet?actionPerform=edit&email=<%= java.net.URLEncoder.encode(user.getEmail(), "UTF-8") %>">Edit</a>
                                
                            <a href="UserServlet?actionPerform=delete&email=<%= java.net.URLEncoder.encode(user.getEmail(), "UTF-8") %>">Delete</a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>