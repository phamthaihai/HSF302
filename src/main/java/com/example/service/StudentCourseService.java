package com.example.service;

import com.example.dao.CourseDao;
import com.example.dao.PaymentDao;
import com.example.entity.Course;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudentCourseService {

    private final CourseDao courseDao;
    private final PaymentDao paymentDao;

    public StudentCourseService(CourseDao courseDao, PaymentDao paymentDao) {
        this.courseDao = courseDao;
        this.paymentDao = paymentDao;
    }

    @Transactional(readOnly = true)
    public List<Course> getMyCourses(int userId) {
        return courseDao.findMyCourses(userId);
    }

    @Transactional(readOnly = true)
    public void requireRegistered(int userId, int courseId) {
        if (!paymentDao.hasSuccessfulPayment(userId, courseId)) {
            throw new RuntimeException("You are not registered for this course.");
        }
    }
}
