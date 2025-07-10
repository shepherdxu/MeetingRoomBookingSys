package com.yourcompany.dao;

import com.yourcompany.model.Booking;
import com.yourcompany.model.Location;
import com.yourcompany.model.Room;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

/**
 * Mapper interface for Room operations.
 * This interface defines the methods for interacting with the 'rooms' and 'locations' tables.
 */
public interface RoomMapper {

    /**
     * Inserts a new room record into the database.
     * The generated room ID will be set back into the Room object.
     *
     * @param room The Room object to be created.
     * @return The number of rows affected (should be 1 on successful insert).
     */
    int createRoom(Room room);

    /**
     * Finds a room by its ID, including its associated location.
     *
     * @param roomId The ID of the room to search for.
     * @return The Room object if found, otherwise null.
     */
    Room findById(@Param("roomId") int roomId);

    /**
     * Retrieves a list of all rooms, including their associated locations.
     *
     * @return A list of Room objects.
     */
    List<Room> findAll();

    /**
     * Updates an existing room's details.
     *
     * @param room The Room object with updated information.
     * @return The number of rows affected (should be 1 on successful update).
     */
    int updateRoom(Room room);

    /**
     * Deletes a room from the database by its ID.
     *
     * @param roomId The ID of the room to delete.
     * @return The number of rows affected (should be 1 on successful delete).
     */
    int deleteRoom(@Param("roomId") int roomId);

    /**
     * Retrieves a list of all locations.
     *
     * @return A list of Location objects.
     */
    List<Location> findAllLocations();

    // --- 以下是为统计功能新增的方法 ---

    /**
     * Counts the number of rooms per location.
     *
     * @return A list of maps, where each map contains 'locationName' and 'roomCount'.
     */
    List<Map<String, Object>> countRoomsByLocation();

    /**
     * Calculates the total capacity of all rooms.
     *
     * @return The sum of capacities of all rooms.
     */
    Integer sumTotalCapacity();

    /**
     * Retrieves all amenity strings from all rooms.
     * This is used for processing amenity statistics in the service layer.
     *
     * @return A list of strings, where each string is the 'amenities' field of a room.
     */
    List<String> findAllAmenitiesStrings();

    /**
     * Counts the total number of rooms in the system.
     *
     * @return The total count of rooms.
     */
    int countTotalRooms();

    List<Booking> findActiveBookings();


    List<Room> findAllWithSearch();
}