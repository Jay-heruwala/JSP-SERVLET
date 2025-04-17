/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Util.DatabaseUtil;
import DAO.BookDAO;
import Entity.Book;
import jakarta.servlet.http.HttpSession;

public class FetchBook extends HttpServlet {

  
   

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int book_id = Integer.parseInt(request.getParameter("bookId"));
        try{
            
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.fetchBook(book_id);
            
            if(book != null){
                HttpSession session = request.getSession();
                session.setAttribute("book", book);
                response.sendRedirect("updateBook.jsp");
            }else{
                
            }
            
            
        }catch(Exception e){
            System.out.println("Error : " + e.getMessage());
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
