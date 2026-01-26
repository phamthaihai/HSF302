package com.example.repository;

import com.example.model.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FeedbackRepository extends JpaRepository<Feedback, Integer> {

    Optional<Feedback> findByUser_UserIdAndCourse_CourseId(Integer userId, Integer courseId);
}
