<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khóa học | HSR Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .course-card { transition: transform 0.3s; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.1); position: relative; }
        .admin-controls { position: absolute; top: 10px; right: 10px; z-index: 10; display: flex; gap: 5px; }
        .price-tag { color: #d9534f; font-weight: bold; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container d-flex justify-content-between">
        <a class="navbar-brand" href="courses">HSR ACADEMY</a>
        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#courseModal" onclick="prepareAdd()">
            + Thêm khóa học (Admin)
        </button>
    </div>
</nav>

<div class="container">
    <h2 class="text-center mb-4">Quản lý Khám phá các khóa học</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="course" items="${courses}">
            <div class="col">
                <div class="card h-100 course-card">
                    <div class="admin-controls">
                        <button class="btn btn-sm btn-warning" onclick="prepareEdit('${course.courseId}', '${course.title}', '${course.description}', '${course.price}', '${course.imageUrl}')" data-bs-toggle="modal" data-bs-target="#courseModal">Sửa</button>
                        <a href="admin/course/delete?id=${course.courseId}" class="btn btn-sm btn-danger" onclick="return confirm('Xóa khóa học này?')">Xóa</a>
                    </div>

                    <img src="${course.imageUrl}" class="card-img-top" style="height: 180px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">${course.title}</h5>
                        <p class="card-text text-muted" style="height: 45px; overflow: hidden;">${course.description}</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="price-tag">${course.price} VNĐ</span>
                            <a href="course-detail?id=${course.courseId}" class="btn btn-outline-primary">Chi tiết</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="modal fade" id="courseModal" tabindex="-1">
    <div class="modal-dialog">
        <form action="admin/course/save" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Thêm Khóa Học</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="courseId" id="courseId">
                <div class="mb-3">
                    <label class="form-label">Tiêu đề</label>
                    <input type="text" name="title" id="title" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mô tả</label>
                    <textarea name="description" id="description" class="form-control" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Giá tiền</label>
                    <input type="number" name="price" id="price" class="form-control">
                </div>
                <div class="mb-3">
                    <label class="form-label">Link ảnh (URL)</label>
                    <input type="text" name="imageUrl" id="imageUrl" class="form-control">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<script>
    function prepareAdd() {
        document.getElementById('modalTitle').innerText = "Thêm Khóa Học Mới";
        document.getElementById('courseId').value = "0";
        document.getElementById('title').value = "";
    }
    function prepareEdit(id, title, desc, price, img) {
        document.getElementById('modalTitle').innerText = "Cập nhật Khóa Học";
        document.getElementById('courseId').value = id;
        document.getElementById('title').value = title;
        document.getElementById('description').value = desc;
        document.getElementById('price').value = price;
        document.getElementById('imageUrl').value = img;
    }
</script>
</body>
</html>