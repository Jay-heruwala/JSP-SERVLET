
package model;



import java.util.ArrayList;
import java.util.List;

public class MyBookings {
    private int bookingId;
    private String bookingReference;
    private String bookingDate;
    private String busDetails;
    private String departureTime;
    private String arrivalTime;
    private String busType;
    private String source;
    private String destination;
    private String transactionId;
    private String status;
    private List<Passenger> passengers;

    public MyBookings(int bookingId, String bookingReference, String bookingDate, String busDetails,
                   String departureTime, String arrivalTime, String busType, String source,
                   String destination, String transactionId, String status) {
        this.bookingId = bookingId;
        this.bookingReference = bookingReference;
        this.bookingDate = bookingDate;
        this.busDetails = busDetails;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.busType = busType;
        this.source = source;
        this.destination = destination;
        this.transactionId = transactionId;
        this.status = status;
        this.passengers = new ArrayList<>();
    }

    public void addPassenger(Passenger passenger) {
        passengers.add(passenger);
    }

    // Getters
    public int getBookingId() { return bookingId; }
    public String getBookingReference() { return bookingReference; }
    public String getBookingDate() { return bookingDate; }
    public String getBusDetails() { return busDetails; }
    public String getDepartureTime() { return departureTime; }
    public String getArrivalTime() { return arrivalTime; }
    public String getBusType() { return busType; }
    public String getSource() { return source; }
    public String getDestination() { return destination; }
    public String getTransactionId() { return transactionId; }
    public String getStatus() { return status; }
    public List<Passenger> getPassengers() { return passengers; }
}


