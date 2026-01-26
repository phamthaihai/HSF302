<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${course.title} | HSR Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-color: #0d6efd; }
        body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .video-container {
            background-color: #000;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .lesson-link {
            cursor: pointer;
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
        }
        .lesson-link:hover { background-color: #f1f4f9; border-left-color: #adb5bd; }
        .lesson-link.active {
            background-color: #e7f1ff;
            border-left-color: var(--primary-color);
        }
        .card { border: none; border-radius: 12px; transition: 0.3s; }
        #lessonContent { white-space: pre-wrap; line-height: 1.6; color: #4b5563; }
        .list-group-item { border-x: none; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="btn btn-outline-secondary btn-sm me-3" href="courses">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
        <span class="navbar-brand fw-bold text-primary text-truncate" style="max-width: 60%">${course.title}</span>
        <div class="ms-auto">
            <button class="btn btn-dark px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#lessonModal" onclick="prepareAddLesson()">
                <i class="bi bi-plus-lg me-1"></i> Thêm bài học
            </button>
        </div>
    </div>
</nav>

<div class="container mt-4 mb-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="video-container mb-4">
                <div class="ratio ratio-16x9">
                    <c:choose>
                        <c:when test="${not empty lessons}">
                            <iframe id="mainVideo"
                                    src=""
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                    allowfullscreen>
                            </iframe>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex align-items-center justify-content-center text-white h-100">
                                <div class="text-center">
                                    <i class="bi bi-camera-video-off fs-1 d-block mb-2"></i>
                                    <p>Chưa có bài học nào được đăng tải</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="card shadow-sm p-4">
                <h3 id="lessonTitle" class="fw-bold text-dark mb-3">
                    ${not empty lessons ? lessons[0].title : 'Chào mừng bạn đến với khóa học'}
                </h3>
                <div class="d-flex gap-3 mb-4 text-muted small">
                    <span><i class="bi bi-clock me-1"></i> Tự động cập nhật</span>
                    <span><i class="bi bi-shield-check me-1"></i> HSR Academy Verified</span>
                </div>
                <hr class="text-muted">
                <div id="lessonContent" class="fs-6 mt-3">
                    ${not empty lessons ? lessons[0].content : 'Hãy chọn một bài học để bắt đầu hoặc chờ giảng viên cập nhật nội dung.'}
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-task me-2 text-primary"></i>Nội dung bài học</h5>
                </div>
                <div class="list-group list-group-flush" id="lessonSidebar" style="max-height: 70vh; overflow-y: auto;">
                    <c:forEach var="lesson" items="${lessons}" varStatus="status">
                        <div class="list-group-item d-flex align-items-center justify-content-between p-3 lesson-link"
                             id="lesson-item-${lesson.lessonId}"
                             onclick="changeVideo('${lesson.videoUrl}', '${lesson.title}', `${lesson.content}`, this)">
                            <div class="d-flex align-items-center overflow-hidden">
                                <div class="me-3">
                                    <span class="badge rounded-pill bg-light text-primary border">${status.index + 1}</span>
                                </div>
                                <div class="text-truncate">
                                    <span class="fw-semibold d-block text-truncate">${lesson.title}</span>
                                    <small class="text-muted"><i class="bi bi-play-circle me-1"></i>Video bài giảng</small>
                                </div>
                            </div>

                            <div class="d-flex gap-1 ms-2">
                                <button class="btn btn-sm btn-light text-warning border-0" title="Sửa bài"
                                        onclick="event.stopPropagation(); prepareEditLesson('${lesson.lessonId}', '${lesson.title}', '${lesson.videoUrl}', `${lesson.content}`)">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <a href="instructor/lesson/delete?id=${lesson.lessonId}&courseId=${course.courseId}"
                                   class="btn btn-sm btn-light text-danger border-0" title="Xóa bài"
                                   onclick="event.stopPropagation(); return confirm('Dữ liệu bài học sẽ bị xóa vĩnh viễn. Tiếp tục?');">
                                    <i class="bi bi-trash3-fill"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty lessons}">
                        <div class="p-5 text-center">
                            <i class="bi bi-inbox text-muted fs-1 d-block mb-3"></i>
                            <p class="text-muted small">Khóa học này đang được chuẩn bị nội dung</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="lessonModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form action="instructor/lesson/save" method="post" class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-dark text-white border-0">
                <h5 class="modal-title" id="lessonModalTitle">Thêm bài học mới</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <input type="hidden" name="courseId" value="${course.courseId}">
                <input type="hidden" name="lessonId" id="editLessonId" value="0">

                <div class="mb-3">
                    <label class="form-label fw-bold">Tiêu đề bài học</label>
                    <input type="text" name="title" id="editLessonTitle" class="form-control form-control-lg fs-6" placeholder="Nhập tên bài học..." required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Mô tả nội dung</label>
                    <textarea name="content" id="editLessonContent" class="form-control" rows="5" placeholder="Học sinh sẽ thấy nội dung này dưới video..."></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Link YouTube</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-youtube text-danger"></i></span>
                        <input type="text" name="videoUrl" id="editLessonVideo" class="form-control" placeholder="Dán link YouTube tại đây...">
                    </div>
                    <small class="text-muted d-block mt-2">Hệ thống hỗ trợ cả link thường (watch?v=) và link rút gọn.</small>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary px-5 fw-bold">Lưu bài học</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Hàm chuyển đổi link và cập nhật nội dung
    function changeVideo(url, title, content, element) {
        const videoIframe = document.getElementById('mainVideo');
        if (!videoIframe) return;

        let videoId = "";
        try {
            // Logic tách ID thông minh
            if (url.includes("v=")) {
                videoId = url.split("v=")[1].split("&")[0];
            } else if (url.includes("youtu.be/")) {
                videoId = url.split("youtu.be/")[1].split("?")[0];
            } else if (url.includes("embed/")) {
                videoId = url.split("embed/")[1].split("?")[0];
            }
        } catch (e) { console.error("URL Error"); }

        if (videoId) {
            videoIframe.src = "https://www.youtube.com/embed/" + videoId + "?rel=0&modestbranding=1";
        } else {
            videoIframe.src = "";
        }

        // Cập nhật text
        document.getElementById('lessonTitle').innerText = title;
        document.getElementById('lessonContent').innerText = content;

        // Xử lý active class cho sidebar
        document.querySelectorAll('.lesson-link').forEach(el => el.classList.remove('active'));
        if (element) element.classList.add('active');

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // Tự động nạp bài học đầu tiên khi trang load xong
    document.addEventListener("DOMContentLoaded", function() {
        const firstLesson = document.querySelector('.lesson-link');
        if (firstLesson) {
            firstLesson.click();
        }
    });

    function prepareAddLesson() {
        document.getElementById('lessonModalTitle').innerText = "Thêm bài học mới";
        document.getElementById('editLessonId').value = "0";
        document.getElementById('editLessonTitle').value = "";
        document.getElementById('editLessonContent').value = "";
        document.getElementById('editLessonVideo').value = "";
    }

    function prepareEditLesson(id, title, video, content) {
        document.getElementById('lessonModalTitle').innerText = "Cập nhật bài học";
        document.getElementById('editLessonId').value = id;
        document.getElementById('editLessonTitle').value = title;
        document.getElementById('editLessonVideo').value = video;
        document.getElementById('editLessonContent').value = content;

        var myModal = new bootstrap.Modal(document.getElementById('lessonModal'));
        myModal.show();
    }
</script>

</body>
</html>