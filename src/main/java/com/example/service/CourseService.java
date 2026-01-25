package com.example.service;

import com.example.model.Course;
import com.example.model.Lesson;
import com.example.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CourseService {
    @Autowired
    private CourseRepository repo;

    public List<Course> getAllCourses() { return repo.findAll(); }
    public Course getCourseDetail(int id) { return repo.findById(id); }
    public void addCourse(Course c) { repo.insertCourse(c); }
    public void updateCourse(Course c) { repo.updateCourse(c); }
    public void deleteCourse(int id) { repo.deleteCourse(id); }

    public List<Lesson> getLessons(int cId) { return repo.findLessonsByCourseId(cId); }
    public void addLesson(Lesson l) { repo.insertLesson(l); }
    public void deleteLesson(int id) { repo.deleteLesson(id); }
    public Lesson getLessonById(int lessonId) {return repo.findLessonById(lessonId); }

    public void saveLesson(Lesson lesson) {
        if (lesson.getLessonId() > 0) {
            repo.updateLesson(lesson); // Nếu có ID thì là sửa
        } else {
            repo.insertLesson(lesson); // Nếu ID = 0 thì là thêm mới
        }
    }
}
