package com.yourcompany.dao;

import com.yourcompany.model.Booking;
import org.apache.ibatis.annotations.Param;
import java.util.Date;
import java.util.List;
import java.util.Map; // Import Map for getDailyBookingCounts

/**
 * Mapper interface for Booking operations.
 * This interface defines the methods for interacting with the 'bookings' and 'booking_attendees' tables.
 */
public interface BookingMapper {

    /**
     * Inserts a new booking record into the database.
     * The generated booking ID will be set back into the Booking object.
     *
     * @param booking The Booking object to be created.
     * @return The number of rows affected (should be 1 on successful insert).
     */
    int createBooking(Booking booking);
    List<Booking> getConfirmedBookingsForToday();

    /**
     * Adds attendees to a specific booking.
     * This method is used to insert multiple records into the `booking_attendees` table.
     *
     * @param bookingId The ID of the booking to which attendees are being added.
     * @param userIds A list of user IDs (attendees) to be associated with the booking.
     * @return The number of rows affected.
     */
    int addAttendees(@Param("bookingId") int bookingId, @Param("userIds") List<Integer> userIds);

    /**
     * Finds the IDs of rooms that are booked within a given time range.
     * Bookings with 'confirmed' or 'pending' status are considered.
     *
     * @param startTime The start time of the period to check.
     * @param endTime The end time of the period to check.
     * @return A list of room IDs that are booked.
     */
    List<Integer> findBookedRoomIds(@Param("startTime") Date startTime, @Param("endTime") Date endTime);

    /**
     * Retrieves a list of bookings made by a specific user.
     * Includes details of the room and the requester, and attendees.
     *
     * @param userId The ID of the user whose bookings are to be retrieved.
     * @return A list of Booking objects.
     */
    List<Booking> findByUserId(@Param("userId") int userId);

    /**
     * Cancels a specific booking for a given user.
     * The status of the booking will be updated to 'cancelled'.
     *
     * @param bookingId The ID of the booking to cancel.
     * @param userId The ID of the user requesting the cancellation (for security/verification).
     * @return The number of rows affected (should be 1 on successful cancellation).
     */
    int cancelBooking(@Param("bookingId") int bookingId, @Param("userId") int userId);

    /**
     * Retrieves a list of bookings that are currently in 'pending' status.
     * This is typically used by administrators for approval.
     * Includes details of the room and the requester, and attendees.
     *
     * @return A list of Booking objects with 'pending' status.
     */
    List<Booking> findAllPending();

    /**
     * Updates the status of a specific booking.
     *
     * @param bookingId The ID of the booking to update.
     * @param status The new status to set (e.g., 'confirmed', 'cancelled', 'rejected').
     * @return The number of rows affected (should be 1 on successful update).
     */
    int updateBookingStatus(@Param("bookingId") int bookingId, @Param("status") String status);

    // --- 以下是为 DashboardService 新增的方法 ---

    /**
     * Counts the number of confirmed bookings for today.
     * Used for dashboard statistics.
     *
     * @return The count of today's confirmed bookings.
     */
    int countTodaysBookings();

    /**
     * Counts the number of bookings with 'pending' status.
     * Used for dashboard statistics (e.g., pending requests).
     *
     * @return The count of pending bookings.
     */
    int countPendingBookings();

    /**
     * Finds the IDs of rooms that are currently in use (confirmed status and current time is within booking range).
     * Used for dashboard room status.
     *
     * @return A list of room IDs that are currently in use.
     */
    List<Integer> findRoomsInUseNow();

    /**
     * Retrieves a list of confirmed bookings for today, including room and requester details.
     * Used for the admin dashboard's "today's bookings" section.
     *
     * @return A list of Booking objects for today's confirmed bookings.
     */
    List<Booking> findTodaysBookings();

    /**
     * Counts the total number of bookings that have been processed (confirmed or rejected) today.
     *
     * @return The count of processed bookings today.
     */
    int countTotalProcessedToday();

    /**
     * Retrieves daily booking counts for the last 7 days.
     *
     * @return A list of maps, where each map contains 'date' (String) and 'count' (Long).
     */
    List<Map<String, Object>> getDailyBookingCounts();
    Booking findById(@Param("bookingId") int bookingId);
    Map<String, Object> getPendingBookingStats();
    List<Booking> findRecentProcessed();
    List<Booking> findActiveBookings();

    List<Booking> findAllPendingByDepartment(Integer adminDepartmentId);
}