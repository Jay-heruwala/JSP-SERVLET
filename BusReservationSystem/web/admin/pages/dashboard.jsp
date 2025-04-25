<%-- 
    Document   : deshboard
    Created on : 27 Mar 2025, 4:55:16 pm
    Author     : jayhe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, dao.BookingDAO, dao.BusesDAO, dao.UserDAO, model.Booking, java.text.NumberFormat, java.text.SimpleDateFormat"%>

<% 
    if(session.getAttribute("LogedAdminInfo") == null){
        %>  
        <jsp:forward page="AdminLogin.jsp" />
        <%
    }

    BookingDAO bookingDAO = new BookingDAO();
    BusesDAO busDAO = new BusesDAO();
    UserDAO userDAO = new UserDAO();

    int totalBookings = bookingDAO.getTotalBookings();
    int activeBuses = busDAO.getActiveBusesCount();
    double totalRevenue = bookingDAO.getTotalRevenue();
    int totalCustomers = userDAO.getTotalCustomers();


    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new java.util.Locale("en", "IN"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="css/dashboard.css"/>
        <!-- Font Awesome for Home icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
      
    </head>
    <body>
       
       
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-title">Total Bookings</div>
                <div class="card-value"><%= totalBookings %></div>
            </div>
           
            
            <div class="card">
                <div class="card-title">Total Customers</div>
                <div class="card-value"><%= totalCustomers %></div>
            </div>
        </div>


    </body>
</html>