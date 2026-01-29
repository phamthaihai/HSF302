package com.example.service;

import com.example.model.Course;
import com.example.model.Lesson;
import com.example.repository.CourseLessonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CourseService {

    @Autowired
    private CourseLessonRepository repo;

    public List<Course> getAllCourses() {
        return repo.findAll();
    }

    public Course getCourseDetail(int id) {
        return repo.findById(id);
    }

    public void addCourse(Course c) {
        repo.insertCourse(c);
    }

    public void updateCourse(Course c) {
        repo.updateCourse(c);
    }

    public void deleteCourse(int id) {
        repo.deleteCourse(id);
    }

    public List<Lesson> getLessons(int cId) {
        return repo.findLessonsByCourseId(cId);
    }

    public Lesson getLessonById(int lessonId) {
        return repo.findLessonById(lessonId);
    }

    public void deleteLesson(int id) {
        repo.deleteLesson(id);
    }
    public List<Course> searchCourses(String keyword, Double minPrice, Double maxPrice) {
        return repo.search(keyword, minPrice, maxPrice);
    }

    public void saveLesson(Lesson lesson, int courseId) {
        if (lesson.getCourse() == null) {
            Course tempCourse = new Course();
            tempCourse.setCourseId(courseId);
            lesson.setCourse(tempCourse);
        }

        if (lesson.getLessonId() != null && lesson.getLessonId() > 0) {
            repo.updateLesson(lesson);
        } else {
            repo.insertLesson(lesson);
        }
    }
    public List<Course> getCoursesByIds(List<Integer> ids) {
        return repo.findByIds(ids);
    }

}
