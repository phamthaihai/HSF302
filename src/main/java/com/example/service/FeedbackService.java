package com.example.service;

import com.example.model.Feedback;
import com.example.model.User;
import com.example.repository.CourseRepository;
import com.example.repository.FeedbackRepository;
import com.example.repository.UserAccountRepository; // 1. Import đúng
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class FeedbackService {

    @PersistenceContext
    private EntityManager entityManager;

    private final FeedbackRepository feedbackRepository;
    private final CourseRepository courseRepository;
    private final UserAccountRepository userRepository; // 2. Đổi tên biến

    // 3. Cập nhật Constructor
    public FeedbackService(FeedbackRepository feedbackRepository,
                           CourseRepository courseRepository,
                           UserAccountRepository userRepository) {
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

        // Dùng EntityManager để lấy reference User (giả sử Entity tên là User)
        var userRef = entityManager.getReference(User.class, userId);

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
