
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Entity.Book;
import DAO.BookDAO;

public class addBook extends HttpServlet {

   
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        bookId, title, author, price, Quantity, ISBN, publisher, edition year, catalogueId
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int qty = Integer.parseInt(request.getParameter("quantity"));
        String isbn = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        String editingYear = request.getParameter("editionYear");
        String catalouueId = request.getParameter("catalogueId");
        
        Book book = new Book(title, author, price, qty, isbn, publisher, editingYear, catalouueId);
        
        BookDAO bookDAO = new BookDAO();
        Boolean result = bookDAO.addBookInfo(book);
        
        if(result){
            response.sendRedirect(request.getContextPath());
        }
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
