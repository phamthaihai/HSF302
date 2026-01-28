package com.example.controller;

import com.example.model.Course;
import com.example.model.Lesson;
import com.example.service.CourseService;
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

    @GetMapping("/courses")
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "minPrice", required = false) Double minPrice,
            @RequestParam(value = "maxPrice", required = false) Double maxPrice,
            Model model
    ) {
        model.addAttribute(
                "courses",
                courseService.searchCourses(keyword, minPrice, maxPrice)
        );
        return "course-list";
    }


    @GetMapping("/admin/course/add")
    public String showAddCourse(Model model) {
        model.addAttribute("course", new Course());
        return "course-form";
    }

    @GetMapping("/admin/course/edit")
    public String showEditCourse(@RequestParam("id") int id, Model model) {
        model.addAttribute("course", courseService.getCourseDetail(id));
        return "course-form";
    }

    @PostMapping("/admin/course/save")
    public String saveCourse(
            @Valid @ModelAttribute("course") Course course,
            BindingResult result
    ) {
        if (result.hasErrors()) {
            return "course-form";
        }

        if (course.getCourseId() != null && course.getCourseId() > 0) {
            courseService.updateCourse(course);
        } else {
            courseService.addCourse(course);
        }
        return "redirect:/courses";
    }

    @GetMapping("/admin/course/delete")
    public String deleteCourse(@RequestParam("id") int id) {
        courseService.deleteCourse(id);
        return "redirect:/courses";
    }

    @GetMapping("/course-detail")
    public String detail(@RequestParam("id") int id, Model model) {
        model.addAttribute("course", courseService.getCourseDetail(id));
        model.addAttribute("lessons", courseService.getLessons(id));

        Lesson newLesson = new Lesson();
        Course c = new Course();
        c.setCourseId(id);
        newLesson.setCourse(c);

        model.addAttribute("newLesson", newLesson);
        return "course-detail";
    }

    @GetMapping("/view-lesson")
    public String viewLesson(@RequestParam("id") int lessonId, Model model) {
        Lesson lesson = courseService.getLessonById(lessonId);
        model.addAttribute("lesson", lesson);
        return "lesson-detail";
    }

    @PostMapping("/instructor/lesson/save")
    public String saveLesson(@ModelAttribute("lesson") Lesson lesson, @RequestParam("courseId") int courseId) {
        courseService.saveLesson(lesson, courseId);
        return "redirect:/course-detail?id=" + courseId;
    }

    @PostMapping("/instructor/lesson/add")
    public String addLesson(@ModelAttribute("newLesson") Lesson lesson, @RequestParam("courseId") int courseId) {
        courseService.saveLesson(lesson, courseId);
        return "redirect:/course-detail?id=" + courseId;
    }

    @GetMapping("/instructor/lesson/delete")
    public String deleteLesson(@RequestParam("id") int id, @RequestParam("courseId") int cId) {
        courseService.deleteLesson(id);
        return "redirect:/course-detail?id=" + cId;
    }
}