
import jakarta.servlet.RequestDispatcher;
import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import jakarta.servlet.http.HttpSession;

public class RegisterUser extends HttpServlet {

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

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String errorInfo = "";

        //Get All Parameters
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String mobileNumber = request.getParameter("mobileno");
        String confirmPassword = request.getParameter("confirmpassword");

        firstName = (firstName != null) ? firstName.trim() : "";
        lastName = (lastName != null) ? lastName.trim() : "";
        email = (email != null) ? email.trim() : "";
        role = (role != null) ? role.trim() : "";
        password = (password != null) ? password.trim() : "";
        mobileNumber = (mobileNumber != null) ? mobileNumber.trim() : "";

        if (firstName.isEmpty()) {
            errorInfo += "Firstname cannot be empty <br>";
        }else if(firstName.length() < 6){
            errorInfo += "Firstname must be 6 Character <br>";
        }else if (!validateStrings(firstName)) {
            errorInfo += "FirstName contains only Alphbates<br>";
        }

        if (lastName.isEmpty()) {
            errorInfo += "LastName cannot be empty <br>";
        }else if(lastName.length() < 6){
            errorInfo += "Last name must be 6 Character <br>";
        } else if (!validateStrings(lastName)) {
            errorInfo += "lastName contains only Alphbates<br>";
        }

        if (role.isEmpty()) {
            errorInfo += "Role cannot be empty<br>";
        } else if (!validateStrings(role)) {
            errorInfo += "Role contains only Alphabates<br>";
        }

        if (email.isEmpty()) {
            errorInfo += "Email cannot be enpty<br>";
        } else if (!validateEmail(email)) {
            errorInfo += "Email contains only A-Z a-z 0-9 . _ <br>";
        }

        if (address.isEmpty()) {
            errorInfo += "Address cannot be empty<br>";
        }

        if (mobileNumber.isEmpty()) {
            errorInfo += "Mobile number cannto empty<br>";
        } else if (!validateMobileNumber(mobileNumber)) {
            errorInfo += "Enter valid mobile number<br>";
        }else if(mobileNumber.length() < 10 || mobileNumber.length() > 10){
            errorInfo += "Mobile no Must be 10 digits<br>";
        }

        if (password.isEmpty()) {
            errorInfo += "Password cannot be empty <br>";
        }else if(password.length() < 6){
            errorInfo += "Password must be greater than 6 character<br>";
        }
        
        if(!confirmPassword.equals(password)){
            errorInfo += "Confirm passwod must be same as password<br>";
        }

        long mobileNo = Long.parseLong(mobileNumber);
        //Set all GetParameters Which are used When Any error get. 
        request.setAttribute("firstname", firstName);
        request.setAttribute("lastname", lastName);
        request.setAttribute("email", email);
        request.setAttribute("mobileno", mobileNo);
        request.setAttribute("role", role);
        request.setAttribute("address", address);

        if (!errorInfo.isEmpty()) {
            request.setAttribute("errorInfoSeverSide", errorInfo);
            RequestDispatcher dispatcher = request.getRequestDispatcher("form.jsp");
            dispatcher.forward(request, response);
            return;
        }

        //Load a JDBC Driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.print("Error : " + e.getMessage());
        }

        //After Load JDBC Driver Store the data at database
        try {
            String URL = "jdbc:mysql://localhost:3306/Programs";
            String user = "root";
            String databasePassword = "Root";
            Connection connection = DriverManager.getConnection(URL, user, databasePassword);

            PreparedStatement emailSecuity = connection.prepareStatement("select count(*) from user where email = ?");
            emailSecuity.setString(1, email);
            ResultSet emailSet = emailSecuity.executeQuery();
            emailSet.next();
            int emailCount = emailSet.getInt(1);

            if (emailCount > 0) {
                request.setAttribute("EmailFound", "true");
                request.setAttribute("emailError", "Invalid Email ID! Email already exists.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("form.jsp");
                dispatcher.forward(request, response);
            } else {

                PreparedStatement preparedStatement = connection.prepareStatement("insert into user values(?,?,?,?,?,?,?)");
                preparedStatement.setString(1, firstName);
                preparedStatement.setString(2, lastName);
                preparedStatement.setString(3, email);
                preparedStatement.setLong(4, mobileNo);
                preparedStatement.setString(5, address);
                preparedStatement.setString(6, role);
                preparedStatement.setString(7, password);

                int rowInserted = preparedStatement.executeUpdate();
                out.print(rowInserted);
                if (rowInserted > 0) {
                    session.setAttribute("email", email);
                    session.setAttribute("firstName", firstName);
                    session.setAttribute("role", role);
                    response.sendRedirect("DisplayTable");

                } else {
                    response.sendRedirect("form.jsp");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error : " + e.getMessage());
        }
    }

}
