package com.yourcompany.model;

// M:N 连接表，通常在业务逻辑中处理，不一定需要独立的Service或Servlet
public class BookingAttendee {
    private Integer attendeeId;
    private Integer bookingId;
    private Integer userId;

    // Getters and Setters
    public Integer getAttendeeId() { return attendeeId; }
    public void setAttendeeId(Integer attendeeId) { this.attendeeId = attendeeId; }
    public Integer getBookingId() { return bookingId; }
    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
}