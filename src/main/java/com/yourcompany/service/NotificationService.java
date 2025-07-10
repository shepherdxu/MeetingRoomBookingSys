package com.yourcompany.service;

import com.yourcompany.dao.NotificationMapper;
import com.yourcompany.model.Notification;
import com.yourcompany.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class NotificationService {

    public void createNotification(Integer userId, String message) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            NotificationMapper mapper = session.getMapper(NotificationMapper.class);
            Notification notification = new Notification();
            notification.setUserId(userId);
            notification.setMessage(message);
            notification.setRead(false);
            mapper.insertNotification(notification);
            session.commit();
        }
    }

    public List<Notification> getUnreadNotifications(Integer userId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            NotificationMapper mapper = session.getMapper(NotificationMapper.class);
            return mapper.findUnreadByUserId(userId);
        }
    }

    public void markAsRead(Integer notificationId, Integer userId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            NotificationMapper mapper = session.getMapper(NotificationMapper.class);
            mapper.markAsRead(notificationId, userId);
            session.commit();
        }
    }
}