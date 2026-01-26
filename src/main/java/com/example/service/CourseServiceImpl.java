package com.example.service;

import com.example.model.Course;
import com.example.repository.CourseRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@Transactional
public class CourseServiceImpl implements CourseService {

    private final CourseRepository courseRepository;

    public CourseServiceImpl(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @Override
    public List<Course> getPublicCourses() {
        return courseRepository.findByStatus("PUBLIC");
    }
    @Override
    public List<Course> searchCourses(String keyword) {
        return courseRepository
                .findByTitleContainingIgnoreCaseAndStatus(keyword, "PUBLIC");
    }


    @Override
    public Course getCourseDetail(int id) {
        return courseRepository.findById(id).orElse(null);
    }
}

