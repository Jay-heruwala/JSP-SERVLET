

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        String email = request.getParameter("login-email");
        String password = request.getParameter("login-password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Error : " + e.getMessage());
        }

        try {
            String URL = "jdbc:mysql://localhost:3306/Programs";
            String user = "root";
            String databasePassword = "Root";
            Connection connection = DriverManager.getConnection(URL, user, databasePassword);
            PreparedStatement preparedStatement = connection.prepareStatement("select * from user where email = ? and password = ?");
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            int noOfRow = resultSet.getRow();

            if (noOfRow > 0) {
                if (resultSet.getString("email").equals(email) && resultSet.getString("password").equals(password)) {
                    
                    session.setAttribute("email", resultSet.getString("email"));
                    session.setAttribute("firstName", resultSet.getString("firstName"));
                    session.setAttribute("role", resultSet.getString("role"));
                    response.sendRedirect("DisplayTable");
                } else {
                    response.sendRedirect("form.jsp?loginErr=true");
                }
            } else {

                response.sendRedirect("form.jsp?loginErr=true");

            }

        } catch (SQLException e) {
            System.out.println("Error : " + e.getMessage());
        }
    }
    
    
    

}
