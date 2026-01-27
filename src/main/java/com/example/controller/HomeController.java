package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private boolean notLoggedIn(HttpSession session) {
        return session.getAttribute("currentUserName") == null;
    }

    private boolean hasRole(HttpSession session, String role) {
        Object r = session.getAttribute("currentUserRole");
        return r != null && role.equalsIgnoreCase(String.valueOf(r));
    }

    // STUDENT HOME
    @GetMapping("/home")
    public String studentHome(HttpSession session, Model model) {
        if (notLoggedIn(session)) return "redirect:/login";
        // nếu user không phải STUDENT thì đá về home đúng role
        if (!hasRole(session, "STUDENT")) return "redirect:/post-login";

        model.addAttribute("name", session.getAttribute("currentUserName"));
        model.addAttribute("email", session.getAttribute("currentUserEmail"));
        model.addAttribute("role", session.getAttribute("currentUserRole"));
        return "home/home"; // /WEB-INF/views/home/home.jsp
    }

    // ADMIN HOME
    @GetMapping("/admin/home")
    public String adminHome(HttpSession session, Model model) {
        if (notLoggedIn(session)) return "redirect:/login";
        if (!hasRole(session, "ADMIN")) return "redirect:/post-login";

        model.addAttribute("name", session.getAttribute("currentUserName"));
        model.addAttribute("email", session.getAttribute("currentUserEmail"));
        model.addAttribute("role", session.getAttribute("currentUserRole"));
        return "home/admin-home"; // /WEB-INF/views/home/admin-home.jsp
    }

    // INSTRUCTOR HOME
    @GetMapping("/instructor/home")
    public String instructorHome(HttpSession session, Model model) {
        if (notLoggedIn(session)) return "redirect:/login";
        if (!hasRole(session, "INSTRUCTOR")) return "redirect:/post-login";

        model.addAttribute("name", session.getAttribute("currentUserName"));
        model.addAttribute("email", session.getAttribute("currentUserEmail"));
        model.addAttribute("role", session.getAttribute("currentUserRole"));
        return "home/instructor-home"; // /WEB-INF/views/home/instructor-home.jsp
    }

    // Route trung gian: tự điều hướng theo role (dùng khi user truy cập sai URL)
    @GetMapping("/post-login")
    public String postLogin(HttpSession session) {
        if (notLoggedIn(session)) return "redirect:/login";

        String role = String.valueOf(session.getAttribute("currentUserRole"));
        if ("ADMIN".equalsIgnoreCase(role)) return "redirect:/admin/home";
        if ("INSTRUCTOR".equalsIgnoreCase(role)) return "redirect:/instructor/home";
        return "redirect:/home"; // STUDENT
    }
}
