<%-- 
    Document   : verify
    Created on : 12 Apr 2025, 6:55:58 pm
    Author     : jayhe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/programs", "root", "Root");
        PreparedStatement statement = connection.prepareStatement("select * from users where email_id = ? and password = ?");
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet resultSet = statement.executeQuery();
        out.print("1");

        if (resultSet.next()) {
            int role = resultSet.getInt("role_id");
            PreparedStatement fetchRole = connection.prepareStatement("select * from role where role_id = ?");
            fetchRole.setInt(1, role);
            ResultSet roleInfo = fetchRole.executeQuery();
            if (roleInfo.next()) {
                out.print("2");
                String roleName = roleInfo.getString("role_name");
                session.setAttribute("username", username);
                session.setAttribute("role", roleName);

                if ("admin".equalsIgnoreCase(roleName)) {
        %>
                    <jsp:forward page="admin.jsp"/>
        <%
                } else if ("user".equalsIgnoreCase(roleName)) {
        %>
                    <jsp:forward page="welcome.jsp"/>
        <%
                }

                } else {
        %>
                    <jsp:forward page="login.jsp"/>
        <% 
                }
        } else {
            request.setAttribute("error", "Error: Invalid Email id and password ");
%>
            <jsp:forward page="Login.jsp"/>
  <%
            }

    } catch (ClassNotFoundException e) {
        request.setAttribute("error", "Database error: " + e.getMessage());
    } catch (SQLException e) {
        request.setAttribute("error", "Error: " + e.getMessage());
    }
    


%>
%>
<jsp:forward page="error.jsp" />

