package com.example.service;

import com.example.model.*;
import com.example.repository.PaymentRepository;
import com.example.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepo;
    private final CourseService courseService;
    private final UserRepository userRepo;

    public PaymentService(PaymentRepository paymentRepo,
                          CourseService courseService,
                          UserRepository userRepo) {
        this.paymentRepo = paymentRepo;
        this.courseService = courseService;
        this.userRepo = userRepo;
    }

    public void payCourse(Integer userId, int courseId, String bank) {

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Course course = courseService.getCourseDetail(courseId);

        Payment payment = new Payment();
        payment.setUser(user);                 // ✅ USER CÓ TRONG DB
        payment.setCourse(course);
        payment.setAmount(course.getPrice());
        payment.setStatus("SUCCESS");
        payment.setCreatedAt(LocalDateTime.now());
        payment.setPaymentMethod(bank);

        paymentRepo.save(payment);
    }
    @Transactional
    public void payCourses(User user, List<Integer> courseIds, String bank) {

        for (Integer courseId : courseIds) {

            Course course = courseService.getCourseDetail(courseId);

            Payment payment = new Payment();
            payment.setUser(user);
            payment.setCourse(course);
            payment.setAmount(course.getPrice());
            payment.setStatus("SUCCESS");
            payment.setCreatedAt(LocalDateTime.now());
            payment.setPaymentMethod(bank);

            paymentRepo.save(payment);
        }
    }
    @Transactional
    public void payFromCart(Integer userId, Cart cart, String method) {

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        for (CartItem item : cart.getItems()) {

            Course course = item.getCourse();

            boolean paid = paymentRepo
                    .existsByUser_UserIdAndCourse_CourseIdAndStatus(
                            user.getUserId(),
                            course.getCourseId(),
                            "SUCCESS"
                    );

            if (paid) continue;

            Payment payment = new Payment();
            payment.setUser(user);
            payment.setCourse(course);
            payment.setAmount(course.getPrice());
            payment.setPaymentMethod(method);
            payment.setStatus("SUCCESS");
            payment.setCreatedAt(LocalDateTime.now());

            paymentRepo.save(payment);
        }
    }

}
