package com.example.controller.student;

import com.example.dao.CourseDao;
import com.example.dao.LessonDao;
import com.example.entity.Course;
import com.example.entity.Feedback;
import com.example.entity.Lesson;
import com.example.entity.Certificate;
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
    private final CourseDao courseDao;
    private final LessonDao lessonDao;

    public StudentCourseController(StudentCourseService studentCourseService,
                                   CoursePlayerService playerService,
                                   FeedbackService feedbackService,
                                   CertificateService certificateService,
                                   CourseDao courseDao,
                                   LessonDao lessonDao) {
        this.studentCourseService = studentCourseService;
        this.playerService = playerService;
        this.feedbackService = feedbackService;
        this.certificateService = certificateService;
        this.courseDao = courseDao;
        this.lessonDao = lessonDao;
    }

    // demo login: hardcode
    private int currentUserId() {
        return 3;
    }

    @GetMapping("/my-courses")
    public String myCourses(Model model) {
        int userId = currentUserId();
        model.addAttribute("courses", studentCourseService.getMyCourses(userId));
        return "student/my-courses";
    }

    @GetMapping("/player")
    public String player(@RequestParam("courseId") int courseId,
                         @RequestParam(value = "lessonId", required = false) Integer lessonId,
                         Model model) {
        int userId = currentUserId();
        studentCourseService.requireRegistered(userId, courseId);

        Course course = courseDao.findById(courseId);
        List<Lesson> lessons = playerService.getLessons(courseId);

        if (lessonId == null && !lessons.isEmpty()) lessonId = lessons.get(0).getLessonId();
        Lesson currentLesson = (lessonId == null) ? null : lessonDao.findById(lessonId);

        model.addAttribute("course", course);
        model.addAttribute("lessons", lessons);
        model.addAttribute("currentLesson", currentLesson);
        model.addAttribute("completedLessonIds", playerService.getCompletedLessonIds(userId, courseId));

        return "student/course-player";
    }

    @PostMapping("/complete-lesson")
    public String completeLesson(@RequestParam("courseId") int courseId,
                                 @RequestParam("lessonId") int lessonId) {
        int userId = currentUserId();
        studentCourseService.requireRegistered(userId, courseId);
        playerService.markCompleted(userId, lessonId);
        return "redirect:/student/player?courseId=" + courseId + "&lessonId=" + lessonId;
    }

    @GetMapping("/feedback")
    public String feedbackForm(@RequestParam("courseId") int courseId, Model model) {
        int userId = currentUserId();
        studentCourseService.requireRegistered(userId, courseId);

        Feedback fb = feedbackService.getMyFeedback(userId, courseId);
        model.addAttribute("course", courseDao.findById(courseId));
        model.addAttribute("feedback", fb);

        return "student/course-feedback";
    }

    @PostMapping("/feedback")
    public String submitFeedback(@RequestParam("courseId") int courseId,
                                 @RequestParam("rating") int rating,
                                 @RequestParam("comment") String comment) {
        int userId = currentUserId();
        studentCourseService.requireRegistered(userId, courseId);

        feedbackService.submit(userId, courseId, rating, comment);
        return "redirect:/student/feedback?courseId=" + courseId;
    }

    @GetMapping("/certificate")
    public String certificate(@RequestParam("courseId") int courseId, Model model) {
        int userId = currentUserId();
        studentCourseService.requireRegistered(userId, courseId);

        Certificate cert = certificateService.issueIfEligible(userId, courseId);

        model.addAttribute("course", courseDao.findById(courseId));
        model.addAttribute("certificate", cert);

        return "student/certificate";
    }
}
