/**
* Meeting Room Booking System - Admin Dashboard Service
* @author Kyochilian
* @version 6.0
* @since 1.0
* @date 2025-7-10
* this class provides methods to retrieve data for the admin dashboard page.
* */
package com.yourcompany.service;

import com.google.gson.Gson;
import com.yourcompany.dao.BookingMapper;
import com.yourcompany.dao.UserMapper;
import com.yourcompany.model.Booking;
import com.yourcompany.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDashboardService {
    private final Gson gson = new Gson();
    
    public Map<String, Object> getApprovalsPageData() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            Map<String, Object> data = new HashMap<>();
            BookingMapper bookingMapper = session.getMapper(BookingMapper.class);

            // Pie Chart Data
            int pendingCount = bookingMapper.countPendingBookings();
            int processedTodayCount = bookingMapper.countTotalProcessedToday();
            Map<String, Integer> pieData = new HashMap<>();
            pieData.put("当前待审批", pendingCount);
            pieData.put("今日已审批", processedTodayCount);
            data.put("approvalStatusPieChart", gson.toJson(pieData));

            // Stats Cards Data
            Map<String, Object> pendingStats = bookingMapper.getPendingBookingStats();
            data.put("pendingCount", pendingStats.get("count"));
            data.put("pendingTotalHours", pendingStats.get("total_hours"));
            data.put("approvalHistory", bookingMapper.findRecentProcessed());
            // Line Chart Data (using daily booking counts as a proxy for trend)
            List<Map<String, Object>> dailyCounts = bookingMapper.getDailyBookingCounts();
            data.put("dailyTrendLineChart", gson.toJson(dailyCounts));

            return data;
        }
    }

    public Map<String, Object> getUsersPageData() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            Map<String, Object> data = new HashMap<>();
            UserMapper userMapper = session.getMapper(UserMapper.class);

            data.put("totalUsers", userMapper.countUsers());

            List<Map<String, Object>> byDept = userMapper.countUsersByDepartment();
            data.put("usersByDeptPieChart", gson.toJson(byDept));

            List<Map<String, Object>> byRole = userMapper.countUsersByRole();
            data.put("usersByRolePieChart", gson.toJson(byRole));

            return data;
        }
    }
    public Map<String, Object> getDashboardData() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper bookingMapper = session.getMapper(BookingMapper.class);
            Map<String, Object> data = new HashMap<>();

            // 今日已确认预约
            List<Booking> todaysBookings = bookingMapper.getConfirmedBookingsForToday();
            data.put("todaysBookings", todaysBookings);
            data.put("todaysBookingsCount", todaysBookings.size());


            return data;
        }
}}