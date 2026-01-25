package com.example.dao;

import com.example.entity.Feedback;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Repository
public class FeedbackDao {
    @PersistenceContext
    private EntityManager em;

    public Feedback findByUserAndCourse(int userId, int courseId) {
        List<Feedback> list = em.createQuery(
                        "select f from Feedback f where f.user.userId=:uid and f.course.courseId=:cid",
                        Feedback.class
                ).setParameter("uid", userId)
                .setParameter("cid", courseId)
                .getResultList();

        return list.isEmpty() ? null : list.get(0);
    }

    public void saveOrUpdate(Feedback f) {
        if (f.getFeedbackId() == null) em.persist(f);
        else em.merge(f);
    }
}
