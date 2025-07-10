/**
* Meeting Room Booking System - User Model.
* @author Kyochilian
* @version 6.0
* @since 1.0
* @date 2025-7-10 20:49
* This class represents a user in the system. It contains the user's information, such as their username, password hash, full name, role, and department. It also has a foreign key to the department table, which is used to determine which department the user belongs to.
* */
package com.yourcompany.model;

public class User {
    private Integer userId;
    private String username;
    private String passwordHash;
    private String fullName;
    private String role;
    private Integer departmentId;

    // 关联对象
    private Department department;

    // Getters and Setters
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Integer getDepartmentId() { return departmentId; }
    public void setDepartmentId(Integer departmentId) { this.departmentId = departmentId; }
    public Department getDepartment() { return department; }
    public void setDepartment(Department department) { this.department = department; }
}