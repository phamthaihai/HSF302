package com.example.controller;

import com.example.model.Cart;
import com.example.model.Course;
import com.example.service.CourseService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CartController {

    private final CourseService courseService;

    public CartController(CourseService courseService) {
        this.courseService = courseService;
    }

    // ================= ADD TO CART =================
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("courseId") Integer courseId,
                            HttpSession session) {

        Cart cart = (Cart) session.getAttribute("CART");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("CART", cart);
        }

        Course course = courseService.getCourseDetail(courseId);
        if (course != null) {
            cart.addCourse(course);
        }

        return "redirect:/public/courses/detail?id=" + courseId;
    }

    // ================= VIEW CART =================
    @GetMapping("/cart/view")
    public String viewCart(HttpSession session, Model model) {

        Cart cart = (Cart) session.getAttribute("CART");

        if (cart == null || cart.isEmpty()) {
            model.addAttribute("msg", "Giỏ hàng trống");
        } else {
            model.addAttribute("cart", cart);
            model.addAttribute("items", cart.getItems());
            model.addAttribute("total", cart.getTotalAmount());
        }

        return "student/cart";
    }
}
