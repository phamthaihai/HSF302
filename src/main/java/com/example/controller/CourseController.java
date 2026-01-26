package com.example.controller;

import com.example.model.Course;
import com.example.model.Lesson;
import com.example.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class CourseController {
    @Autowired
    private CourseService courseService;

    // --- COURSE ---
    @GetMapping("/courses")
    public String list(Model model) {
        model.addAttribute("courses", courseService.getAllCourses());
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
    public String saveCourse(@ModelAttribute("course") Course course) {
        // Kiểm tra null trước khi so sánh > 0 cho kiểu Integer
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

    // --- LESSON ---
    @GetMapping("/course-detail")
    public String detail(@RequestParam("id") int id, Model model) {
        model.addAttribute("course", courseService.getCourseDetail(id));
        model.addAttribute("lessons", courseService.getLessons(id));

        Lesson newLesson = new Lesson();
        // Quan trọng: Khởi tạo đối tượng Course bên trong Lesson để tránh NullPointerException ở view
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
        // Gọi hàm saveLesson đã sửa ở Service để xử lý gán Course ID
        courseService.saveLesson(lesson, courseId);
        return "redirect:/course-detail?id=" + courseId;
    }

    @PostMapping("/instructor/lesson/add")
    public String addLesson(@ModelAttribute("newLesson") Lesson lesson, @RequestParam("courseId") int courseId) {
        // Đảm bảo bài học mới được gán đúng khóa học trước khi lưu
        courseService.saveLesson(lesson, courseId);
        return "redirect:/course-detail?id=" + courseId;
    }

    @GetMapping("/instructor/lesson/delete")
    public String deleteLesson(@RequestParam("id") int id, @RequestParam("courseId") int cId) {
        courseService.deleteLesson(id);
        return "redirect:/course-detail?id=" + cId;
    }
}