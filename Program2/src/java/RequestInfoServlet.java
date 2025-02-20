import jakarta.servlet.ServletConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Enumeration;


public class RequestInfoServlet extends HttpServlet {
    
    @Override
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    
    
    @Override
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
           response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Servlet Info</title></head><body>");
        out.println("<h2>Servlet Initialization Parameters</h2>");
        ServletConfig config = getServletConfig();
        Enumeration<String> initParamNames = config.getInitParameterNames();
        if (initParamNames.hasMoreElements()) {
            out.println("<ul>");
            while (initParamNames.hasMoreElements()) {
                String paramName = initParamNames.nextElement();
                String paramValue = config.getInitParameter(paramName);
                out.println("<li>" + paramName + ": " + paramValue + "</li>");
            }
            out.println("</ul>");
        } else {
            out.println("<p>No initialization parameters.</p>");
        }

        out.println("<h2>HTTP Request Headers</h2>");
        Enumeration<String> headerNames = request.getHeaderNames();
        if (headerNames.hasMoreElements()) {
            out.println("<ul>");
            while (headerNames.hasMoreElements()) {
                String headerName = headerNames.nextElement();
                String headerValue = request.getHeader(headerName);
                out.println("<li>" + headerName + ": " + headerValue + "</li>");
            }
            out.println("</ul>");
        } else {
            out.println("<p>No headers available.</p>");
        }

        out.println("<h2>Client/Browser Information</h2>");
        out.println("<ul>");
        out.println("<li>Remote Address: " + request.getRemoteAddr() + "</li>");
        out.println("<li>Remote Host: " + request.getRemoteHost() + "</li>");
        out.println("<li>Remote Port: " + request.getRemotePort() + "</li>");
        out.println("<li>Client User-Agent: " + request.getHeader("User-Agent") + "</li>");
        out.println("</ul>");

        out.println("<h2>Server Information</h2>");
        out.println("<ul>");
        out.println("<li>Server Name: " + request.getServerName() + "</li>");
        out.println("<li>Server Port: " + request.getServerPort() + "</li>");
        out.println("<li>Servlet Context Path: " + request.getContextPath() + "</li>");
        out.println("</ul>");

        out.println("</body></html>");
        out.close();


    }
}
