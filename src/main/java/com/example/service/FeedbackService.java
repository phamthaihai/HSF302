package com.example.service;

import com.example.dao.FeedbackDao;
import com.example.dao.CourseDao;
import com.example.entity.Course;
import com.example.entity.Feedback;
import com.example.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class FeedbackService {

    private final FeedbackDao feedbackDao;
    private final CourseDao courseDao;

    public FeedbackService(FeedbackDao feedbackDao, CourseDao courseDao) {
        this.feedbackDao = feedbackDao;
        this.courseDao = courseDao;
    }

    @Transactional(readOnly = true)
    public Feedback getMyFeedback(int userId, int courseId) {
        return feedbackDao.findByUserAndCourse(userId, courseId);
    }

    @Transactional
    public void submit(int userId, int courseId, int rating, String comment) {
        Course course = courseDao.findById(courseId);
        if (course == null) throw new RuntimeException("Course not found");

        Feedback f = feedbackDao.findByUserAndCourse(userId, courseId);
        if (f == null) {
            f = new Feedback();
            User u = new User(); u.setUserId(userId);
            f.setUser(u);
            f.setCourse(course);
            f.setCreatedAt(LocalDateTime.now());
        }
        f.setRating(rating);
        f.setComment(comment);
        feedbackDao.saveOrUpdate(f);
    }
}
