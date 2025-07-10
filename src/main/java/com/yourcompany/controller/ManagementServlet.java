package com.yourcompany.controller;

import com.yourcompany.model.Booking;
import com.yourcompany.model.User;
import com.yourcompany.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ManagementServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "my-bookings";
        }

        switch (action) {
            case "cancel":
                handleCancel(req, resp);
                break;
            case "my-bookings":
            default:
                User user = (User) req.getSession().getAttribute("user");
                List<Booking> myBookings = bookingService.getBookingsByUserId(user.getUserId());
                req.setAttribute("myBookings", myBookings);

                req.setAttribute("title", "预定管理");
                req.setAttribute("page", "management");
                req.setAttribute("contentPage", "/WEB-INF/views/content/my-bookings-content.jsp");

                req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
                break;
        }
    }

    private void handleCancel(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            User user = (User) req.getSession().getAttribute("user");
            bookingService.cancelBooking(bookingId, user.getUserId());
            resp.sendRedirect(req.getContextPath() + "/management?action=my-bookings&message=cancel_success");
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/management?action=my-bookings&error=invalid_id");
        }
    }
}