

import jakarta.security.auth.message.callback.PrivateKeyCallback;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import jakarta.servlet.http.HttpSession;


public class LoginModule extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginModule</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginModule at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            
            String role = request.getParameter("role");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            int role_id = 0;
            
            request.setAttribute("error", "Invalid Information");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
            }catch(ClassNotFoundException e){
                System.out.println("Error : " + e.getMessage());
                throw new Exception();
            }
            String roleName = null;
           
            
            
            try {
                Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/programs", "root", "Root");
                
                PreparedStatement statement = connection.prepareStatement("select * from role where role_name = ?");
                statement.setString(1, role);
                ResultSet roleid = statement.executeQuery();
                if(roleid.next()){
                    role_id = roleid.getInt("role_id");
                    roleName = roleid.getString("role_name");
                }
                
                System.out.println(role_id);
                
                if(role_id != 0){
                    PreparedStatement pstmt = connection.prepareStatement("select * from users where email_id = ? and password = ? and role_id = ?");
                    pstmt.setString(1, email);
                    pstmt.setString(2, password);
                    pstmt.setInt(3, role_id);
                    ResultSet result = pstmt.executeQuery();
                    
                    if(result.next()){
                        
                        HttpSession session = request.getSession();
                        
                        if(result.getInt("role_id") == 1){
                            session.setAttribute("email", result.getString("email_id"));
                            session.setAttribute("role", roleName);
                            System.out.println(session.getAttribute("role"));
                            response.sendRedirect("admin.jsp");
                        }else if(result.getInt("role_id") == 2){
                            session.setAttribute("email", result.getString("email_id"));
                            session.setAttribute("role", roleName);
                            System.out.println(session.getAttribute("role"));
                            response.sendRedirect("user.jsp");
                        }
                    }else{
                        dispatcher.forward(request, response);
                    }
                }else{
                    dispatcher.forward(request, response);
                }
                
            } catch (Exception e) {
                dispatcher.forward(request, response);
            }
            
            
            
        }catch(Exception e){
            response.sendRedirect("index.jsp");
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
