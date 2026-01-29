package com.example.controller;

import com.example.model.*;
import com.example.service.CourseService;
import com.example.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final CourseService courseService;
    private final PaymentService paymentService;

    public PaymentController(CourseService courseService,
                             PaymentService paymentService) {
        this.courseService = courseService;
        this.paymentService = paymentService;
    }

    // 👉 MỞ TRANG THANH TOÁN TỪ DETAIL
    @GetMapping("/detail")
    public String paymentDetail(@RequestParam("courseId") int courseId,
                                Model model) {

        Course course = courseService.getCourseDetail(courseId);
        model.addAttribute("course", course);

        return "student/payment-detail";
    }
    @PostMapping("/detail/confirm")
    public String confirmPayment(@RequestParam("courseId") int courseId,
                                 @RequestParam("bank") String bank,
                                 HttpSession session) {

        Integer userId = (Integer) session.getAttribute("currentUserId");

        if (userId == null) {
            return "redirect:/login";
        }

        paymentService.payCourse(userId, courseId, bank);

        return "redirect:/payment/success";
    }



    @GetMapping("/success")
    public String success() {
        return "student/payment-success";
    }



}
