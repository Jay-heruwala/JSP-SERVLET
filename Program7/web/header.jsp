<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        header {
            background-color: #2c3e50; /* Dark blue background */
            padding: 15px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        nav ul li {
            margin-left: 20px;
        }
        nav ul li a {
            color: #ecf0f1; /* Light color for links */
            text-decoration: none;
            font-size: 16px;
        }
        nav ul li a:hover {
            color: #3498db; /* Blue hover effect */
        }
        .user-info {
            font-size: 14px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <!-- Placeholder for a logo image -->
            <span>Student Portal</span>
        </div>
        <nav>
            <ul>
                <li><a href="welcome.jsp">Home</a></li>
                <li><a href="#">Profile</a></li>
                <li><a href="#">Courses</a></li>
                <li><a href="#">Logout</a></li>
            </ul>
        </nav>
        <div class="user-info">
            <% 
                // Using implicit object 'session' to simulate logged-in user
                String username = (String) session.getAttribute("username");
                if (username == null) {
                    username = "Guest";
                }
                out.print("Welcome, " + username + " | " + new java.util.Date().toString());
            %>
        </div>
    </header>
</body>
</html>