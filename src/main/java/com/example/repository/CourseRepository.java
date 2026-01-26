package com.example.repository;

import com.example.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course, Integer> {

    // Lấy các khóa học user đã mua (payment SUCCESS)
    @Query("""
                select distinct p.course
                from Payment p
                where p.user.userId = :userId and p.status = 'SUCCESS'
            """)
    List<Course> findMyCourses(@Param("userId") Integer userId);
}
