package com.example.repository;

import com.example.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {

    List<Lesson> findByCourse_CourseIdOrderByLessonIdAsc(Integer courseId);

    long countByCourse_CourseId(Integer courseId);
}
