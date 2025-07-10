package com.yourcompany.dao;

import com.yourcompany.model.Department;
import java.util.List;

public interface DepartmentMapper {
    List<Department> findAll();
}