package com.example.service;

import com.example.model.Course;
import com.example.repository.PublicCourseRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@Transactional
public class PublicCourseServiceImpl implements PublicCourseService {

    private final PublicCourseRepository publicCourseRepository;

    public PublicCourseServiceImpl(PublicCourseRepository publicCourseRepository) {
        this.publicCourseRepository = publicCourseRepository;
    }

    @Override
    public List<Course> getPublicCourses() {
        return publicCourseRepository.findByStatus("PUBLIC");
    }
    @Override
    public List<Course> searchCourses(String keyword) {
        return publicCourseRepository
                .findByTitleContainingIgnoreCaseAndStatus(keyword, "PUBLIC");
    }


    @Override
    public Course getCourseDetail(int id) {
        return publicCourseRepository.findById(id).orElse(null);
    }
}

