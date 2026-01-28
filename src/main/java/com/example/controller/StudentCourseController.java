package com.example.controller;

import jakarta.servlet.http.HttpSession;
import com.example.model.Course;
import com.example.model.Feedback;
import com.example.model.Lesson;
import com.example.model.Certificate;
import com.example.repository.CourseRepository;
import com.example.repository.LessonRepository;
import com.example.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentCourseController {

    private final StudentCourseService studentCourseService;
    private final CoursePlayerService playerService;
    private final FeedbackService feedbackService;
    private final CertificateService certificateService;

    private final CourseRepository courseRepository;
    private final LessonRepository lessonRepository;

    public StudentCourseController(StudentCourseService studentCourseService,
                                   CoursePlayerService playerService,
                                   FeedbackService feedbackService,
                                   CertificateService certificateService,
                                   CourseRepository courseRepository,
                                   LessonRepository lessonRepository) {
        this.studentCourseService = studentCourseService;
        this.playerService = playerService;
        this.feedbackService = feedbackService;
        this.certificateService = certificateService;
        this.courseRepository = courseRepository;
        this.lessonRepository = lessonRepository;
    }

    private Integer getUserId(HttpSession session) {
        Object idObj = session.getAttribute("currentUserId");
        if (idObj == null) return null;
        if (idObj instanceof Number) return ((Number) idObj).intValue();
        return Integer.parseInt(idObj.toString());
    }

    private boolean isStudent(HttpSession session){
        Object roleObj = session.getAttribute("currentUserRole");
        return roleObj != null && "STUDENT".equalsIgnoreCase(roleObj.toString());
    }

    @GetMapping("/my-courses")
    public String myCourses(HttpSession session, Model model) {
        Integer userId = getUserId(session);
        if (userId == null) return "redirect:/login";
        if (!isStudent(session)) return "redirect:/login";

        model.addAttribute("courses", studentCourseService.getMyCourses(userId));
        return "student/my-courses";
    }

    @GetMapping("/player")
    public String player(@RequestParam("courseId") int courseId,
                         @RequestParam(value = "lessonId", required = false) Integer lessonId,
                         HttpSession session,
                         Model model) {
        Integer userId = getUserId(session);
        if (userId == null) return "redirect:/login";
        if (!isStudent(session)) return "redirect:/login";

        studentCourseService.requireRegistered(userId, courseId);

        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        List<Lesson> lessons = playerService.getLessons(courseId);

        if (lessonId == null && !lessons.isEmpty()) {
            lessonId = lessons.get(0).getLessonId();
        }

        Lesson currentLesson = (lessonId == null)
                ? null
                : lessonRepository.findById(lessonId).orElse(null);

        model.addAttribute("course", course);
        model.addAttribute("lessons", lessons);
        model.addAttribute("currentLesson", currentLesson);
        model.addAttribute("completedLessonIds", playerService.getCompletedLessonIds(userId, courseId));

        return "student/course-player";
    }

    @PostMapping("/complete-lesson")
    public String completeLesson(@RequestParam("courseId") int courseId,
                                 @RequestParam("lessonId") int lessonId,
                                 HttpSession session) {
        Integer userId = getUserId(session);
        if (userId == null) return "redirect:/login";
        if (!isStudent(session)) return "redirect:/login";

        studentCourseService.requireRegistered(userId, courseId);
        playerService.markCompleted(userId, lessonId);

        return "redirect:/student/player?courseId=" + courseId + "&lessonId=" + lessonId;
    }

    @GetMapping("/feedback")
    public String feedbackForm(@RequestParam("courseId") int courseId,
                               HttpSession session,
                               Model model) {
        Integer userId = getUserId(session);
        if (userId == null) return "redirect:/login";
        if (!isStudent(session)) return "redirect:/login";

        studentCourseService.requireRegistered(userId, courseId);

        Feedback fb = feedbackService.getMyFeedback(userId, courseId);
        model.addAttribute("course", courseRepository.findById(courseId).orElse(null));
        model.addAttribute("feedback", fb);

        return "student/course-feedback";
    }

    @PostMapping("/feedback")
    public String submitFeedback(@RequestParam("courseId") int courseId,
                                 @RequestParam("rating") int rating,
                                 @RequestParam("comment") String comment,
                                 HttpSession session) {
        Integer userId = getUserId(session);
        if (userId == null) return "redirect:/login";
        if (!isStudent(session)) return "redirect:/login";

        studentCourseService.requireRegistered(userId, courseId);

        feedbackService.submit(userId, courseId, rating, comment);
        return "redirect:/student/feedback?courseId=" + courseId;
    }

    @GetMapping("/certificate")
    public String certificate(@RequestParam("courseId") int courseId,
                              HttpSession session,
                              Model model) {
        Integer userId = getUserId(session);
        if (userId == null) return "redirect:/login";
        if (!isStudent(session)) return "redirect:/login";

        studentCourseService.requireRegistered(userId, courseId);

        Certificate cert = certificateService.issueIfEligible(userId, courseId);

        model.addAttribute("course", courseRepository.findById(courseId).orElse(null));
        model.addAttribute("certificate", cert);

        return "student/certificate";
    }
}
