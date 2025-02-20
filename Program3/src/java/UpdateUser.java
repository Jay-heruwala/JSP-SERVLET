/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.connection.ConnectionClass;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

@WebServlet(urlPatterns = {"/UpdateUser"})
public class UpdateUser extends HttpServlet {

    ConnectionClass connectionClass = new ConnectionClass();

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        Connection connection = null;

        if (session != null && session.getAttribute("email") != null) {

            String emailId = request.getParameter("id");
            try {
                connection = connectionClass.createConnection();
                PreparedStatement preparedStatement = connection.prepareStatement("select * from user where email = ?");
                preparedStatement.setString(1, emailId);

                ResultSet resultSet = preparedStatement.executeQuery();
                resultSet.next();

                request.setAttribute("firstName", resultSet.getString("firstname"));
                request.setAttribute("lastName", resultSet.getString("lastname"));
                request.setAttribute("email", resultSet.getString("email"));
                request.setAttribute("mobilenumber", resultSet.getLong("mobilenumber"));
                request.setAttribute("address", resultSet.getString("address"));
                request.setAttribute("role", resultSet.getString("role"));
                request.setAttribute("updateUserValues", "UpdateUser");

                RequestDispatcher dispatcher = request.getRequestDispatcher("LogedUserInfo.jsp");
                dispatcher.forward(request, response);

            } catch (ClassNotFoundException e) {
                System.out.println("Error : " + e.getMessage());
            } catch (SQLException e) {
                System.err.println("Error : " + e.getMessage());
            }
        }
//        response.sendRedirect("form.jsp");
    }

    public static boolean validateMobileNumber(String mobilenumber) {
        String regEx = "^[0-9]{10}$";
        return mobilenumber.matches(regEx);
    }

    public static boolean validateStrings(String info) {
        String regEx = "^[A-Za-z]+$";
        return info.matches(regEx);
    }

    public static boolean whiteSpaceCharacter(String info) {
        String regEx = "^\\S+$";
        return info.matches(regEx);
    }

    public static boolean validateEmail(String info) {
        String regEx = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        return info.matches(regEx);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        String errorInfo = "";

        if (session != null && session.getAttribute("email") != null) {
            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String email = request.getParameter("email");
            String mobileNumber = request.getParameter("mobilenumber");
            String address = request.getParameter("address");
            String password = request.getParameter("password");

            firstName = (firstName != null) ? firstName.trim() : "";
            lastName = (lastName != null) ? lastName.trim() : "";
//            email = (email != null) ? email.trim() : "";
            mobileNumber = (mobileNumber != null) ? mobileNumber.trim() : "";

            if (firstName.isEmpty()) {
                errorInfo += "Firstname cannot be empty <br>";
            } else if (firstName.length() < 6) {
                errorInfo += "Firstname must be 6 Character <br>";
            } else if (!validateStrings(firstName)) {
                errorInfo += "FirstName contains only Alphbates<br>";
            }

            if (lastName.isEmpty()) {
                errorInfo += "LastName cannot be empty <br>";
            } else if (lastName.length() < 6) {
                errorInfo += "Last name must be 6 Character <br>";
            } else if (!validateStrings(lastName)) {
                errorInfo += "lastName contains only Alphbates<br>";
            }

//            if (email.isEmpty()) {
//                errorInfo += "Email cannot be enpty<br>";
//            } else if (!validateEmail(email)) {
//                errorInfo += "Email contains only A-Z a-z 0-9 . _ <br>";
//            }
            if (address.isEmpty()) {
                errorInfo += "Address cannot be empty<br>";
            }

            if (mobileNumber.isEmpty()) {
                errorInfo += "Mobile number cannto empty<br>";
            } else if (!validateMobileNumber(mobileNumber)) {
                errorInfo += "Enter valid mobile number<br>";
            } else if (mobileNumber.length() < 10 || mobileNumber.length() > 10) {
                errorInfo += "Mobile no Must be 10 digits<br>";
            }

            if (password.isEmpty()) {
                errorInfo += "Password cannot be empty <br>";
            } else if (password.length() < 6) {
                errorInfo += "Password must be greater than 6 character<br>";
            }
            
            System.out.println(errorInfo);
            
            long mobileNo = Long.parseLong(mobileNumber);
            //Set all GetParameters Which are used When Any error get. 
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("mobilenumber", mobileNo);
            request.setAttribute("address", address);

            System.out.println("Call 1");

            if (!errorInfo.isEmpty()) {
                request.setAttribute("errorInfoSeverSide", errorInfo);
                RequestDispatcher dispatcher = request.getRequestDispatcher("LogedUserInfo.jsp");
                dispatcher.forward(request, response);
                return;
            }

            System.out.println("Call 2");

            try {
                Connection connection = connectionClass.createConnection();
                PreparedStatement preparedStatement = connection.prepareCall("select count(*) from user where email = ? and password = ?");
                preparedStatement.setString(1, email);
                preparedStatement.setString(2, password);

                ResultSet resultSet = preparedStatement.executeQuery();
                resultSet.next();
                int findUser = resultSet.getInt(1);

                if (findUser != 1) {
                    request.setAttribute("errorInfoSeverSide", "Invalid Email Id Or Password");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("LogedUserInfo.jsp");
                    dispatcher.forward(request, response);
                    return;
                }

                System.out.println("Call 3");

                PreparedStatement updatePreparedStatement = connection.prepareStatement("update user set firstname = ? , lastname = ? , address = ? , mobilenumber = ?");
                updatePreparedStatement.setString(1, firstName);
                updatePreparedStatement.setString(2, lastName);
                updatePreparedStatement.setString(3, address);
                updatePreparedStatement.setLong(4, mobileNo);

                int isUpdated = updatePreparedStatement.executeUpdate();
                if (isUpdated == 1) {
                    response.sendRedirect("DisplayTable");
                } else {
                    response.sendRedirect("DisplayTable");
                }

            } catch (ClassNotFoundException e) {
                System.out.println("Error" + e.getMessage());
            } catch (SQLException e) {
                System.out.println("Error" + e.getMessage());
            }

        } else {
//            session.invalidate();
            response.sendRedirect("form.jsp");
        }
    }
}
