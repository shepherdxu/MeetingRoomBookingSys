package com.yourcompany.service;

import com.yourcompany.dao.BookingMapper;
import com.yourcompany.dao.RoomMapper;
import com.yourcompany.dao.UserMapper;
import com.yourcompany.model.Booking;
import com.yourcompany.model.Room;
import com.yourcompany.model.User;
import com.yourcompany.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class BookingService {
    private final NotificationService notificationService = new NotificationService();

    public List<Room> findAvailableRooms(Date startTime, Date endTime) {
        // ... (代码无变化)
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper bookingMapper = session.getMapper(BookingMapper.class);
            RoomMapper roomMapper = session.getMapper(RoomMapper.class);

            List<Room> allRooms = roomMapper.findAll();
            List<Integer> bookedRoomIds = bookingMapper.findBookedRoomIds(startTime, endTime);

            if (bookedRoomIds == null || bookedRoomIds.isEmpty()) {
                return allRooms;
            }

            return allRooms.stream()
                    .filter(room -> !bookedRoomIds.contains(room.getRoomId()))
                    .collect(Collectors.toList());
        }
    }

    public boolean createBooking(Booking booking, List<Integer> attendeeIds) {
        // 使用事务来确保预约和参会人插入的原子性
        SqlSession session = MyBatisUtil.getSqlSession(false); // 关闭自动提交
        try {
            BookingMapper bookingMapper = session.getMapper(BookingMapper.class);
            RoomMapper roomMapper = session.getMapper(RoomMapper.class);
            UserMapper userMapper = session.getMapper(UserMapper.class);

            // 对于管理员，可以直接确认。对于员工，设置为待审批
            User requester = (User) booking.getRequester(); // 假设在Servlet中已设置
            if ("admin".equals(requester.getRole())) {
                booking.setStatus("confirmed");
            } else {
                booking.setStatus("pending");
            }
            // 1. 创建预约
            int affectedRows = bookingMapper.createBooking(booking);
            if (affectedRows == 0) {
                throw new RuntimeException("创建预约失败.");
            }

            // 2. 添加参会人 (包括预约者自己)
            if (attendeeIds != null && !attendeeIds.isEmpty()) {
                if (!attendeeIds.contains(booking.getRequesterId())) {
                    attendeeIds.add(booking.getRequesterId());
                }
                bookingMapper.addAttendees(booking.getBookingId(), attendeeIds);
            }

            // 新增：通知所有管理员
            List<User> admins = userMapper.findAllAdmins();
            String message = String.format("新会议室预约申请: [%s] by %s. 请及时审批.",
                    booking.getTitle(), booking.getRequester().getFullName());
            for (User admin : admins) {
                notificationService.createNotification(admin.getUserId(), message);
            }
            session.commit(); // 提交事务
            return true;
        } catch (Exception e) {
            session.rollback(); // 回滚事务
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }
    // 核心修改：根据管理员部门ID获取待审批列表
    public List<Booking> getPendingBookingsByDepartment(Integer adminDepartmentId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.findAllPendingByDepartment(adminDepartmentId);
        }
    }
    public List<Booking> getBookingsByUserId(int userId) {
        // ... (代码无变化)
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.findByUserId(userId);
        }
    }

    public boolean cancelBooking(int bookingId, int userId) {
        // ... (代码无变化)
        try (SqlSession session = MyBatisUtil.getSqlSession(true)) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.cancelBooking(bookingId, userId) > 0;
        }
    }

    // --- Admin functions ---
    public List<Booking> getPendingBookings() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.findAllPending();
        }
    }

    public boolean approveBooking(int bookingId) {
        return updateBookingStatus(bookingId, "confirmed");
    }

    public boolean rejectBooking(int bookingId) {
        return updateBookingStatus(bookingId, "cancelled"); // 或者 'rejected'
    }

    private boolean updateBookingStatus(int bookingId, String status) {
        try (SqlSession session = MyBatisUtil.getSqlSession(true)) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.updateBookingStatus(bookingId, status) > 0;
        }
    }

    public Booking getBookingById(Integer bookingId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.findById(bookingId);
        }
    }

}