package com.example.service;

import com.example.model.Feedback;
import com.example.repository.CourseRepository;
import com.example.repository.FeedbackRepository;
import com.example.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final CourseRepository courseRepository;
    private final UserRepository userRepository;

    public FeedbackService(FeedbackRepository feedbackRepository,
                           CourseRepository courseRepository,
                           UserRepository userRepository) {
        this.feedbackRepository = feedbackRepository;
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public Feedback getMyFeedback(int userId, int courseId) {
        return feedbackRepository.findByUser_UserIdAndCourse_CourseId(userId, courseId).orElse(null);
    }

    @Transactional
    public void submit(int userId, int courseId, int rating, String comment) {
        var course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));
        var userRef = userRepository.getReferenceById(userId);

        Feedback f = feedbackRepository.findByUser_UserIdAndCourse_CourseId(userId, courseId)
                .orElseGet(() -> {
                    Feedback x = new Feedback();
                    x.setUser(userRef);
                    x.setCourse(course);
                    x.setCreatedAt(LocalDateTime.now());
                    return x;
                });

        f.setRating(rating);
        f.setComment(comment);
        feedbackRepository.save(f);
    }
}
