package com.example.repository;

import com.example.model.Certificate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CertificateRepository extends JpaRepository<Certificate, Integer> {

    Optional<Certificate> findByUser_UserIdAndCourse_CourseId(Integer userId, Integer courseId);
}
