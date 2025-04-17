
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Entity.Book;
import DAO.BookDAO;


public class DeleteBook extends HttpServlet {

  
    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean result;
        
        int book_id = Integer.parseInt(request.getParameter("bookId"));
        
        System.out.println(book_id);
        
        BookDAO bookDAO = new BookDAO();
        boolean resultD = bookDAO.deleteBook(book_id);
        if(resultD){
            response.sendRedirect(request.getContextPath());
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
