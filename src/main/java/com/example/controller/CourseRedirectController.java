package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CourseRedirectController {

    @GetMapping("/courses")
    public String redirectCourses(HttpSession session) {

        Object user = session.getAttribute("user");

        if (user != null && user.toString().contains("ADMIN")) {
            return "redirect:/admin/courses";
        }
        return "redirect:/public/courses";
    }
}
