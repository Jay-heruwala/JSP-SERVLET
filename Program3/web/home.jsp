<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@page import="com.models.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Table</title>
        <script>
            function confirmDelete(userId) {
                if (confirm("Are you sure you want to delete this user?")) {
                    // Redirect to the servlet with the user ID as a query parameter
                    window.location.href = 'DeleteUser?id=' + encodeURIComponent(userId);
                }
            }
            
            function confirmUpdate(userId){
                if(confirm("Are you sure you want to update this user?")){
                    window.location.href = 'UpdateUser?id=' + encodeURIComponent(userId);
                }
            }
        </script>
    </head>
    <link rel="stylesheet" href="Assets/CSS/home.css"/>
    <body>

        <header>
            <div class="logo">LOGO</div>
            <div class="user-info">

                <% if (session.getAttribute("firstName") != null && session != null) {%>

                <span><%= session.getAttribute("firstName") != null ? session.getAttribute("firstName") : "John"%></span>
                <button class="logout-button"   > 
                    <a href="Logout">Logout</a>
                </button> 

                <% } else { %>
                <button class="logout-button"   > 

                    <a href="form.jsp">Login</a>
                </button> 
                <% } %>
            </div>
        </header>

        <%
            if (request.getAttribute("userList") != null) {
                List<User> userList = (List<User>) request.getAttribute("userList");
        %>



        <div style="overflow-x: auto;">
            <table>
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
                        for (User user : userList) {
                    %>
                    <tr>
                        <td data-label="First Name"><%= user.getFirstName()%></td>
                        <td data-label="Last Name"><%= user.getLastName()%></td>
                        <td data-label="Email"><%= user.getEmail()%></td>
                        <td data-label="Mobile Number"><%= user.getMobileno()%></td>
                        <td data-label="Address"><%= user.getAddress()%></td>
                        <td data-label="Role"><%= user.getRole()%></td>
                        <td data-label="Actions" class="action-buttons">
                            <button class="update-button" onclick="confirmUpdate('<%= user.getEmail() %>')" >Update</button>
                            <button class="delete-button" onclick="confirmDelete('<%= user.getEmail()%>')">Delete</button>
                        </td>
                    </tr>
                    <%
                        }
                    %>


                </tbody>
            </table>
        </div>
        <%
        } else {
        %>
        <div>Users are Not Available</div>
        <%
            }
        %>





    </body>
</html>