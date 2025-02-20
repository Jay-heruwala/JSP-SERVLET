<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Details</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                background-color: #f0f4f8;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .card {
                position: relative;
                width: 100%;
                max-width: 600px;
                background: #ffffff;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
                transition: transform 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
            }

            .role-badge {
                position: absolute;
                top: 20px;
                right: 20px;
                background: #10b981;
                color: #ffffff;
                padding: 8px 20px;
                border-radius: 20px;
                font-size: 14px;
                text-transform: uppercase;
                font-weight: bold;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                font-size: 32px;
                color: #111827;
            }

            .user-info {
                display: grid;
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .user-info label {
                display: flex;
                flex-direction: column;
                font-weight: bold;
                color: #374151;
                font-size: 16px;
            }

            .user-info input {
                margin-top: 8px;
                padding: 12px;
                border: 1px solid #d1d5db;
                border-radius: 10px;
                background-color: #f9fafb;
                transition: border-color 0.3s ease;
                font-size: 16px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .user-info input:focus {
                border-color: #3b82f6;
                outline: none;
                background-color: #ffffff;
            }

            .button-group {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            .btn {
                padding: 14px 30px;
                border: none;
                border-radius: 10px;
                color: #ffffff;
                cursor: pointer;
                font-size: 18px;
                transition: background-color 0.3s ease;
            }

            .btn-delete {
                background-color: blue;
            }

            .btn-delete:hover {
                background-color: blue;
            }
            
            .error{
                color: red;
                padding: 5px 2px;
                font-size: 14px;
            }
        </style>
        <script src="Assets/JavaScript/formscript.js"></script>
    </head>
    <body>
        <% if (session.getAttribute("email") != null && session != null) { %>
        <div class="card">
            <div class="role-badge" id="role">Admin</div>
            <h2>User Details</h2>
            <form name="UpdateUser" action="" method="POST" onsubmit="return validateRegistration()">
                <div class="user-info">
                    <label>First Name:<input type="text" id="firstname" name="firstname" value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>"></label>
                    <label>Last Name:<input type="text" id="lastname" name="lastname" value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>"></label>
                    <label>Email:<input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"></label>
                    <label>Mobile Number:<input type="text" id="mobilenumber" name="mobilenumber" value="<%= request.getAttribute("mobilenumber") != null ? request.getAttribute("mobilenumber") : "" %>"></label>
                    <label>Address:<input type="text" id="address" name="address" value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>"></label>
                    <label>Password:<input type="password" id="password" name="password" value=""></label>
                </div>
                    <% if(request.getAttribute("errorInfoSeverSide") != null) { %>
                    <div class="error"> <%= request.getAttribute("errorInfoSeverSide")  %></div>
                    <% } %>
                    
                <div class="button-group">
                    <button type="submit" class="btn btn-delete" >Update</button>
                </div>
            </form>
        </div>
        <% } %>

        <script>
            

            function validateRegistration() {
                const firstname = document.getElementById('firstname').value.trim();
                const lastname = document.getElementById('lastname').value.trim();
                const email = document.getElementById('email').value.trim();
                const mobilenumber = document.getElementById('mobilenumber').value.trim();
                const address = document.getElementById('address').value.trim();
                const password = document.getElementById('password').value.trim();

                if (!firstname || !lastname || !email || !mobilenumber || !address || !password) {
                    alert('Please fill in all fields.');
                    return false;
                }

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('Please enter a valid email address.');
                    return false;
                }

                const phoneRegex = /^[0-9]{10}$/;
                if (!phoneRegex.test(mobilenumber)) {
                    alert('Please enter a valid 10-digit mobile number.');
                    return false;
                }

                if (password.length < 6) {
                    alert('Password must be at least 6 characters long.');
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>
