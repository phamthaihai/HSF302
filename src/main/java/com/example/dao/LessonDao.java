package com.example.dao;

import com.example.entity.Lesson;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Repository
public class LessonDao {
    @PersistenceContext
    private EntityManager em;

    public List<Lesson> findByCourse(int courseId) {
        return em.createQuery(
                "select l from Lesson l where l.course.courseId=:cid order by l.lessonId",
                Lesson.class
        ).setParameter("cid", courseId).getResultList();
    }

    public Lesson findById(int lessonId) {
        return em.find(Lesson.class, lessonId);
    }

    public long countLessonsInCourse(int courseId) {
        return em.createQuery(
                "select count(l) from Lesson l where l.course.courseId=:cid",
                Long.class
        ).setParameter("cid", courseId).getSingleResult();
    }
}
