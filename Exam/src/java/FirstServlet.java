
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import org.apache.tomcat.dbcp.dbcp2.SQLExceptionList;
public class FirstServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        String age = request.getParameter("age");

        try {
            
//            int a = Integer.parseInt(age);
            
           request.setAttribute("name", name);
           request.setAttribute("age", age);
           
            
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/Programs", "root", "Root");
                
                System.out.println("Connection successfully");
            }catch(SQLException  | ClassNotFoundException e){
                System.out.println("Error");
                e.printStackTrace();
            }
            
            
            //jdbc:mysql://127.0.0.1:3306/?user=root
           
           
           
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
            
            
            
            
        } catch (Exception e) {
               request.setAttribute("error", "Something Wrong age must be digit");
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
            
        }

    }

}
