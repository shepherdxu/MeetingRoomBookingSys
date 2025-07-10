package com.yourcompany.controller;

import com.yourcompany.model.Booking;
import com.yourcompany.model.Room;
import com.yourcompany.model.User;
import com.yourcompany.service.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    private final RoomService roomService = new RoomService();
    private final UserService userService = new UserService();
    private final NotificationService notificationService = new NotificationService();
    private final AdminDashboardService adminDashboardService = new AdminDashboardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "approvals";

        req.setAttribute("page", "admin"); // For sidebar highlight
        User adminUser = (User) req.getSession().getAttribute("user");
        switch (action) {
            case "manageRooms":
                String roomSearch = req.getParameter("roomSearch");
                String locationIdStr = req.getParameter("locationId");
                Integer locationId = (locationIdStr != null && !locationIdStr.isEmpty()) ? Integer.parseInt(locationIdStr) : null;

                List<Room> rooms = roomService.getAllRooms();
                req.setAttribute("rooms", rooms);
                int totalCapacity = rooms.stream().mapToInt(Room::getCapacity).sum();
                int totalAmenities = rooms.stream()
                        .mapToInt(r -> r.getAmenities() == null ? 0 : r.getAmenities().split("[，,;；]").length)
                        .sum();
                req.setAttribute("rooms", roomService.getRooms(roomSearch, locationId));
                req.setAttribute("locations", roomService.getAllLocations()); // For dropdown
                req.setAttribute("roomSearch", roomSearch); // Retain search value
                req.setAttribute("locationId", locationId); // Retain location value
                req.setAttribute("totalCapacity", totalCapacity);
                req.setAttribute("totalAmenities", totalAmenities);
                forwardToLayout(req, resp, "会议室管理", "/WEB-INF/views/content/admin/manage-rooms-content.jsp");
                break;
            case "addRoomForm":
                req.setAttribute("locations", roomService.getAllLocations());
                forwardToLayout(req, resp, "新增会议室", "/WEB-INF/views/content/admin/add-edit-room-content.jsp");
                break;
            case "editRoomForm":
                req.setAttribute("room", roomService.getRoomById(Integer.parseInt(req.getParameter("roomId"))));
                req.setAttribute("locations", roomService.getAllLocations());
                forwardToLayout(req, resp, "编辑会议室", "/WEB-INF/views/content/admin/add-edit-room-content.jsp");
                break;
            case "manageUsers":
                String userSearch = req.getParameter("userSearch");
                String deptIdStr = req.getParameter("departmentId");
                Integer departmentId = (deptIdStr != null && !deptIdStr.isEmpty()) ? Integer.parseInt(deptIdStr) : null;
                req.setAttribute("users", userService.getUsers(userSearch, departmentId));
                req.setAttribute("departments", userService.getAllDepartments()); // For dropdown
                req.setAttribute("userSearch", userSearch); // Retain search value
                req.setAttribute("departmentId", departmentId); // Retain filter value
                req.setAttribute("users", userService.getAllUsers());
                req.setAttribute("vizData", adminDashboardService.getUsersPageData());
                forwardToLayout(req, resp, "员工管理", "/WEB-INF/views/content/admin/manage-users-content.jsp");
                break;
            case "editUserForm":
                req.setAttribute("userToEdit", userService.getUserById(Integer.parseInt(req.getParameter("userId"))));
                req.setAttribute("departments", userService.getAllDepartments());
                forwardToLayout(req, resp, "编辑员工", "/WEB-INF/views/content/admin/edit-user-content.jsp");
                break;
            case "approvals":
            default:
                req.setAttribute("pendingBookings", bookingService.getPendingBookingsByDepartment(adminUser.getDepartment().getDepartmentId()));
                req.setAttribute("vizData", adminDashboardService.getApprovalsPageData());
                forwardToLayout(req, resp, "申请审批", "/WEB-INF/views/content/admin/approvals-content.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        int bookingId = Integer.parseInt(req.getParameter("bookingId") != null ? req.getParameter("bookingId") : "0");
        Booking booking = bookingService.getBookingById(bookingId);

        switch (action) {
            case "approve":
                bookingService.approveBooking(bookingId);
                if (booking != null) {
                    String message = String.format("您的预约 [%s] 已被批准。", booking.getTitle());
                    notificationService.createNotification(booking.getRequesterId(), message);
                }
                resp.sendRedirect(req.getContextPath() + "/admin?action=approvals&message=approved");
                break;
            case "reject":
                bookingService.rejectBooking(bookingId);
                if (booking != null) {
                    String message = String.format("您的预约 [%s] 已被驳回。", booking.getTitle());
                    notificationService.createNotification(booking.getRequesterId(), message);
                }
                resp.sendRedirect(req.getContextPath() + "/admin?action=approvals&message=rejected");
                break;
            case "saveRoom": handleSaveRoom(req, resp); break;
            case "deleteRoom":
                roomService.deleteRoom(Integer.parseInt(req.getParameter("roomId")));
                resp.sendRedirect(req.getContextPath() + "/admin?action=manageRooms&message=deleted");
                break;
            case "saveUser": handleSaveUser(req, resp); break;
            case "deleteUser":
                userService.deleteUser(Integer.parseInt(req.getParameter("userId")));
                resp.sendRedirect(req.getContextPath() + "/admin?action=manageUsers&message=deleted");
                break;
        }
    }

    private void forwardToLayout(HttpServletRequest req, HttpServletResponse resp, String title, String contentPage) throws ServletException, IOException {
        req.setAttribute("title", title);
        req.setAttribute("contentPage", contentPage);
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    private void handleSaveRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Room room = new Room();
        room.setRoomName(req.getParameter("roomName"));
        room.setCapacity(Integer.parseInt(req.getParameter("capacity")));
        room.setAmenities(req.getParameter("amenities"));
        room.setLocationId(Integer.parseInt(req.getParameter("locationId")));
        String roomIdStr = req.getParameter("roomId");
        if (roomIdStr == null || roomIdStr.isEmpty()) {
            roomService.addRoom(room);
        } else {
            room.setRoomId(Integer.parseInt(roomIdStr));
            roomService.updateRoom(room);
        }
        resp.sendRedirect(req.getContextPath() + "/admin?action=manageRooms&message=saved");
    }

    private void handleSaveUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = new User();
        user.setUserId(Integer.parseInt(req.getParameter("userId")));
        user.setFullName(req.getParameter("fullName"));
        user.setUsername(req.getParameter("username"));
        user.setDepartmentId(Integer.parseInt(req.getParameter("departmentId")));
        user.setRole(req.getParameter("role"));
        userService.updateUser(user);
        String password = req.getParameter("password");
        if(password != null && !password.isEmpty()){
            userService.updatePassword(user.getUserId(), password);
        }
        resp.sendRedirect(req.getContextPath() + "/admin?action=manageUsers&message=saved");
    }
}
