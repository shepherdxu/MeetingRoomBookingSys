package com.yourcompany.model;

import java.util.Date;
import java.util.List;

public class Booking {
    private Integer bookingId;
    private String title;
    private Date startTime;
    private Date endTime;
    private String status;
    private String notes;
    private Integer roomId;
    private Integer requesterId;
    private Date createdAt;
    private List<String> selectedAmenities;
    // 关联对象
    private Room room;
    private User requester;
    private List<User> attendees;

    // Getters and Setters
    public Integer getBookingId() { return bookingId; }
    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date endTime) { this.endTime = endTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public Integer getRoomId() { return roomId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }
    public Integer getRequesterId() { return requesterId; }
    public void setRequesterId(Integer requesterId) { this.requesterId = requesterId; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public Room getRoom() { return room; }
    public void setRoom(Room room) { this.room = room; }
    public User getRequester() { return requester; }
    public void setRequester(User requester) { this.requester = requester; }
    public List<User> getAttendees() { return attendees; }
    public void setAttendees(List<User> attendees) { this.attendees = attendees; }
    public List<String> getSelectedAmenities() { return selectedAmenities; }
    public void setSelectedAmenities(List<String> selectedAmenities) { this.selectedAmenities = selectedAmenities; }
}