package com.yourcompany.service;

import com.google.gson.Gson;
import com.yourcompany.dao.BookingMapper;
import com.yourcompany.dao.RoomMapper;
import com.yourcompany.model.Booking;
import com.yourcompany.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class DashboardService {
    private final Gson gson = new Gson();

    public Map<String, Object> getDashboardData() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            Map<String, Object> data = new HashMap<>();
            BookingMapper bookingMapper = session.getMapper(BookingMapper.class);
            RoomMapper roomMapper = session.getMapper(RoomMapper.class);

            // 1. 获取统计卡片数据
            int todaysBookingsCount = bookingMapper.countTodaysBookings();
            int pendingRequestsCount = bookingMapper.countPendingBookings();
            int totalRooms = roomMapper.countTotalRooms();
            int roomsInUseCount = bookingMapper.findRoomsInUseNow().size();
            int availableRoomsCount = totalRooms - roomsInUseCount;
            List<Booking> activeBookings = bookingMapper.findActiveBookings();

            data.put("todaysBookingsCount", todaysBookingsCount);
            data.put("pendingRequestsCount", pendingRequestsCount);
            data.put("availableRoomsCount", availableRoomsCount);
            data.put("totalRooms", totalRooms);

            // 2. 获取今日预定信息 (for table)
            data.put("todaysBookings", bookingMapper.findTodaysBookings());
            // 2. 获取会议室实时状态
            data.put("allRooms", roomMapper.findAll());
            Map<Integer, Booking> activeBookingsMap = activeBookings.stream()
                    .collect(Collectors.toMap(
                            b -> b.getRoom().getRoomId(),   // 从 association 的 Room 对象里读 roomId
                            Function.identity(),
                            (existing, replacement) -> existing
                    ));
            data.put("activeBookingsMap", activeBookingsMap);
            // 3. 准备图表数据
            // 饼图1: 会议室状态
            Map<String, Integer> roomStatusData = new HashMap<>();
            roomStatusData.put("使用中", roomsInUseCount);
            roomStatusData.put("空闲", availableRoomsCount);
            data.put("roomStatusChartData", gson.toJson(roomStatusData));

            // 饼图2: 预定状态
            int totalProcessedToday = bookingMapper.countTotalProcessedToday();
            Map<String, Integer> bookingStatusData = new HashMap<>();
            bookingStatusData.put("待审批", pendingRequestsCount);
            bookingStatusData.put("今日已处理", totalProcessedToday);
            data.put("bookingStatusChartData", gson.toJson(bookingStatusData));

            List<Map<String, Object>> dailyCounts = bookingMapper.getDailyBookingCounts();
            for (Map<String, Object> record : dailyCounts) {
                Object date = record.get("date");
                if (date instanceof java.sql.Date || date instanceof java.time.LocalDate) {
                    record.put("date", date.toString()); // 确保是 yyyy-MM-dd 格式字符串
                } else if (date != null) {
                    record.put("date", date.toString());
                }
            }

            data.put("dailyBookingChartData", gson.toJson(dailyCounts));


            return data;
        }
    }
}