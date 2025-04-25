<%-- 
    Document   : user
    Created on : April 19, 2025
    Author     : Grok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dao.UserDAO, model.User"%>

<%!
    // Function to fetch all users
    public List<User> getAllUsers() {
        try {
            UserDAO userDAO = new UserDAO();
            return userDAO.getAllUsers();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
%>

<%
    if (session == null || session.getAttribute("LogedAdminInfo") == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }

    List<User> users = getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Management</title>
        <link rel="stylesheet" href="css/content-table.css"/>
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    </head>
    <body>

        <div class="container">
            <div class="content-table">
                <div class="table-header">
                    <h3>User Management</h3>
                    <div>
<!--                        <button class="action-button">
                            <a href="pages/addUser.jsp">
                                <i class="fas fa-plus"></i> Add New User
                            </a>
                        </button>-->
                    </div>
                </div>
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Contact Number</th>
                                <th>Email</th>
                                <!--<th>Actions</th>-->
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (users.size() > 0) {
                                    for (User user : users) {
                            %>
                            <tr>
                                <td><%= user.getUser_id()%></td>
                                <td><%= user.getName()%></td>
                                <td><%= user.getContact_number()%></td>
                                <td><%= user.getEmail()%></td>
                                
<!--                                <td class="action-icons">
                                    <i class="fas fa-edit" title="Edit"></i>
                                    <i class="fas fa-trash" title="Delete"></i>
                                </td>-->
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="4" style="text-align: center;">
                                    No Users Found <a href="index.jsp">Go to Home page</a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>