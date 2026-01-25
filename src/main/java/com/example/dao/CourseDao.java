package com.example.dao;

import com.example.entity.Course;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Repository
public class CourseDao {
    @PersistenceContext
    private EntityManager em;

    public List<Course> findMyCourses(int userId) {
        return em.createQuery(
                "select distinct p.course from Payment p " +
                        "where p.user.userId=:uid and p.status='SUCCESS'",
                Course.class
        ).setParameter("uid", userId).getResultList();
    }

    public Course findById(int courseId) {
        return em.find(Course.class, courseId);
    }
}
