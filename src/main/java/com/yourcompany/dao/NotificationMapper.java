package com.yourcompany.dao;

import com.yourcompany.model.Notification;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NotificationMapper {

    /**
     * Inserts a new notification record into the database.
     *
     * @param notification The Notification object containing the data to be inserted.
     */
    void insertNotification(Notification notification);

    /**
     * Finds all unread notifications for a specific user.
     * Notifications are ordered by creation date in descending order.
     *
     * @param userId The ID of the user.
     * @return A list of unread Notification objects.
     */
    List<Notification> findUnreadByUserId(@Param("userId") Integer userId);

    /**
     * Marks a specific notification as read for a given user.
     *
     * @param notificationId The ID of the notification to mark as read.
     * @param userId The ID of the user who owns the notification.
     */
    void markAsRead(@Param("notificationId") Integer notificationId, @Param("userId") Integer userId);
}
