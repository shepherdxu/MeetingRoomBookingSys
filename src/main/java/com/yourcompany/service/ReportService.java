package com.yourcompany.service;

import com.yourcompany.dao.BookingMapper;
import com.yourcompany.model.Booking;
import com.yourcompany.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.Collections;
import java.util.List;

public class ReportService {

    public List<Booking> getTodaysBookings() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            BookingMapper mapper = session.getMapper(BookingMapper.class);
            return mapper.findTodaysBookings();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}