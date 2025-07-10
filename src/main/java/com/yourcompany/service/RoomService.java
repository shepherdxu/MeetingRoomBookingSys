package com.yourcompany.service;

import com.yourcompany.dao.RoomMapper;
import com.yourcompany.model.Location;
import com.yourcompany.model.Room;
import com.yourcompany.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class RoomService {

    /**
     * Adds a new room to the database.
     *
     * @param room The Room object to be added.
     * @return true if the room was successfully added, false otherwise.
     */
    public boolean addRoom(Room room) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) {
            RoomMapper roomMapper = sqlSession.getMapper(RoomMapper.class);
            return roomMapper.createRoom(room) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    // 核心修改：支持带条件的查询
    public List<Room> getRooms(String searchName, Integer locationId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            RoomMapper mapper = session.getMapper(RoomMapper.class);
            return mapper.findAllWithSearch();
        }
    }
    /**
     * Retrieves a room by its ID.
     *
     * @param roomId The ID of the room to retrieve.
     * @return The Room object if found, otherwise null.
     */
    public Room getRoomById(int roomId) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession()) {
            RoomMapper roomMapper = sqlSession.getMapper(RoomMapper.class);
            return roomMapper.findById(roomId);
        }
    }

    /**
     * Retrieves a list of all rooms.
     *
     * @return A list of Room objects.
     */
    public List<Room> getAllRooms() {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession()) {
            RoomMapper roomMapper = sqlSession.getMapper(RoomMapper.class);
            return roomMapper.findAll();
        }
    }

    /**
     * Updates an existing room's details.
     *
     * @param room The Room object with updated information.
     * @return true if the room was successfully updated, false otherwise.
     */
    public boolean updateRoom(Room room) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) {
            RoomMapper roomMapper = sqlSession.getMapper(RoomMapper.class);
            return roomMapper.updateRoom(room) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a room by its ID.
     *
     * @param roomId The ID of the room to delete.
     * @return true if the room was successfully deleted, false otherwise.
     */
    public boolean deleteRoom(int roomId) {
        try (SqlSession sqlSession = MyBatisUtil.getSqlSession(true)) {
            RoomMapper roomMapper = sqlSession.getMapper(RoomMapper.class);
            return roomMapper.deleteRoom(roomId) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves a list of all locations.
     *
     * @return A list of Location objects.
     */
    public List<Location> getAllLocations() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            RoomMapper mapper = session.getMapper(RoomMapper.class);
            return mapper.findAllLocations();
        }
    }

    // --- 以下是为统计功能新增的方法 ---

    /**
     * Gets the count of rooms grouped by location.
     *
     * @return A list of maps, where each map contains 'locationName' and 'roomCount'.
     */
    public List<Map<String, Object>> getRoomCountByLocation() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            RoomMapper mapper = session.getMapper(RoomMapper.class);
            return mapper.countRoomsByLocation();
        }
    }

    /**
     * Calculates the total capacity of all rooms.
     *
     * @return The total capacity.
     */
    public int getTotalCapacity() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            RoomMapper mapper = session.getMapper(RoomMapper.class);
            Integer totalCapacity = mapper.sumTotalCapacity();
            return totalCapacity != null ? totalCapacity : 0;
        }
    }

    /**
     * Gets the statistics of amenities across all rooms.
     * Parses comma-separated amenity strings and counts each unique amenity.
     *
     * @return A map where keys are amenity names and values are their counts.
     */
    public Map<String, Long> getAmenityStatistics() {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            RoomMapper mapper = session.getMapper(RoomMapper.class);
            List<String> amenityStrings = mapper.findAllAmenitiesStrings();

            Map<String, Long> amenityCounts = new HashMap<>();
            for (String amenityString : amenityStrings) {
                // Split by comma, trim whitespace, filter empty strings
                Arrays.stream(amenityString.split(","))
                        .map(String::trim)
                        .filter(s -> !s.isEmpty())
                        .forEach(amenity -> amenityCounts.merge(amenity, 1L, Long::sum));
            }
            return amenityCounts;
        }
    }

    /**
     * Calculates the total number of meeting rooms.
     * This is derived from the size of the list returned by getAllRooms().
     *
     * @return The total count of rooms.
     */
    public int getTotalRoomCount() {
        // Reuse the existing getAllRooms method to get all rooms and count them
        List<Room> allRooms = getAllRooms();
        return allRooms != null ? allRooms.size() : 0;
    }

    /**
     * Calculates the total number of all distinct amenities across all rooms.
     * This sums up the counts of all unique amenities from getAmenityStatistics().
     *
     * @return The total count of all amenities.
     */
    public long getTotalAmenitiesCount() {
        // Reuse the existing getAmenityStatistics method
        Map<String, Long> amenityStats = getAmenityStatistics();
        // Sum all the values (counts) in the map
        return amenityStats.values().stream().mapToLong(Long::longValue).sum();
    }
}
