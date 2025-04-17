
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DAO.BookDAO;


public class UpdateBook extends HttpServlet {

   

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int bookId =Integer.parseInt(request.getParameter("bookId"));
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int qty = Integer.parseInt(request.getParameter("quantity"));
        String isbn = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        String editingYear = request.getParameter("editionYear");
        String catalouueId = request.getParameter("catalogueId");
        
        
        try{
            BookDAO bookDAO = new BookDAO();
            Boolean result = bookDAO.updateBook(bookId, title, author, price, qty, isbn, publisher, editingYear, catalouueId);
            if(result){
                response.sendRedirect("index.jsp");
            }
        }catch(Exception e){
            System.out.println("Error : " + e.getMessage());
        }
        
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
