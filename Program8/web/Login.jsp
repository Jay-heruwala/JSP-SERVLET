<%-- 
    Document   : Login.jsp
    Created on : 12 Apr 2025, 6:45:46 pm
    Author     : jayhe
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function validateForm() {
            var username = document.forms["loginForm"]["username"].value;
            var password = document.forms["loginForm"]["password"].value;
            var error = document.getElementById("error");

            // Reset error message
            error.innerHTML = "";

            // Username validation
            if (username == "") {
                error.innerHTML = "Username is required.";
                return false;
            }
            if (username.length < 3) {
                error.innerHTML = "Username must be at least 3 characters long.";
                return false;
            }

            // Password validation
            if (password == "") {
                error.innerHTML = "Password is required.";
                return false;
            }
//            if (password.length < 6) {
//                error.innerHTML = "Password must be at least 6 characters long.";
//                return false;
//            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        
        <% 
            String errorMsg = (String) request.getAttribute("error");
            if (errorMsg != null) {
                out.println("<p class='error'>" + errorMsg + "</p>");
            }
        %>
        <form name="loginForm" action="verify.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">Email Id : </label>
                <input type="text" id="username" name="username" placeholder="Enter Email Id">
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password">
            </div>
            <div id="error" class="error"></div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
