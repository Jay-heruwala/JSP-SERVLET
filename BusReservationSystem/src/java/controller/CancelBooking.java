
package controller;


import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.http.HttpSession;
import model.User;
import dao.BookingDAO;


public class CancelBooking extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Validate session and user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Long userId = user.getUser_id();
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get bookingId
        String bookingIdStr = request.getParameter("bookingId");
        int bookingId;
        try {
            bookingId = Integer.parseInt(bookingIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("MyBookings.jsp?error=Invalid+booking+ID");
            return;
        }

        // Cancel booking
        BookingDAO bookingDAO = new BookingDAO();
        try {
            boolean cancelled = bookingDAO.cancelBooking(bookingId, userId);
            if (cancelled) {
                response.sendRedirect("MyBookings.jsp?message=Booking+cancelled+successfully");
            } else {
                response.sendRedirect("MyBookings.jsp?error=Booking+not+found,+not+confirmed,+or+not+authorized");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("MyBookings.jsp?error=Error+cancelling+booking");
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
