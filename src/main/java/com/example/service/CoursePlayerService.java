package com.example.service;

import com.example.dao.LessonDao;
import com.example.dao.LessonProgressDao;
import com.example.entity.Lesson;
import com.example.entity.LessonProgress;
import com.example.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CoursePlayerService {

    private final LessonDao lessonDao;
    private final LessonProgressDao progressDao;

    public CoursePlayerService(LessonDao lessonDao, LessonProgressDao progressDao) {
        this.lessonDao = lessonDao;
        this.progressDao = progressDao;
    }

    @Transactional(readOnly = true)
    public List<Lesson> getLessons(int courseId) {
        return lessonDao.findByCourse(courseId);
    }

    @Transactional(readOnly = true)
    public List<Integer> getCompletedLessonIds(int userId, int courseId) {
        return progressDao.findCompletedLessonIds(userId, courseId);
    }

    @Transactional
    public void markCompleted(int userId, int lessonId) {
        Lesson lesson = lessonDao.findById(lessonId);
        if (lesson == null) throw new RuntimeException("Lesson not found");

        LessonProgress lp = progressDao.findByUserAndLesson(userId, lessonId);
        if (lp == null) {
            lp = new LessonProgress();
            User u = new User();
            u.setUserId(userId);
            lp.setUser(u);
            lp.setLesson(lesson);
        }
        lp.setIsCompleted(true);
        lp.setCompletedAt(LocalDateTime.now());
        progressDao.saveOrUpdate(lp);
    }
}
