package com.example.service;

import com.example.model.Course;
import java.util.List;

public interface CourseService {

    List<Course> getPublicCourses();

    List<Course> searchCourses(String keyword);

    Course getCourseDetail(int id);
}
