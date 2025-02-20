
import com.models.User;
import com.mysql.cj.Session;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import jakarta.servlet.http.HttpSession;

public class DisplayTable extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<User> userList = new ArrayList<>();

        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("email") != null) {

            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                System.out.println("Error : " + e.getMessage());
            }

            try {
                String firstName, lastName, email, address, role;
                long mobileNo;
                String URL = "jdbc:mysql://localhost:3306/Programs";
                String user = "root";
                String databasePassword = "Root";
                Connection connection = DriverManager.getConnection(URL, user, databasePassword);
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("select * from user");
                while (resultSet.next()) {
                    firstName = resultSet.getString("firstName");
                    lastName = resultSet.getString("lastName");
                    email = resultSet.getString("email");
                    mobileNo = resultSet.getLong("mobilenumber");
                    address = resultSet.getString("address");
                    role = resultSet.getString("role");

                    userList.add(new User(firstName, lastName, email, mobileNo, address, role));

                }
                request.setAttribute("userList", userList);

            } catch (SQLException e) {
                System.out.println("Error : " + e.getMessage());
            }
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            response.sendRedirect("form.jsp");
        }
    }

}
