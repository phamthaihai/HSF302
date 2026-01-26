package com.example.controller;

import com.example.model.Course;
import com.example.service.CourseService;
import com.example.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private CourseService courseService;

    // 👉 HIỂN THỊ TRANG THANH TOÁN
    @GetMapping
    public String showPayment(
            @RequestParam("courseId") int courseId,
            Model model
    ) {
        Course course = courseService.getCourseDetail(courseId);

        model.addAttribute("course", course);
        model.addAttribute("amount", course.getPrice()); // ✅ lấy price

        return "payment";
    }

    // 👉 XỬ LÝ THANH TOÁN
    @PostMapping("/pay")
    public String processPayment(
            @RequestParam int userId,
            @RequestParam int courseId
    ) {
        Course course = courseService.getCourseDetail(courseId);

        double amount = course.getPrice(); // ✅ price → amount

        paymentService.pay(userId, courseId, amount);

        return "redirect:/courses";
    }
}
