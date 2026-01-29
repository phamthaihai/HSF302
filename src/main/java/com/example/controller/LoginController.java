package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
            @RequestParam("username") String email,
            @RequestParam("password") String password,
            HttpSession session,
            Model model
    ) {
        // 1) Validate basic
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập email.");
            return "login/login";
        }
        if (password == null || password.trim().isEmpty()) {
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
            Map<String, Object> user = jdbcTemplate.queryForMap(
                    sql,
                    email.trim(),
                    password.trim()
            );

            String role = String.valueOf(user.get("role_name")); // ADMIN / INSTRUCTOR / STUDENT

            // 2) Lưu session
            session.setAttribute("currentUserId", user.get("user_id"));
            session.setAttribute("currentUserName", user.get("full_name"));
            session.setAttribute("currentUserEmail", user.get("email"));
            session.setAttribute("currentUserRole", role);

            // 3) Redirect theo role
            if ("ADMIN".equalsIgnoreCase(role)) {
                return "redirect:/admin/home";
            }

            if ("INSTRUCTOR".equalsIgnoreCase(role)) {
                return "redirect:/instructor/home";
            }
            if ("STUDENT".equalsIgnoreCase(role)) {
                return "redirect:/student/home";
            }

            // role lạ -> quay về login cho chắc
            model.addAttribute("error", "Role không hợp lệ: " + role);
            return "login/login";

        } catch (EmptyResultDataAccessException e) {
            // Không tìm thấy user hợp lệ
            model.addAttribute("error", "Sai email hoặc mật khẩu.");
            return "login/login";
        } catch (Exception e) {
            // Lỗi khác (SQL, kết nối DB,...)
            model.addAttribute("error", "Có lỗi xảy ra khi đăng nhập. Vui lòng thử lại.");
            return "login/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
