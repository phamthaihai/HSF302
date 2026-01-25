package com.example.dao;

import com.example.entity.Payment;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Repository
public class PaymentDao {
    @PersistenceContext
    private EntityManager em;

    public boolean hasSuccessfulPayment(int userId, int courseId) {
        Long cnt = em.createQuery(
                        "select count(p) from Payment p where p.user.userId=:uid and p.course.courseId=:cid and p.status='SUCCESS'",
                        Long.class
                ).setParameter("uid", userId)
                .setParameter("cid", courseId)
                .getSingleResult();
        return cnt != null && cnt > 0;
    }
}
