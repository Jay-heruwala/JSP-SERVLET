/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Enumeration;

/**
 *
 * @author jayhe
 */
public class Information extends HttpServlet {

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServletConfig config = getServletConfig();

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Information</title>");
            out.println("</head>");
            out.println("<body>");

            Enumeration<String> initEnumeration = config.getInitParameterNames();
            
            while (initEnumeration.hasMoreElements()) {
                String nextElement = initEnumeration.nextElement();
                String getParameter = config.getInitParameter(nextElement);
                out.print(nextElement + " : " + getParameter);
            }
            
            Enumeration<String> headerEnumeration = request.getHeaderNames();
            while (headerEnumeration.hasMoreElements()) {
                String nextElement = headerEnumeration.nextElement();
                String value = request.getHeader(nextElement);
                 out.print(nextElement + " : " + value);
                
            }
            
            
            while (initEnumeration.hasMoreElements()) {
                String nextElement = initEnumeration.nextElement();
                String getParameter = config.getInitParameter(nextElement);
                out.print(nextElement + " : " + getParameter);
            }

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
        processRequest(request, response);
    }

}
