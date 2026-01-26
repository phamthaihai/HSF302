package com.example.service;

import com.example.model.Payment;
import com.example.repository.PaymentRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;


import java.util.Date;

@Service
@Transactional
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;

    public PaymentServiceImpl(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    @Override
    public void pay(int userId, int courseId, double amount) {
        Payment payment = new Payment();
        payment.setUserId(userId);
        payment.setCourseId(courseId);
        payment.setAmount(amount);
        payment.setPaymentMethod("ONLINE");
        payment.setStatus(1);
        payment.setCreatedAt(new Date());

        paymentRepository.save(payment);
    }
}
