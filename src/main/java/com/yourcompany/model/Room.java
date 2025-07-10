package com.yourcompany.model;

public class Room {
    private Integer roomId;
    private String roomName;
    private Integer capacity;
    private String amenities;
    private Integer locationId;

    // 关联对象
    private Location location;
    // 瞬态字段 (不映射到数据库), 用于在业务逻辑中设置当前状态
    private String currentStatus = "空闲"; // 默认为空闲
    // Getters and Setters
    public Integer getRoomId() { return roomId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }
    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }
    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }
    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }
    public Integer getLocationId() { return locationId; }
    public void setLocationId(Integer locationId) { this.locationId = locationId; }
    public Location getLocation() { return location; }
    public void setLocation(Location location) { this.location = location; }
    public String getCurrentStatus() { return currentStatus; }
    public void setCurrentStatus(String currentStatus) { this.currentStatus = currentStatus; }
}