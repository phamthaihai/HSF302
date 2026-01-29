package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StudentHomeController {

    @GetMapping("/student/home")
    public String studentHome(HttpSession session) {
        // Chưa login -> đá về login
        if (session.getAttribute("currentUserId") == null) {
            session.setAttribute("redirectAfterLogin", "/student/home");
            return "redirect:/login";
        }

        // Không phải STUDENT -> chặn (hoặc bạn muốn redirect theo role thì đổi)
        Object roleObj = session.getAttribute("currentUserRole");
        String role = roleObj == null ? "" : roleObj.toString().toUpperCase();
        if (!"STUDENT".equals(role)) {
            return "redirect:/home"; // router chung
        }

        return "home/home_student";
    }
}
