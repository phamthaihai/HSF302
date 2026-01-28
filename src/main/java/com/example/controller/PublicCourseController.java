package com.example.controller;

import com.example.service.PublicCourseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/public/courses")
public class PublicCourseController {

    private final PublicCourseService publicCourseService;

    public PublicCourseController(PublicCourseService publicCourseService) {
        this.publicCourseService = publicCourseService;
    }

    @GetMapping
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model
    ) {
        if (keyword == null || keyword.trim().isEmpty()) {
            model.addAttribute("courses", publicCourseService.getPublicCourses());
        } else {
            model.addAttribute("courses", publicCourseService.searchCourses(keyword));
        }

        return "student/publicCourse-list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam("id") int id, Model model) {
        model.addAttribute("course", publicCourseService.getCourseDetail(id));
        return "student/publicCourse-detail";
    }
}

