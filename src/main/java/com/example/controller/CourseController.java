package com.example.controller;

import com.example.model.Course;
import com.example.model.Lesson;
import com.example.service.CourseService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@Controller
public class CourseController {
    @Autowired
    private CourseService courseService;

    @RequestMapping("/admin/courses")
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "minPrice", required = false) Double minPrice,
            @RequestParam(value = "maxPrice", required = false) Double maxPrice,
            Model model
    ) {
        model.addAttribute("courses", courseService.searchCourses(keyword, minPrice, maxPrice));
        model.addAttribute("role", "ADMIN");
        model.addAttribute("backUrl", "/admin/home");
        return "course-list";
    }

    @GetMapping("/instructor/courses")
    public String listForInstructor(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "minPrice", required = false) Double minPrice,
            @RequestParam(value = "maxPrice", required = false) Double maxPrice,
            Model model
    ) {
        model.addAttribute("courses", courseService.searchCourses(keyword, minPrice, maxPrice));
        model.addAttribute("role", "INSTRUCTOR");
        model.addAttribute("backUrl", "/instructor/home");
        return "instructor-course";
    }

    @GetMapping({"/admin/course-detail", "/instructor/course-detail"})
    public String detail(@RequestParam("id") int id, Model model, HttpServletRequest request) {
        model.addAttribute("course", courseService.getCourseDetail(id));
        model.addAttribute("lessons", courseService.getLessons(id));

        Lesson newLesson = new Lesson();
        Course c = new Course();
        c.setCourseId(id);
        newLesson.setCourse(c);
        model.addAttribute("newLesson", newLesson);

        String requestURI = request.getRequestURI();
        if (requestURI.contains("/admin/")) {
            model.addAttribute("role", "ADMIN");
            model.addAttribute("backUrl", "/admin/courses");
        } else {
            model.addAttribute("role", "INSTRUCTOR");
            model.addAttribute("backUrl", "/instructor/courses");
        }
        return "course-detail";
    }

    @PostMapping("/admin/course/save")
    public String saveCourse(@Valid @ModelAttribute("course") Course course, BindingResult result) {
        if (result.hasErrors()) return "course-form";
        if (course.getCourseId() != null && course.getCourseId() > 0) {
            courseService.updateCourse(course);
        } else {
            courseService.addCourse(course);
        }
        return "redirect:/admin/courses";
    }

    @GetMapping("/admin/course/delete")
    public String deleteCourse(@RequestParam("id") int id) {
        courseService.deleteCourse(id);
        return "redirect:/admin/courses";
    }

    @PostMapping({"/instructor/lesson/save", "/admin/lesson/save", "/instructor/lesson/add", "/admin/lesson/add"})
    public String saveLesson(@ModelAttribute("newLesson") Lesson lesson,
                             @RequestParam("courseId") int courseId,
                             HttpServletRequest request) {
        courseService.saveLesson(lesson, courseId);
        String prefix = request.getRequestURI().contains("/admin/") ? "/admin" : "/instructor";
        return "redirect:" + prefix + "/course-detail?id=" + courseId;
    }

    @GetMapping({"/instructor/lesson/delete", "/admin/lesson/delete"})
    public String deleteLesson(@RequestParam("id") int id,
                               @RequestParam("courseId") int cId,
                               HttpServletRequest request) {
        courseService.deleteLesson(id);
        String prefix = request.getRequestURI().contains("/admin/") ? "/admin" : "/instructor";
        return "redirect:" + prefix + "/course-detail?id=" + cId;
    }

    @GetMapping("/view-lesson")
    public String viewLesson(@RequestParam("id") int lessonId, Model model) {
        model.addAttribute("lesson", courseService.getLessonById(lessonId));
        return "lesson-detail";
    }
}