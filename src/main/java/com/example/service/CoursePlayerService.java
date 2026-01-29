package com.example.service;

import com.example.model.Lesson;
import com.example.model.LessonProgress;
import com.example.model.User;
import com.example.repository.LessonProgressRepository;
import com.example.repository.LessonRepository;
import com.example.repository.UserAccountRepository; // 1. Đã sửa import đúng
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CoursePlayerService {

    @PersistenceContext
    private EntityManager entityManager;

    private final LessonRepository lessonRepository;
    private final LessonProgressRepository progressRepository;
    private final UserAccountRepository userRepository; // 2. Đổi tên class Repository

    // 3. Cập nhật Constructor
    public CoursePlayerService(LessonRepository lessonRepository,
                               LessonProgressRepository progressRepository,
                               UserAccountRepository userRepository) {
        this.lessonRepository = lessonRepository;
        this.progressRepository = progressRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public List<Lesson> getLessons(int courseId) {
        return lessonRepository.findByCourse_CourseIdOrderByLessonIdAsc(courseId);
    }

    @Transactional(readOnly = true)
    public List<Integer> getCompletedLessonIds(int userId, int courseId) {
        return progressRepository.findCompletedLessonIds(userId, courseId);
    }

    @Transactional
    public void markCompleted(int userId, int lessonId) {
        var lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new RuntimeException("Lesson not found"));

        // Lưu ý: Đảm bảo bạn có class User trong package model.
        // Nếu tên entity là UserAccount thì sửa User.class thành UserAccount.class
        var userRef = entityManager.getReference(User.class, userId);

        LessonProgress lp = progressRepository
                .findByUser_UserIdAndLesson_LessonId(userId, lessonId)
                .orElseGet(() -> {
                    LessonProgress x = new LessonProgress();
                    x.setUser(userRef);
                    x.setLesson(lesson);
                    x.setIsCompleted(false);
                    return x;
                });

        lp.setIsCompleted(true);
        lp.setCompletedAt(LocalDateTime.now());
        progressRepository.save(lp);
    }
}