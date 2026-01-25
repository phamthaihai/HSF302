package com.example.dao;

import com.example.entity.LessonProgress;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Repository
public class LessonProgressDao {
    @PersistenceContext
    private EntityManager em;

    public LessonProgress findByUserAndLesson(int userId, int lessonId) {
        List<LessonProgress> list = em.createQuery(
                        "select lp from LessonProgress lp where lp.user.userId=:uid and lp.lesson.lessonId=:lid",
                        LessonProgress.class
                ).setParameter("uid", userId)
                .setParameter("lid", lessonId)
                .getResultList();

        return list.isEmpty() ? null : list.get(0);
    }

    public List<Integer> findCompletedLessonIds(int userId, int courseId) {
        return em.createQuery(
                        "select lp.lesson.lessonId from LessonProgress lp " +
                                "where lp.user.userId=:uid and lp.lesson.course.courseId=:cid and lp.isCompleted=true",
                        Integer.class
                ).setParameter("uid", userId)
                .setParameter("cid", courseId)
                .getResultList();
    }

    public long countCompletedInCourse(int userId, int courseId) {
        return em.createQuery(
                        "select count(lp) from LessonProgress lp " +
                                "where lp.user.userId=:uid and lp.lesson.course.courseId=:cid and lp.isCompleted=true",
                        Long.class
                ).setParameter("uid", userId)
                .setParameter("cid", courseId)
                .getSingleResult();
    }

    public void saveOrUpdate(LessonProgress lp) {
        if (lp.getProgressId() == null) em.persist(lp);
        else em.merge(lp);
    }
}
