
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

public class DeleteUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
        out.print("I am coming<br>");
        String emailId = request.getParameter("id");
        out.print(emailId);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://localhost:3306/Programs";
            String user = "root";
            String databasePassword = "Root";
            try {
                Connection connection = DriverManager.getConnection(URL, user, databasePassword);
                PreparedStatement checkEmailExists = connection.prepareStatement("select count(*) Data from user where email = ?");
                checkEmailExists.setString(1, emailId);
                ResultSet resultSet = checkEmailExists.executeQuery();
                resultSet.next();
                int row = resultSet.getInt(1);
                if (row == 1) {
                    PreparedStatement deleteUserPreparedStatement = connection.prepareStatement("delete from user where email = ?");
                    deleteUserPreparedStatement.setString(1, emailId);
                    int userDeleted = deleteUserPreparedStatement.executeUpdate();
                    if (userDeleted == 1) {
                        response.sendRedirect("DisplayTable");
                    } else {

                        response.sendRedirect("DisplayTable");
                    }

                }

            } catch (SQLException e) {
                System.out.println("Error : " + e.getMessage());
            }

        } catch (ClassNotFoundException e) {
            System.out.println("Error : " + e.getMessage());
            if (session != null) {

                response.sendRedirect("home.jsp");
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
