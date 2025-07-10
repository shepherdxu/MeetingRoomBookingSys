// LocationMapper.java
package com.yourcompany.dao;

import com.yourcompany.model.Location;
import java.util.List;

/**
 * Mapper interface for Location operations.
 * This interface defines the methods for interacting with the 'locations' table in the database.
 */
public interface LocationMapper {

    /**
     * Retrieves a list of all locations from the database.
     *
     * @return A list of Location objects.
     */
    List<Location> findAll();
}
