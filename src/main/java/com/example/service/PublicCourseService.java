package com.example.service;

import com.example.model.Course;

import java.util.List;

public interface PublicCourseService {

    List<Course> getPublicCourses();

    List<Course> searchCourses(String keyword);

    Course getCourseDetail(int id);
}
