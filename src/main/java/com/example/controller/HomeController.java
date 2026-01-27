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

    // 1. ĐỊA CHỈ GỐC: Tự động đẩy sang /home
    @GetMapping("/")
    public String index() {
        return "redirect:/home";
    }

    // 2. NGÃ TƯ ĐIỀU HƯỚNG: Đây là endpoint bị thiếu dẫn đến lỗi 404
    @GetMapping("/home")
    public String homeRouter(HttpSession session) {
        if (notLoggedIn(session)) return "redirect:/login";

        String role = String.valueOf(session.getAttribute("currentUserRole"));

        if ("ADMIN".equalsIgnoreCase(role)) return "redirect:/admin/home";
        if ("INSTRUCTOR".equalsIgnoreCase(role)) return "redirect:/instructor/home";

        return "home/home"; // Trả về view cho STUDENT (không redirect nữa để tránh vòng lặp)
    }

    // 3. ADMIN HOME
    @GetMapping("/admin/home")
    public String adminHome(HttpSession session, Model model) {
        if (notLoggedIn(session)) return "redirect:/login";
        if (!hasRole(session, "ADMIN")) return "redirect:/home";

        setupModel(session, model);
        return "home/admin-home";
    }

    // 4. INSTRUCTOR HOME
    @GetMapping("/instructor/home")
    public String instructorHome(HttpSession session, Model model) {
        if (notLoggedIn(session)) return "redirect:/login";
        if (!hasRole(session, "INSTRUCTOR")) return "redirect:/home";

        setupModel(session, model);
        return "home/instructor-home";
    }

    // Hàm phụ để tránh lặp code addAttribute
    private void setupModel(HttpSession session, Model model) {
        model.addAttribute("name", session.getAttribute("currentUserName"));
        model.addAttribute("email", session.getAttribute("currentUserEmail"));
        model.addAttribute("role", session.getAttribute("currentUserRole"));
    }
}