package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/register")
    public String showRegisterPage() {
        return "login/register"; // /WEB-INF/views/login/register.jsp
    }

    @PostMapping("/register")
    public String doRegister(
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            Model model
    ) {
        // 1) Validate cơ bản
        if (fullName == null || fullName.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập họ tên.");
            return "login/register";
        }
        if (email == null || email.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập email.");
            return "login/register";
        }
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu nhập lại không khớp.");
            return "login/register";
        }

        // 2) Lấy role_id cho STUDENT (nếu chưa có thì fallback 1)
        Integer roleId;
        try {
            roleId = jdbcTemplate.queryForObject(
                    "SELECT role_id FROM roles WHERE role_name = ?",
                    Integer.class,
                    "STUDENT"
            );
        } catch (Exception ex) {
            roleId = 1; // fallback (tuỳ DB bạn)
        }

        // 3) Check trùng email
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM users WHERE email = ?",
                Integer.class,
                email
        );
        if (count != null && count > 0) {
            model.addAttribute("error", "Email đã tồn tại. Vui lòng dùng email khác.");
            return "login/register";
        }

        // 4) Insert user
        try {
            String sql = """
                    INSERT INTO users (full_name, email, password, role_id, status)
                    VALUES (?, ?, ?, ?, 1)
                    """;
            jdbcTemplate.update(sql, fullName.trim(), email.trim(), password, roleId);

            // Đăng ký xong -> quay lại login và báo message
            model.addAttribute("message", "Tạo tài khoản thành công! Hãy đăng nhập.");
            return "login/login";

            // Nếu bạn muốn redirect + flash message thì cần RedirectAttributes (nâng cao)
        } catch (DuplicateKeyException ex) {
            model.addAttribute("error", "Email đã tồn tại. Vui lòng dùng email khác.");
            return "login/register";
        } catch (Exception ex) {
            model.addAttribute("error", "Đăng ký thất bại: " + ex.getMessage());
            return "login/register";
        }
    }
}