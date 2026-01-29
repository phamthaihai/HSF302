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
        .back-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background-color: #f8f9fa;
            color: #333;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            border: 1px solid #ddd;
            transition: all 0.3s ease;
        }

        .btn-back i {
            margin-right: 8px;
        }

        .btn-back:hover {
            background-color: #e2e6ea;
            color: #007bff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transform: translateX(-5px); /* Hiệu ứng nhích nhẹ sang trái khi hover */
        }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container d-flex justify-content-between">
        <a class="navbar-brand" href="courses">HSR ACADEMY</a>
    </div>
</nav>
<div class="back-container">
    <a href="${pageContext.request.contextPath}/admin/home" class="btn-back">
        <i class="fas fa-arrow-left"></i> Quay lại Dashboard
    </a>
</div>
<div class="container">
    <h2 class="text-center mb-4">Quản lý Khám phá các khóa học</h2>
    <form action="courses" method="get" class="row g-2 mb-4">
        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control"
                   placeholder="Tìm theo tên khóa học"
                   value="${param.keyword}">
        </div>

        <div class="col-md-3">
            <input type="number" name="minPrice" class="form-control"
                   placeholder="Giá từ"
                   value="${param.minPrice}">
        </div>

        <div class="col-md-3">
            <input type="number" name="maxPrice" class="form-control"
                   placeholder="Giá đến"
                   value="${param.maxPrice}">
        </div>

        <div class="col-md-2">
            <button class="btn btn-primary w-100">Search</button>
        </div>
    </form>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="course" items="${courses}">
            <div class="col">
                <div class="card h-100 course-card">

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
</body>
</html>