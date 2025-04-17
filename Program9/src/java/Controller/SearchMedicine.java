package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.MedicineDAO;
import Entity.Medicine;
import java.util.*;
import jakarta.servlet.http.HttpSession;

public class SearchMedicine extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchMedicine</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchMedicine at " + request.getContextPath() + "</h1>");
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
        PrintWriter out = response.getWriter();
        List<Medicine> medicines = new ArrayList<>();
        String searchPattern = request.getParameter("searchMedicine");

        try {
            MedicineDAO dao = new MedicineDAO();
            if (searchPattern != null && !searchPattern.trim().isEmpty()) {
                medicines = dao.searchMedicine(searchPattern);
            } else {
                medicines = dao.getAllMedicines(); // Fallback to all medicines if no search pattern
            }
        } catch (Exception e) {
            // Improved error handling
            e.printStackTrace(); // More detailed error logging
            request.setAttribute("errorMessage", "Error fetching medicines: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return; // Prevent further execution
        }

        
        System.out.println("Medicines found: " + medicines.size());
        
        if(medicines.size() > 0){

        HttpSession session = request.getSession();
        session.setAttribute("searchedMedicines", medicines);
        response.sendRedirect("index.jsp");
        }else{
            out.print("<script>alert('Not Found');</script>");
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
