package com.example.controller;

import com.example.service.CourseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/courses")
public class CourseController {

    private final CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model
    ) {
        if (keyword == null || keyword.trim().isEmpty()) {
            // 👉 Không search → lấy tất cả
            model.addAttribute("courses", courseService.getPublicCourses());
        } else {
            // 👉 Có keyword → search
            model.addAttribute("courses", courseService.searchCourses(keyword));
        }

        return "course-list";
    }


    @GetMapping("/detail")
    public String detail(@RequestParam("id") int id, Model model) {
        model.addAttribute("course", courseService.getCourseDetail(id));
        return "course-detail";
    }
}
