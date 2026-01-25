<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${lesson.title} | HSR Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f4f7f6; }
        .video-section { background-color: #000; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        .lesson-card { border: none; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .sidebar-item { transition: 0.2s; border-left: 4px solid transparent; }
        .sidebar-item:hover { background-color: #e9ecef; }
        .sidebar-item.active { background-color: #e7f1ff; border-left-color: #0d6efd; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="courses">HSR ACADEMY</a>
        <a href="course-detail?id=${lesson.courseId}" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left"></i> Quay lại khóa học
        </a>
    </div>
</nav>

<div class="container my-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="video-section mb-4">
                <div class="ratio ratio-16x9">
                    <c:choose>
                        <c:when test="${not empty lesson.videoUrl}">
                            <iframe src="${lesson.videoUrl}" title="${lesson.title}" allowfullscreen></iframe>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex align-items-center justify-content-center text-white bg-secondary h-100">
                                <span>Video không khả dụng</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="card lesson-card p-4">
                <h2 class="fw-bold mb-3">${lesson.title}</h2>
                <div class="d-flex align-items-center text-muted mb-4">
                    <i class="bi bi-clock me-2"></i> <span>Cập nhật mới nhất</span>
                    <span class="mx-3">|</span>
                    <i class="bi bi-person-circle me-2"></i> <span>Instructor</span>
                </div>
                <hr>
                <h5 class="fw-bold">Nội dung chi tiết:</h5>
                <div class="mt-3 lead">
                    ${lesson.content}
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card lesson-card mb-4">
                <div class="card-body">
                    <h5 class="card-title fw-bold mb-3">Tài liệu đính kèm</h5>
                    <p class="text-muted small">Hiện tại chưa có tài liệu đi kèm cho bài học này.</p>
                    <button class="btn btn-primary w-100 disabled">Tải tài liệu (.pdf)</button>
                </div>
            </div>

            <div class="alert alert-info border-0 shadow-sm">
                <h6 class="fw-bold"><i class="bi bi-info-circle-fill me-2"></i>Ghi chú học tập</h6>
                <p class="small mb-0">Hãy ghi chép lại các kiến thức quan trọng trong quá trình xem video bài học.</p>
            </div>
        </div>
    </div>
</div>

<footer class="bg-white py-4 mt-5 border-top text-center">
    <p class="text-muted mb-0">&copy; 2026 HSR Academy. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
