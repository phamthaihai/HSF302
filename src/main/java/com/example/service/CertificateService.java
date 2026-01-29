package com.example.service;

import com.example.model.Certificate;
import com.example.model.User;
import com.example.repository.CertificateRepository;
import com.example.repository.CourseRepository;
import com.example.repository.LessonProgressRepository;
import com.example.repository.LessonRepository;
import com.example.repository.UserAccountRepository; // 1. Import đúng
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class CertificateService {

    @PersistenceContext
    private EntityManager entityManager;

    private final CertificateRepository certificateRepository;
    private final LessonRepository lessonRepository;
    private final LessonProgressRepository progressRepository;
    private final CourseRepository courseRepository;
    private final UserAccountRepository userRepository; // 2. Đổi tên ở đây

    // 3. Cập nhật Constructor
    public CertificateService(CertificateRepository certificateRepository,
                              LessonRepository lessonRepository,
                              LessonProgressRepository progressRepository,
                              CourseRepository courseRepository,
                              UserAccountRepository userRepository) {
        this.certificateRepository = certificateRepository;
        this.lessonRepository = lessonRepository;
        this.progressRepository = progressRepository;
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public Certificate issueIfEligible(int userId, int courseId) {
        // đã có rồi thì trả luôn
        var existing = certificateRepository.findByUser_UserIdAndCourse_CourseId(userId, courseId);
        if (existing.isPresent())
            return existing.get();

        long total = lessonRepository.countByCourse_CourseId(courseId);
        long completed = progressRepository.countCompletedInCourse(userId, courseId);

        // chưa đủ điều kiện
        if (total == 0 || completed < total)
            return null;

        var course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        // Sử dụng EntityManager để lấy reference User thay vì query DB
        var userRef = entityManager.getReference(User.class, userId);

        Certificate c = new Certificate();
        c.setUser(userRef);
        c.setCourse(course);
        c.setIssueDate(LocalDateTime.now());
        c.setCertificateCode("STUDYHUB-" + UUID.randomUUID());

        return certificateRepository.save(c);
    }
}