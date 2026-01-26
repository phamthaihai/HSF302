package com.example.repository;

import com.example.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface CourseRepository extends JpaRepository<Course, Integer> {

    List<Course> findByStatus(String status);

    List<Course> findByTitleContainingIgnoreCaseAndStatus(
            String keyword,
            String status
    );
}


