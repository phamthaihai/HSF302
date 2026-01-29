package com.example.controller;

import com.example.service.PublicCourseService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @Autowired
    private PublicCourseService publicCourseService;

    /**
     * ROOT "/" -> Home Guest
     * - Nếu đã login thì chuyển qua /home (router theo role)
     * - Nếu chưa login thì show guest + list course giống publicCourseList
     */
    @GetMapping("/")
    public String homeGuest(
            @RequestParam(value = "q", required = false) String q,
            Model model,
            HttpSession session
    ) {
        // Nếu đã đăng nhập thì đưa về router /home
        if (session.getAttribute("currentUserId") != null) {
            return "redirect:/home";
        }

        // Lấy danh sách course giống PublicCourseList
        if (q != null && !q.trim().isEmpty()) {
            model.addAttribute("courses", publicCourseService.searchCourses(q.trim()));
            model.addAttribute("q", q.trim());
        } else {
            model.addAttribute("courses", publicCourseService.getPublicCourses());
            model.addAttribute("q", "");
        }

        // View home guest của bạn (bạn sẽ sửa JSP để bố cục giống publicCourseList + đổi màu xanh)
        return "home/home_guest";
    }

    /**
     * Router sau khi login (giữ như bạn đang làm)
     * Nếu bạn đã có sẵn /home trong controller khác thì giữ 1 nơi thôi.
     */
    @GetMapping("/home")
    public String homeRouter(HttpSession session) {
        Object role = session.getAttribute("currentUserRole");
        if (role == null) return "redirect:/login";

        String r = String.valueOf(role).toUpperCase();
        if ("ADMIN".equals(r)) return "redirect:/admin/dashboard";
        if ("INSTRUCTOR".equals(r)) return "redirect:/instructor/home";
        return "redirect:/student/home";
    }
}
