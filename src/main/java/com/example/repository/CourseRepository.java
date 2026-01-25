package com.example.repository;

import com.example.model.Course;
import com.example.model.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CourseRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Course> findAll() {
        return jdbcTemplate.query("SELECT * FROM courses", new BeanPropertyRowMapper<>(Course.class));
    }

    public Course findById(int id) {
        return jdbcTemplate.queryForObject("SELECT * FROM courses WHERE course_id = ?",
                new BeanPropertyRowMapper<>(Course.class), id);
    }

    public void insertCourse(Course c) {
        String sql = "INSERT INTO courses (title, description, price, status, image_url, instructor_id) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, c.getTitle(), c.getDescription(), c.getPrice(), "PUBLISHED", c.getImageUrl(), 1);
    }


    public void updateCourse(Course c) {
        String sql = "UPDATE courses SET title=?, description=?, price=?, image_url=? WHERE course_id=?";
        jdbcTemplate.update(sql, c.getTitle(), c.getDescription(), c.getPrice(), c.getImageUrl(), c.getCourseId());
    }
    public void updateLesson(Lesson l) {
        String sql = "UPDATE lessons SET title = ?, video_url = ?, content = ? WHERE lesson_id = ?";
        jdbcTemplate.update(sql, l.getTitle(), l.getVideoUrl(), l.getContent(), l.getLessonId());
    }

    public void deleteCourse(int id) {
        jdbcTemplate.update("DELETE FROM lessons WHERE course_id = ?", id);
        jdbcTemplate.update("DELETE FROM courses WHERE course_id = ?", id);
    }
    public Lesson findLessonById(int lessonId) {
        String sql = "SELECT * FROM lessons WHERE lesson_id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Lesson.class), lessonId);
    }

    public List<Lesson> findLessonsByCourseId(int courseId) {
        return jdbcTemplate.query("SELECT * FROM lessons WHERE course_id = ?", new BeanPropertyRowMapper<>(Lesson.class), courseId);
    }

    public void insertLesson(Lesson l) {
        String sql = "INSERT INTO lessons (course_id, title, content, order_index) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, l.getCourseId(), l.getTitle(), l.getContent(), 0);
    }

    public void deleteLesson(int id) {
        jdbcTemplate.update("DELETE FROM lessons WHERE lesson_id = ?", id);
    }
}