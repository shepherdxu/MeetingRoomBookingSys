package com.yourcompany.controller;

import com.yourcompany.model.Booking;
import com.yourcompany.service.ReportService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ReportServlet extends HttpServlet {
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String reportType = req.getParameter("type");

        if ("todays_bookings".equals(reportType)) {
            resp.setContentType("text/csv");
            resp.setCharacterEncoding("UTF-8");
            resp.setHeader("Content-Disposition", "attachment; filename=\"todays_bookings.csv\"");

            List<Booking> bookings = reportService.getTodaysBookings();

            PrintWriter writer = resp.getWriter();
            // CSV Header
            writer.println("主题,会议室,申请人,开始时间,结束时间,状态");

            // CSV Data
            for (Booking booking : bookings) {
                writer.printf("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                        booking.getTitle(),
                        booking.getRoom().getRoomName(),
                        booking.getRequester().getFullName(),
                        booking.getStartTime().toString(),
                        booking.getEndTime().toString(),
                        booking.getStatus()
                );
            }
            writer.flush();
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "未知的报表类型");
        }
    }
}