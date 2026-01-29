package com.example.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class StudentProfileController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/student/profile")
    public String profile(HttpSession session, Model model) {

        Object idObj = session.getAttribute("currentUserId");
        if (idObj == null) {
            session.setAttribute("redirectAfterLogin", "/student/profile");
            return "redirect:/login";
        }

        int userId;
        try {
            userId = (idObj instanceof Integer) ? (Integer) idObj : Integer.parseInt(idObj.toString());
        } catch (Exception e) {
            session.invalidate();
            return "redirect:/login";
        }

        // Lấy thông tin cơ bản: full_name, email, status
        String sql = """
    SELECT 
      u.user_id,
      u.full_name,
      u.email,
      r.role_name,
      CASE WHEN u.status = 1 THEN 1 ELSE 0 END AS status
    FROM users u
    JOIN roles r ON r.role_id = u.role_id
    WHERE u.user_id = ?
""";


        try {
            Map<String, Object> profile = jdbcTemplate.queryForMap(sql, userId);
            model.addAttribute("profile", profile);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("error", "Không tìm thấy người dùng.");
        } catch (Exception ex) {
            model.addAttribute("error", "Lỗi khi tải dữ liệu hồ sơ: " + ex.getMessage());
        }

        return "student/student_profile"; // /WEB-INF/views/student/student_profile.jsp
    }
}
