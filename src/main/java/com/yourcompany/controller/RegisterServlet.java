package com.yourcompany.controller;

import com.yourcompany.model.Department;
import com.yourcompany.model.User;
import com.yourcompany.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class RegisterServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 加载部门列表以供选择
        List<Department> departments = userService.getAllDepartments();
        req.setAttribute("departments", departments);
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setUsername(req.getParameter("username"));
        user.setPasswordHash(req.getParameter("password")); // 密码将在Service层哈希
        user.setFullName(req.getParameter("fullName"));
        user.setDepartmentId(Integer.parseInt(req.getParameter("departmentId")));

        boolean success = userService.registerUser(user);

        if (success) {
            req.setAttribute("message", "注册成功，请登录！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "注册失败，用户名可能已存在。");
            // 重新加载部门列表
            List<Department> departments = userService.getAllDepartments();
            req.setAttribute("departments", departments);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}