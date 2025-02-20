<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Form Example</title>
    </head>
    <link rel="stylesheet" href="Assets/CSS/style.css"/>
    <script src="Assets/JavaScript/formscript.js"></script>
    <body>

        <% if(session.getAttribute("email") == null){ %>

        <div class="container">
            <div class="image-container">
                <img src="image.jpg" alt="Side Illustration">
            </div>



            <div class="form-container " id="registration-form">
                <form action="RegisterUser" method="POST" name="registration" onsubmit="return validateRegistration()">
                    <h1>User Registration Form</h1>

                    <div>
                        <label for="firstname">First Name</label>
                        <input type="text" id="firstname" value="<%= request.getParameter("firstname") != null ? request.getParameter("firstname") : ""%>" name="firstname" required>
                        <div id="firstnameError" class = "error"></div>
                    </div>

                    <div>
                        <label for="lastname">Last Name</label>
                        <input type="text" id="lastname" name="lastname" value="<%= request.getParameter("lastname") != null ? request.getParameter("lastname") : ""%>" required>
                        <div id="lastnameError" class = "error"></div>
                    </div>

                    <div>
                        <label for="email">Email</label>
                        <input type="email" id="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : ""%>" name="email" required>
                        <div id="emailError" class = "error">
                            <%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : ""%>
                        </div>
                    </div>

                    <div>
                        <label for="mobileno">Mobile No</label>
                        <input type="tel" id="mobileno" name="mobileno" pattern="[0-9]{10}" required value="<%= request.getParameter("mobileno") != null ? request.getParameter("mobileno") : ""%>">
                        <div id="mobilenoError" class = "error"></div>
                    </div>

                    <div>
                        <label for="role">Select Role</label>
                        <select id="role" name="role" required > 
                            <option value="" >--Select Role--</option>
                            <option value="admin" <%= "admin".equals(request.getParameter("role")) ? "selected" : ""%> >Admin</option>
                            <option value="user" <%= "user".equals(request.getParameter("role")) ? "selected" : ""%>>User</option>
                            <option value="guest" <%= "guest".equals(request.getParameter("role")) ? "selected" : ""%>>Guest</option>
                        </select>
                        <div id="roleError" class = "error"></div>
                    </div>

                    <div>
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required  value = "<%= request.getParameter("address") != null ? request.getParameter("address") : ""%>">
                        <div id="addressError" class = "error"></div>
                    </div>

                    <div>
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                        <div id="passwordError" class = "error"></div>
                    </div>

                    <div>
                        <label for="confirmpassword">Confirm Password</label>
                        <input type="password" id="confirmpassword" name="confirmpassword" required>
                        <div id="confirmpasswordError" class = "error"></div>
                    </div>

                        <% if(request.getAttribute("errorInfoSeverSide") != null) { %>
                        <div class="error"><%= request.getAttribute("errorInfoSeverSide") %></div>
                        <% } %>
                    <div>
                        <button type="submit">Submit</button>
                    </div>
                    <div class="form-link">
                        <a onclick="switchForm('login-form')">Already have an account? Login</a>
                    </div>
                </form>
            </div>

            <div class="form-container active" id="login-form" >
                <form action="LoginServlet"name="LoginForm" method="POST" onsubmit="return LoginValidation()">
                    <h1>Login Form</h1>
                    <div>
                        <label for="login-email">Email</label>
                        <input type="email" id="login-email" name="login-email" required>
                        <div id="login-emilError" class = "error"></div>
                    </div>

                    <div>
                        <label for="login-password">Password</label>
                        <input type="password" id="login-password" name="login-password" required>
                        <div id="login-passwordError" class = "error"></div>
                    </div>

                    <%
                        if ("true".equals(request.getParameter("loginErr"))) {
                    %>
                    <div class="error">
                        Invalid Email ID And Password
                    </div>
                    <%
                        }
                    %>

                    <div>
                        <button type="submit">Login</button>
                    </div>
                    <div class="form-link">
                        <a onclick="switchForm('registration-form')">Don't have an account? Register</a>
                    </div>
                </form>
            </div>
        </div>
                    
                    <% } else {%>
                    <script> 
                      window.location.href = "DisplayTable";
                    </script>
                    <% } %>


        <%
            if (request.getAttribute("emailError") != null || request.getAttribute("errorInfoSeverSide") != null) {
        %>

        <script>
            // Call the JavaScript function when emailError is not null
            document.getElementById("login-form").classList.remove('active');
            document.getElementById("registration-form").classList.add('active');
        </script>
        <%
            }
        %>

    </body>
    <script src="formscript.js"></script>

</html>
