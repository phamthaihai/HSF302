package com.example.service;

import com.example.model.Course;
import com.example.repository.CourseRepository;
import com.example.repository.PaymentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudentCourseService {

    private final CourseRepository courseRepository;
    private final PaymentRepository paymentRepository;

    public StudentCourseService(CourseRepository courseRepository, PaymentRepository paymentRepository) {
        this.courseRepository = courseRepository;
        this.paymentRepository = paymentRepository;
    }

    @Transactional(readOnly = true)
    public List<Course> getMyCourses(int userId) {
        return courseRepository.findMyCourses(userId);
    }

    @Transactional(readOnly = true)
    public void requireRegistered(int userId, int courseId) {
        boolean ok = paymentRepository.existsByUser_UserIdAndCourse_CourseIdAndStatus(userId, courseId, "SUCCESS");
        if (!ok)
            throw new RuntimeException("You are not registered for this course.");
    }
}
