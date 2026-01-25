package com.example.dao;

import com.example.entity.Certificate;
import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Repository
public class CertificateDao {
    @PersistenceContext
    private EntityManager em;

    public Certificate findByUserAndCourse(int userId, int courseId) {
        List<Certificate> list = em.createQuery(
                        "select c from Certificate c where c.user.userId=:uid and c.course.courseId=:cid",
                        Certificate.class
                ).setParameter("uid", userId)
                .setParameter("cid", courseId)
                .getResultList();

        return list.isEmpty() ? null : list.get(0);
    }

    public void save(Certificate c) {
        em.persist(c);
    }
}
