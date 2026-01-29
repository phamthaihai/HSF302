package com.example.repository;

import com.example.model.Course;
import com.example.model.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class CourseLessonRepository {
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

    public void deleteCourse(int id) {
        jdbcTemplate.update("DELETE FROM lessons WHERE course_id = ?", id);
        jdbcTemplate.update("DELETE FROM courses WHERE course_id = ?", id);
    }


    public Lesson findLessonById(int lessonId) {
        String sql = "SELECT * FROM lessons WHERE lesson_id = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            Lesson l = new Lesson();
            l.setLessonId(rs.getInt("lesson_id"));
            l.setTitle(rs.getString("title"));
            l.setContent(rs.getString("content"));
            l.setVideoUrl(rs.getString("video_url"));

            // Khởi tạo object Course và gán ID vào
            Course c = new Course();
            c.setCourseId(rs.getInt("course_id"));
            l.setCourse(c);

            return l;
        }, lessonId);
    }

    public List<Lesson> findLessonsByCourseId(int courseId) {
        String sql = "SELECT * FROM lessons WHERE course_id = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Lesson l = new Lesson();
            l.setLessonId(rs.getInt("lesson_id"));
            l.setTitle(rs.getString("title"));
            l.setContent(rs.getString("content"));
            l.setVideoUrl(rs.getString("video_url"));

            Course c = new Course();
            c.setCourseId(rs.getInt("course_id"));
            l.setCourse(c);

            return l;
        }, courseId);
    }
    public List<Course> search(String keyword, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT * FROM courses WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + keyword + "%");
        }

        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }

        return jdbcTemplate.query(
                sql.toString(),
                params.toArray(),
                new BeanPropertyRowMapper<>(Course.class)
        );
    }


    public void insertLesson(Lesson l) {
        String sql = "INSERT INTO lessons (course_id, title, content, video_url) VALUES (?, ?, ?, ?)";
        Integer courseId = (l.getCourse() != null) ? l.getCourse().getCourseId() : null;
        jdbcTemplate.update(sql, courseId, l.getTitle(), l.getContent(), l.getVideoUrl());
    }

    public void updateLesson(Lesson l) {
        String sql = "UPDATE lessons SET title = ?, video_url = ?, content = ?, course_id = ? WHERE lesson_id = ?";
        Integer courseId = (l.getCourse() != null) ? l.getCourse().getCourseId() : null;
        jdbcTemplate.update(sql, l.getTitle(), l.getVideoUrl(), l.getContent(), courseId, l.getLessonId());
    }
    public List<Course> findByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return new ArrayList<>();

        String inSql = String.join(",", ids.stream().map(id -> "?").toArray(String[]::new));
        String sql = "SELECT * FROM courses WHERE course_id IN (" + inSql + ")";

        return jdbcTemplate.query(
                sql,
                ids.toArray(),
                new BeanPropertyRowMapper<>(Course.class)
        );
    }

    public void deleteLesson(int id) {
        jdbcTemplate.update("DELETE FROM lessons WHERE lesson_id = ?", id);
    }
}