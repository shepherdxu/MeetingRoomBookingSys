package com.yourcompany.controller;

import com.yourcompany.service.DashboardService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public class DashboardServlet extends HttpServlet {
    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> dashboardData = dashboardService.getDashboardData();

        req.setAttribute("dashboardData", dashboardData);

        // 设置布局需要加载的参数
        req.setAttribute("title", "仪表盘");
        req.setAttribute("page", "dashboard"); // 用于在侧边栏高亮当前页面
        req.setAttribute("contentPage", "/WEB-INF/views/content/dashboard-content.jsp");

        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }
}