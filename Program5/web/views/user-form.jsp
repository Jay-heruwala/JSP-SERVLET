<!-- user-management/src/main/webapp/views/user-form.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Role" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>User Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/styles.css" rel="stylesheet">
    <script src="../js/validation.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="mt-5"><%= (request.getAttribute("user") == null) ? "Add New User" : "Edit User" %></h1>
        <%
            List<String> errors = (List<String>) request.getAttribute("errors");
            if (errors != null && !errors.isEmpty()) {
        %>
            <div class="alert alert-danger">
                <ul>
                    <% for (String error : errors) { %>
                        <li><%= error %></li>
                    <% } %>
                </ul>
            </div>
        <%
            }
        %>
        <form id="userForm" action="UserServlet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="<%= (request.getAttribute("user") == null) ? "insert" : "update" %>">
            <%
                User user = (User) request.getAttribute("user");
                int userId = (user != null) ? user.getUserId() : 0;
                String name = (user != null && user.getName() != null) ? user.getName() : "";
                String address = (user != null && user.getAddress() != null) ? user.getAddress() : "";
                String emailId = (user != null && user.getEmailId() != null) ? user.getEmailId() : "";
                String mobileNo = (user != null && user.getMobileNo() != null) ? user.getMobileNo() : "";
                String password = (user != null && user.getPassword() != null) ? user.getPassword() : "";
            %>
            <input type="hidden" name="userId" value="<%= userId %>">
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= name %>">
                <div class="invalid-feedback">Name is required.</div>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" id="address" name="address" value="<%= address %>">
                <div class="invalid-feedback">Address must not exceed 255 characters.</div>
            </div>
            <div class="mb-3">
                <label for="emailId" class="form-label">Email</label>
                <input type="email" class="form-control" id="emailId" name="emailId" value="<%= emailId %>">
                <div class="invalid-feedback">Valid email is required.</div>
            </div>
            <div class="mb-3">
                <label for="mobileNo" class="form-label">Mobile Number</label>
                <input type="text" class="form-control" id="mobileNo" name="mobileNo" value="<%= mobileNo %>">
                <div class="invalid-feedback">Mobile number must be 10-15 digits.</div>
            </div>
            <div class="mb-3">
                <label for="roleId" class="form-label">Role</label>
                <select class="form-control" id="roleId" name="roleId">
                    <option value="">Select Role</option>
                    <%
                        List<Role> roleList = (List<Role>) request.getAttribute("roleList");
                        int selectedRoleId = (user != null) ? user.getRoleId() : 0;
                        if (roleList != null) {
                            for (Role role : roleList) {
                                String selected = (role.getRoleId() == selectedRoleId) ? "selected" : "";
                    %>
                        <option value="<%= role.getRoleId() %>" <%= selected %>><%= role.getRoleName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
                <div class="invalid-feedback">Role is required.</div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" value="<%= password %>">
                <div class="invalid-feedback">Password must be 6-50 characters.</div>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="users" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>