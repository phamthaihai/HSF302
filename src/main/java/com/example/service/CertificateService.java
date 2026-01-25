package com.example.service;

import com.example.dao.CertificateDao;
import com.example.dao.CourseDao;
import com.example.dao.LessonDao;
import com.example.dao.LessonProgressDao;
import com.example.entity.Certificate;
import com.example.entity.Course;
import com.example.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class CertificateService {

    private final CertificateDao certificateDao;
    private final LessonDao lessonDao;
    private final LessonProgressDao progressDao;
    private final CourseDao courseDao;

    public CertificateService(CertificateDao certificateDao, LessonDao lessonDao,
                              LessonProgressDao progressDao, CourseDao courseDao) {
        this.certificateDao = certificateDao;
        this.lessonDao = lessonDao;
        this.progressDao = progressDao;
        this.courseDao = courseDao;
    }

    @Transactional
    public Certificate issueIfEligible(int userId, int courseId) {
        Certificate existing = certificateDao.findByUserAndCourse(userId, courseId);
        if (existing != null) return existing;

        long total = lessonDao.countLessonsInCourse(courseId);
        long completed = progressDao.countCompletedInCourse(userId, courseId);

        if (total == 0 || completed < total) {
            return null; // chưa đủ điều kiện
        }

        Course course = courseDao.findById(courseId);
        if (course == null) throw new RuntimeException("Course not found");

        Certificate c = new Certificate();
        User u = new User();
        u.setUserId(userId);
        c.setUser(u);
        c.setCourse(course);
        c.setIssueDate(LocalDateTime.now());
        c.setCertificateCode("STUDYHUB-" + UUID.randomUUID());

        certificateDao.save(c);
        return c;
    }
}
