package com.yourcompany.service;

import com.yourcompany.dao.DepartmentMapper;
import com.yourcompany.dao.UserMapper;
import com.yourcompany.model.Department;
import com.yourcompany.model.User;
import com.yourcompany.util.MyBatisUtil;
import com.yourcompany.util.PasswordUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class UserService {
    /**
     * Handles user login by authenticating username and password.
     *
     * @param username The username provided by the user.
     * @param password The plain-text password provided by the user.
     * @return The User object if authentication is successful, otherwise null.
     */
    public User login(String username, String password) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession()) {
            UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
            User user = userMapper.findByUsername(username);

            if (user != null && PasswordUtil.checkPassword(password, user.getPasswordHash())) {
                return user;
            }
        }
        return null;
    }

    /**
     * Registers a new user.
     * Sets the default role to 'employee' and hashes the password before insertion.
     *
     * @param user The User object containing registration details.
     * @return true if registration is successful, false if username already exists or an error occurs.
     */
    public boolean registerUser(User user) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) { // true for auto-commit
            UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
            // Check if username already exists
            if (userMapper.findByUsername(user.getUsername()) != null) {
                return false; // Username already exists
            }
            // Hash the password
            user.setPasswordHash(PasswordUtil.hashPassword(user.getPasswordHash()));
            // Set default role to employee
            user.setRole("employee");
            return userMapper.insertUser(user) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves a list of all employees (users with 'employee' role).
     *
     * @return A list of User objects with the role 'employee'.
     */
    public List<User> getAllEmployees() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findAllEmployees();
        }
    }

    /**
     * Retrieves a list of all departments.
     *
     * @return A list of Department objects.
     */
    public List<Department> getAllDepartments() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            DepartmentMapper mapper = session.getMapper(DepartmentMapper.class);
            return mapper.findAll();
        }
    }

    /**
     * Retrieves a list of all users in the system, regardless of their role.
     * This is typically used by administrators for user management.
     *
     * @return A list of all User objects.
     */
    public List<User> getAllUsers() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findAllUsers(); // Now calls the new findAllUsers method in UserMapper
        }
    }
    public List<User> getUsers(String searchName, Integer departmentId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findAll(searchName, departmentId);
        }
    }
    /**
     * Retrieves a user by their ID.
     *
     * @param userId The ID of the user to retrieve.
     * @return The User object corresponding to the ID, or null if not found.
     */
    public User getUserById(int userId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findById(userId); // Now calls findById with userId parameter
        }
    }

    /**
     * Updates the details of an existing user.
     * This method does not update the password.
     *
     * @param user The User object with updated information.
     * @return true if the update was successful, false otherwise.
     */
    public boolean updateUser(User user) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) { // true for auto-commit
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            return mapper.updateUser(user) > 0; // Now calls the new updateUser method in UserMapper
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates the password for a specific user.
     * The new password will be hashed before being stored in the database.
     *
     * @param userId The ID of the user whose password is to be updated.
     * @param newPassword The new plain-text password.
     * @return true if the password update was successful, false otherwise.
     */
    public boolean updatePassword(int userId, String newPassword) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) { // true for auto-commit
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            return mapper.updatePassword(userId, hashedPassword) > 0; // Now calls the new updatePassword method in UserMapper
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a user from the system.
     *
     * @param userId The ID of the user to delete.
     * @return true if the user was successfully deleted, false otherwise.
     */
    public boolean deleteUser(int userId) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) { // true for auto-commit
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            return mapper.deleteUser(userId) > 0; // Now calls the new deleteUser method in UserMapper
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
