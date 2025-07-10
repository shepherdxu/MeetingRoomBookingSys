package com.yourcompany.controller;

import com.yourcompany.model.Booking;
import com.yourcompany.model.Room;
import com.yourcompany.model.User;
import com.yourcompany.service.BookingService;
import com.yourcompany.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class BookingServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    private final UserService userService = new UserService();
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("search".equals(action)) {
            handleSearch(req, resp);
        } else {
            forwardToBookingPage(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            Booking booking = new Booking();
            booking.setTitle(req.getParameter("title"));
            booking.setStartTime(dateFormat.parse(req.getParameter("startTime")));
            booking.setEndTime(dateFormat.parse(req.getParameter("endTime")));
            booking.setRoomId(Integer.parseInt(req.getParameter("roomId")));
            booking.setRequesterId(user.getUserId());
            booking.setRequester(user); // 传入完整的User对象
            booking.setNotes(req.getParameter("notes"));

            String[] attendeeIdsStr = req.getParameterValues("attendees");
            List<Integer> attendeeIds = new ArrayList<>();
            if (attendeeIdsStr != null) {
                attendeeIds = Arrays.stream(attendeeIdsStr)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
            }

            boolean success = bookingService.createBooking(booking, attendeeIds);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/management?action=my-bookings&message=booking_submitted");
            } else {
                req.setAttribute("error", "预约失败，该时段可能已被他人抢先预定，请重新查询。");
                req.setAttribute("startTime", req.getParameter("startTime"));
                req.setAttribute("endTime", req.getParameter("endTime"));
                handleSearch(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "创建预约时发生错误：" + e.getMessage());
            forwardToBookingPage(req, resp);
        }
    }

    // ... doGet的辅助方法无变化
    private void forwardToBookingPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> employees = userService.getAllEmployees();
        req.setAttribute("employees", employees);
        req.setAttribute("title", "房间预定");
        req.setAttribute("page", "booking");
        req.setAttribute("contentPage", "/WEB-INF/views/content/booking-content.jsp");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }
    private void handleSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String startTimeStr = req.getParameter("startTime");
        String endTimeStr = req.getParameter("endTime");
        if (startTimeStr != null && !startTimeStr.isEmpty() && endTimeStr != null && !endTimeStr.isEmpty()) {
            try {
                Date startTime = dateFormat.parse(startTimeStr);
                Date endTime = dateFormat.parse(endTimeStr);
                if (startTime.after(endTime) || startTime.equals(endTime)) {
                    req.setAttribute("error", "结束时间必须晚于开始时间");
                } else {
                    List<Room> availableRooms = bookingService.findAvailableRooms(startTime, endTime);
                    req.setAttribute("availableRooms", availableRooms);
                    req.setAttribute("startTime", startTimeStr);
                    req.setAttribute("endTime", endTimeStr);
                }
            } catch (ParseException e) {
                req.setAttribute("error", "日期格式无效，请重新输入");
            }
        } else {
            req.setAttribute("error", "请输入开始和结束时间");
        }
        forwardToBookingPage(req, resp);
    }
}