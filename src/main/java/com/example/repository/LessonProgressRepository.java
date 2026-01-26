package com.example.repository;

import com.example.model.LessonProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface LessonProgressRepository extends JpaRepository<LessonProgress, Integer> {

    Optional<LessonProgress> findByUser_UserIdAndLesson_LessonId(Integer userId, Integer lessonId);

    @Query("""
                select lp.lesson.lessonId
                from LessonProgress lp
                where lp.user.userId = :userId
                  and lp.lesson.course.courseId = :courseId
                  and lp.isCompleted = true
            """)
    List<Integer> findCompletedLessonIds(@Param("userId") Integer userId,
                                         @Param("courseId") Integer courseId);

    @Query("""
                select count(lp)
                from LessonProgress lp
                where lp.user.userId = :userId
                  and lp.lesson.course.courseId = :courseId
                  and lp.isCompleted = true
            """)
    long countCompletedInCourse(@Param("userId") Integer userId,
                                @Param("courseId") Integer courseId);
}
