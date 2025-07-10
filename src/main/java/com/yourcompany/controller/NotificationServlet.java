package com.yourcompany.controller;

import com.google.gson.Gson;
import com.yourcompany.model.Notification;
import com.yourcompany.model.User;
import com.yourcompany.service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class NotificationServlet extends HttpServlet {
    private final NotificationService notificationService = new NotificationService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        List<Notification> notifications = notificationService.getUnreadNotifications(user.getUserId());

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(gson.toJson(notifications));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("markAsRead".equals(action)) {
            User user = (User) req.getSession().getAttribute("user");
            int notificationId = Integer.parseInt(req.getParameter("id"));
            notificationService.markAsRead(notificationId, user.getUserId());
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}