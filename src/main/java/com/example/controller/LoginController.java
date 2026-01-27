package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/login")
    public String showLoginPage() {
        return "login/login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam("username") String email,   // form đang name="username"
            @RequestParam("password") String password,
            HttpSession session,
            Model model
    ) {
        // 1) Validate basic
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập email.");
            return "login/login";
        }
        if (password == null || password.isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập mật khẩu.");
            return "login/login";
        }

        String sql = """
            SELECT u.user_id, u.full_name, u.email, r.role_name
            FROM users u
            JOIN roles r ON r.role_id = u.role_id
            WHERE u.email = ? AND u.password = ? AND u.status = 1
        """;

        try {
            Map<String, Object> user = jdbcTemplate.queryForMap(sql, email.trim(), password);

            String role = String.valueOf(user.get("role_name")); // ADMIN / INSTRUCTOR / STUDENT

            session.setAttribute("currentUserId", user.get("user_id"));
            session.setAttribute("currentUserName", user.get("full_name"));
            session.setAttribute("currentUserEmail", user.get("email"));
            session.setAttribute("currentUserRole", role);

            // 2) Redirect theo role
            if ("ADMIN".equalsIgnoreCase(role)) {
                return "redirect:/admin/home";
            } else if ("INSTRUCTOR".equalsIgnoreCase(role)) {
                return "redirect:/instructor/home";
            } else {
                return "redirect:/home"; // STUDENT
            }

        } catch (Exception ex) {
            model.addAttribute("error", "Sai email hoặc mật khẩu.");
            return "login/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
