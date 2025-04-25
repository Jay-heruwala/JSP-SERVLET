<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management Application</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <script>
        function validateForm() {
            let firstName = document.forms["userForm"]["firstName"].value;
            let lastName = document.forms["userForm"]["lastName"].value;
            let email = document.forms["userForm"]["email"].value;
            let mobileNumber = document.forms["userForm"]["mobileNumber"].value;
            let address = document.forms["userForm"]["address"].value;
            let role = document.forms["userForm"]["role"].value;
            let password = document.forms["userForm"]["password"].value;

            if (firstName == "" || lastName == "" || email == "" || mobileNumber == "" || address == "" || role == "" || password == "") {
                console.log(firstName);
                console.log(laName);
                console.log(email);
                console.log(mobileNumber);
                console.log(address);
                console.log(role);
                console.log(password);

                alert("All fields must be filled out");
                return false;
            }
            if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                alert("Invalid email format");
                return false;
            }
            if (mobileNumber.length < 10) {
                alert("Mobile number must be at least 10 digits");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters");
                return false;
            }
            return true;
        }
    </script>
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
    <div class="container col-md-5">
        <div class="card">
            <div class="card-body">
                <%
                    User user = (User) request.getAttribute("user");
                    if (user != null) {
                %>
                    <form name="userForm" action="UserServlet" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="actionPerform" value="update" />
                <%
                    } else {
                %>
                    <form name="userForm" action="UserServlet" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="actionPerform" value="insert" />
                <%
                    }
                %>

                <caption>
                    <h2>
                        <%= user != null ? "Edit User" : "Add New User" %>
                    </h2>
                </caption>

                <%
                    if (user != null) {
                %>
                    <input type="hidden" name="email" value="<%= user.getEmail() %>" />
                <%
                    }
                %>

                <fieldset class="form-group">
                    <label>First Name</label>
                    <input type="text" value="<%= user != null ? user.getFirstName() : "" %>" class="form-control" name="firstName" required>
                </fieldset>

                <fieldset class="form-group">
                    <label>Last Name</label>
                    <input type="text" value="<%= user != null ? user.getLastName() : "" %>" class="form-control" name="lastName" required>
                </fieldset>

                <fieldset class="form-group">
                    <label>Email</label>
                    <input type="email" value="<%= user != null ? user.getEmail() : "" %>" class="form-control" name="email" <%= user != null ? "readonly" : "" %> required>
                </fieldset>

                <fieldset class="form-group">
                    <label>Mobile Number</label>
                    <input type="number" value="<%= user != null ? user.getMobileNumber() : "" %>" class="form-control" name="mobileNumber" required>
                </fieldset>

                <fieldset class="form-group">
                    <label>Address</label>
                    <input type="text" value="<%= user != null ? user.getAddress() : "" %>" class="form-control" name="address" required>
                </fieldset>

                <fieldset class="form-group">
                    <label>Role</label>
                    <input type="text" value="<%= user != null ? user.getRole() : "" %>" class="form-control" name="role" required>
                </fieldset>

                <fieldset class="form-group">
                    <label>Password</label>
                    <input type="password" value="<%= user != null ? user.getPassword() : "" %>" class="form-control" name="password" required>
                </fieldset>

                <button type="submit" class="btn btn-success">Save</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>