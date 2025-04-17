<%-- welcome.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <style>
        body {background-color: #F5F5F5; font-family: Arial; margin: 0; padding: 20px;}
        .container {max-width: 500px; margin: 50px auto; padding: 20px; background: #FFFFFF; 
                   border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);}
        input[type=text] {width: 100%; padding: 8px; margin: 10px 0; border: 1px solid #ddd; 
                         border-radius: 4px; box-sizing: border-box;}
        input[type=submit] {background: #4CAF50; color: white; padding: 10px 20px; border: none; 
                           border-radius: 4px; cursor: pointer;}
        input[type=submit]:hover {background: #45a049;}
        h2 {color: #2196F3; text-align: center;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome</h2>
        <form method="post" action="MainServlet">
            Enter your name: <input type="text" name="username" required>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>