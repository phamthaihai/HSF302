package com.example.service;

import com.example.model.Certificate;
import com.example.repository.CertificateRepository;
import com.example.repository.CourseRepository;
import com.example.repository.LessonProgressRepository;
import com.example.repository.LessonRepository;
import com.example.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class CertificateService {

    private final CertificateRepository certificateRepository;
    private final LessonRepository lessonRepository;
    private final LessonProgressRepository progressRepository;
    private final CourseRepository courseRepository;
    private final UserRepository userRepository;

    public CertificateService(CertificateRepository certificateRepository,
                              LessonRepository lessonRepository,
                              LessonProgressRepository progressRepository,
                              CourseRepository courseRepository,
                              UserRepository userRepository) {
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
        var userRef = userRepository.getReferenceById(userId);

        Certificate c = new Certificate();
        c.setUser(userRef);
        c.setCourse(course);
        c.setIssueDate(LocalDateTime.now());
        c.setCertificateCode("STUDYHUB-" + UUID.randomUUID());

        return certificateRepository.save(c);
    }
}
