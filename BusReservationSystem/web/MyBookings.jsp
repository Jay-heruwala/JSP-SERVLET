<%-- 
    Document   : MyBookings
    Created on : 19 Apr 2025, 3:28:14 pm
    Author     : jayhe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dao.BookingDAO, model.MyBookings, model.Passenger, model.User"%>

<%!
    // Function to fetch bookings for the user
    public List<MyBookings> getUserBookings(Long userId) {
        try {
            BookingDAO bookingDAO = new BookingDAO();
            return bookingDAO.getUserBookings(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
%>

<%
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

    List<MyBookings> bookings = getUserBookings(userId);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Bus Bookings</title>
        <link rel="stylesheet" href="css/MyBookings.css"/>
        
    </head>
    <body>
        <!-- Home Icon in Top-Right Corner -->
        <a href="index.jsp" class="home-icon-link" title="Go to Home">
            <span class="home-icon">🏠</span>
        </a>
        <div class="container">
            <h1>My Bus Bookings</h1>
            <%
                String message = request.getParameter("message");
                String error = request.getParameter("error");
                if (message != null) {
            %>
            <div style="color: green; text-align: center; margin-bottom: 20px;"><%= message%></div>
            <%
            } else if (error != null) {
            %>
            <div style="color: red; text-align: center; margin-bottom: 20px;"><%= error%></div>
            <%
                }

                if (bookings.size() > 0) {
            %>
            <div class="table-wrapper">
                <table class="bookings-table">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Booking Reference</th>
                            <th>Booking Date</th>
                            <th>Bus Details</th>
                            <th>Departure Time</th>
                            <th>Arrival Time</th>
                            <th>Bus Type</th>
                            <th>Source</th>
                            <th>Destination</th>
                            <th>Passenger Details</th>
                            <th>Transaction ID</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int rowIndex = 0;
                            for (MyBookings booking : bookings) {
                                boolean isLastRow = (rowIndex == bookings.size() - 1);
                        %>
                        <tr class="<%= isLastRow ? "last-row" : ""%>">
                            <td><%= booking.getBookingId()%></td>
                            <td><%= booking.getBookingReference()%></td>
                            <td><%= booking.getBookingDate()%></td>
                            <td><%= booking.getBusDetails()%></td>
                            <td><%= booking.getDepartureTime()%></td>
                            <td><%= booking.getArrivalTime()%></td>
                            <td><%= booking.getBusType()%></td>
                            <td><%= booking.getSource()%></td>
                            <td><%= booking.getDestination()%></td>
                            <td>
                                <span class="eye-icon" onclick="togglePassengerDetails('passenger-details-<%= booking.getBookingId()%>', <%= isLastRow%>)">👁️</span>
                                <div id="passenger-details-<%= booking.getBookingId()%>" class="passenger-details">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Age</th>
                                                <th>Gender</th>
                                                <th>Seat Number</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (Passenger passenger : booking.getPassengers()) {
                                            %>
                                            <tr>
                                                <td><%= passenger.getName()%></td>
                                                <td><%= passenger.getAge()%></td>
                                                <td><%= passenger.getGender()%></td>
                                                <td><%= passenger.getSeatNumber()%></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                            <td><%= booking.getTransactionId()%></td>
                            <td class="status-<%= booking.getStatus().toLowerCase()%>"><%= booking.getStatus()%></td>
                            <td>
                                <div class="actions-container">
                                    <a href="ViewBookingServlet?bookingId=<%= booking.getBookingId()%>" class="action-btn view-btn">View</a>
                                    <%
                                        if ("CONFIRMED".equals(booking.getStatus())) {
                                            String departureTimeStr = booking.getDepartureTime();
                                            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                            try {
                                                java.util.Date departureTime = sdf.parse(departureTimeStr);
                                                java.util.Date now = new java.util.Date();
                                                long diffMillis = departureTime.getTime() - now.getTime();
                                                long diffHours = diffMillis / (1000 * 60 * 60);
                                                if (diffHours >= 2) {
                                    %>
                                    <a href="CancelBooking?bookingId=<%= booking.getBookingId()%>" class="action-btn cancel-btn">Cancel</a>
                                    <%
                                                }
                                            } catch (Exception e) {
                                                // Handle parsing error silently
                                            }
                                        }
                                    %>
                                </div>
                            </td>
                        </tr>
                        <%
                                rowIndex++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
            } else {
            %>
            <div class="table-wrapper">No Booking Found <a href="index.jsp"> Go to Home page </a></div>
            <%
                }
            %>
        </div>

        <script>
            function togglePassengerDetails(id, isLastRow) {
                console.log('Toggling passenger details for ID: ' + id + ', isLastRow: ' + isLastRow);
                const element = document.getElementById(id);
                if (!element) {
                    console.error('Element not found for ID: ' + id);
                    return;
                }
                const isVisible = element.style.display === 'block';
                document.querySelectorAll('.passenger-details').forEach(el => {
                    el.style.display = 'none';
                });
                element.style.display = isVisible ? 'none' : 'block';
                console.log('Set display to: ' + element.style.display);
                if (isLastRow) {
                    console.log('Last row dropdown coordinates:', element.getBoundingClientRect());
                }
            }

            document.addEventListener('click', function (event) {
                const isClickInside = event.target.closest('.passenger-details') || event.target.classList.contains('eye-icon');
                if (!isClickInside) {
                    console.log('Closing all passenger details due to outside click');
                    document.querySelectorAll('.passenger-details').forEach(el => {
                        el.style.display = 'none';
                    });
                }
            });
        </script>
    </body>
</html>