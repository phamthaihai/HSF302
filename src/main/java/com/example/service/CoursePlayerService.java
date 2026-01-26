package com.example.service;

import com.example.model.Lesson;
import com.example.model.LessonProgress;
import com.example.repository.LessonProgressRepository;
import com.example.repository.LessonRepository;
import com.example.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CoursePlayerService {

    private final LessonRepository lessonRepository;
    private final LessonProgressRepository progressRepository;
    private final UserRepository userRepository;

    public CoursePlayerService(LessonRepository lessonRepository,
                               LessonProgressRepository progressRepository,
                               UserRepository userRepository) {
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

        var userRef = userRepository.getReferenceById(userId);

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
