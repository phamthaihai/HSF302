package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InstructorHomeController {

    @GetMapping("/instructor/home")
    public String instructorHome(HttpSession session) {
        if (session.getAttribute("currentUserId") == null) {
            session.setAttribute("redirectAfterLogin", "/instructor/home");
            return "redirect:/login";
        }

        Object roleObj = session.getAttribute("currentUserRole");
        String role = roleObj == null ? "" : roleObj.toString().toUpperCase();
        if (!"INSTRUCTOR".equals(role)) {
            return "redirect:/home";
        }

        return "home/instructor-home";
    }
}
