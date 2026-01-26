package com.example.repository;

import com.example.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    boolean existsByUser_UserIdAndCourse_CourseIdAndStatus(Integer userId, Integer courseId, String status);
}
