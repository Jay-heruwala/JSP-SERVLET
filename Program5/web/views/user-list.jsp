<!-- user-management/src/main/webapp/views/user-list.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>User List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/styles.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Users</h1>
        <a href="UserServlet?action=new" class="btn btn-success mb-3">Add New User</a>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<User> userList = (List<User>) request.getAttribute("userList");
                    if (userList != null) {
                        for (User user : userList) {
                %>
                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getAddress() != null ? user.getAddress() : "" %></td>
                        <td><%= user.getEmailId() %></td>
                        <td><%= user.getMobileNo() %></td>
                        <td><%= user.getRoleName() %></td>
                        <td>
                            <a href="UserServlet?action=edit&userId=<%= user.getUserId() %>" class="btn btn-primary btn-sm">Edit</a>
                            <a href="UserServlet?action=delete&userId=<%= user.getUserId() %>" class="btn btn-danger btn-sm" 
                               onclick="return confirm('Are you sure?')">Delete</a>
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
</body>
</html>