package com.yourcompany.dao;

import com.yourcompany.model.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map; // Import Map for dashboard methods

/**
 * Mapper interface for User operations.
 * This interface defines the methods for interacting with the 'users' table in the database.
 */
public interface UserMapper {

    /**
     * Finds a user by their username.
     *
     * @param username The username to search for.
     * @return The User object if found, otherwise null.
     */
    User findByUsername(@Param("username") String username);

    /**
     * Finds a user by their user ID.
     *
     * @param userId The ID of the user to search for.
     * @return The User object if found, otherwise null.
     */
    User findById(@Param("userId") int userId);

    /**
     * Inserts a new user into the database.
     * The generated user ID will be set back into the User object.
     *
     * @param user The User object to insert.
     * @return The number of rows affected (should be 1 on successful insert).
     */
    int insertUser(User user);

    /**
     * Retrieves a list of all users with the role 'employee'.
     * This is typically used for populating attendee lists.
     *
     * @return A list of User objects (employees).
     */
    List<User> findAllEmployees();

    /**
     * Retrieves a list of all users in the system.
     * This is typically used by administrators for user management.
     *
     * @return A list of all User objects.
     */
    List<User> findAllUsers();

    /**
     * Updates an existing user's details (excluding password).
     *
     * @param user The User object with updated information.
     * @return The number of rows affected (should be 1 on successful update).
     */
    int updateUser(User user);

    /**
     * Updates the password hash for a specific user.
     *
     * @param userId The ID of the user whose password is to be updated.
     * @param passwordHash The new hashed password.
     * @return The number of rows affected (should be 1 on successful update).
     */
    int updatePassword(@Param("userId") int userId, @Param("passwordHash") String passwordHash);

    /**
     * Deletes a user from the database by their ID.
     *
     * @param userId The ID of the user to delete.
     * @return The number of rows affected (should be 1 on successful delete).
     */
    int deleteUser(@Param("userId") int userId);

    // --- Methods for AdminDashboardService ---

    /**
     * Counts the total number of users in the system.
     *
     * @return The total count of users.
     */
    int countUsers();

    /**
     * Counts the number of users grouped by department.
     *
     * @return A list of maps, where each map contains 'name' (department name) and 'value' (user count).
     */
    List<Map<String, Object>> countUsersByDepartment();

    /**
     * Counts the number of users grouped by role.
     *
     * @return A list of maps, where each map contains 'name' (role name) and 'value' (user count).
     */
    List<Map<String, Object>> countUsersByRole();

    List<User> findAllAdmins();

    List<User> findAll(String searchName, Integer departmentId);
}