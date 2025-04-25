
package dao;



import model.MyBookings;
import model.Passenger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import util.DatabaseUtil;
import java.sql.*;
import model.Booking;

public class BookingDAO {
    

    public List<MyBookings> getUserBookings(long userId) throws SQLException {
        List<MyBookings> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection();

            // Query to fetch bookings with bus and payment details
            String query = "SELECT b.BookingID, b.BookingReference, b.BookingDateTime, b.PaymentStatus, " +
                          "bus.BusNumber, bus.BusType, bus.Source, bus.Destination, " +
                          "bus.DepartureDateTime, bus.ArrivalDateTime, p.TransactionID " +
                          "FROM Bookings b " +
                          "JOIN Buses bus ON b.BusID = bus.BusID " +
                          "LEFT JOIN Payments p ON b.BookingID = p.BookingID " +
                          "WHERE b.user_id = ? " +
                          "ORDER BY b.BookingDateTime DESC";
            stmt = conn.prepareStatement(query);
            stmt.setLong(1, userId);
            rs = stmt.executeQuery();

            Map<Integer, MyBookings> bookingMap = new HashMap<>();
            while (rs.next()) {
                int bookingId = rs.getInt("BookingID");
                String bookingReference = rs.getString("BookingReference");
                String bookingDate = rs.getString("BookingDateTime"); // YYYY-MM-DD
                String busDetails = rs.getString("BusNumber");
                String departureTime = rs.getString("DepartureDateTime"); // HH:MM
                String arrivalTime = rs.getString("ArrivalDateTime"); // HH:MM
                String busType = rs.getString("BusType");
                String source = rs.getString("Source");
                String destination = rs.getString("Destination");
                String transactionId = rs.getString("TransactionID");
                String status = rs.getString("PaymentStatus");

                MyBookings booking = new MyBookings(
                    bookingId, bookingReference, bookingDate, busDetails,
                    departureTime, arrivalTime, busType, source, destination,
                    transactionId != null ? transactionId : "N/A", status
                );
                bookingMap.put(bookingId, booking);
            }

            // Fetch passengers for each booking
            query = "SELECT BookingID, Name, Age, Gender, SeatNumber " +
                    "FROM Passengers WHERE BookingID IN (SELECT BookingID FROM Bookings WHERE user_id = ?)";
            stmt = conn.prepareStatement(query);
            stmt.setLong(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int bookingId = rs.getInt("BookingID");
                MyBookings booking = bookingMap.get(bookingId);
                if (booking != null) {
                    Passenger passenger = new Passenger(
                        rs.getString("Name"),
                        rs.getInt("Age"),
                        rs.getString("Gender"),
                        rs.getString("SeatNumber")
                    );
                    booking.addPassenger(passenger);
                }
            }

            bookings = new ArrayList<>(bookingMap.values());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return bookings;
    }
    
    
    public boolean cancelBooking(int bookingId, long userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean success = false;

        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Verify booking exists, is CONFIRMED, and belongs to user
            String checkQuery = "SELECT PaymentStatus, user_id, BusID FROM Bookings WHERE BookingID = ?";
            stmt = conn.prepareStatement(checkQuery);
            stmt.setInt(1, bookingId);
            rs = stmt.executeQuery();

            if (!rs.next()) {
                return false; // Booking not found
            }

            String status = rs.getString("PaymentStatus");
            long bookingUserId = rs.getLong("user_id");
            int busId = rs.getInt("BusID");
            if (!status.equals("CONFIRMED") || bookingUserId != userId) {
                return false; // Not CONFIRMED or not user's booking
            }

            // Get seat numbers from Passengers
            List<String> seatNumbers = new ArrayList<>();
            String passengerQuery = "SELECT SeatNumber FROM Passengers WHERE BookingID = ?";
            stmt = conn.prepareStatement(passengerQuery);
            stmt.setInt(1, bookingId);
            rs = stmt.executeQuery();
            int seatCount = 0;
            while (rs.next()) {
                seatNumbers.add(rs.getString("SeatNumber"));
                seatCount++;
            }

            // Update Bookings: Set PaymentStatus to CANCELLED
            String updateBookingQuery = "UPDATE Bookings SET PaymentStatus = 'CANCELLED' WHERE BookingID = ?";
            stmt = conn.prepareStatement(updateBookingQuery);
            stmt.setInt(1, bookingId);
            int bookingRows = stmt.executeUpdate();
            if (bookingRows != 1) {
                conn.rollback();
                return false;
            }

            // Update Seats: Set IsAvailable = 1 for matching BusID and SeatNumber
            if (!seatNumbers.isEmpty()) {
                String updateSeatsQuery = "UPDATE Seats SET IsAvailable = 1 WHERE BusID = ? AND SeatNumber = ?";
                stmt = conn.prepareStatement(updateSeatsQuery);
                for (String seatNumber : seatNumbers) {
                    stmt.setInt(1, busId);
                    stmt.setString(2, seatNumber);
                    stmt.executeUpdate();
                }
            }

            // Update Bus: Increment AvailableSeats
            String updateBusQuery = "UPDATE Buses SET AvailableSeats = AvailableSeats + ? WHERE BusID = ?";
            stmt = conn.prepareStatement(updateBusQuery);
            stmt.setInt(1, seatCount);
            stmt.setInt(2, busId);
            stmt.executeUpdate();

            
             String updatePaymentQuery = "UPDATE Payments SET PaymentStatus = 'REFUND' WHERE BookingID = ?";
             stmt = conn.prepareStatement(updatePaymentQuery);
             stmt.setInt(1, bookingId);
             stmt.executeUpdate();

            conn.commit();
            success = true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return success;
    }
    
    public int getTotalBookings() {
        String sql = "SELECT COUNT(*) AS count FROM bookings";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRevenue() {
        String sql = "SELECT SUM(totalamount) AS total FROM bookings WHERE PaymentStatus = 'CONFIRMED'";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)){
            if (rs.next()) {
                System.out.println(rs.getDouble("total"));
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    
}
