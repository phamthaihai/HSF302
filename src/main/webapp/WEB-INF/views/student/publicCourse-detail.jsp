<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${course.title} | HSR Academy</title>

    <!-- FONT -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">

    <!-- BOOTSTRAP (chỉ dùng grid) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --bg: #f5f7fb;
            --card: #ffffff;
            --primary: #2563eb;
            --text: #0f172a;
            --muted: #6b7280;
            --radius: 18px;
            --shadow: 0 12px 30px rgba(0,0,0,.08);
        }

        body {
            background: var(--bg);
            font-family: Inter, system-ui, sans-serif;
            color: var(--text);
        }

        /* ===== HEADER ===== */
        .top-bar {
            background: linear-gradient(90deg, #1e3a8a, #2563eb);
            padding: 20px 28px;
            border-radius: 18px;
            box-shadow: var(--shadow);
            margin-bottom: 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            font-size: 22px;
            font-weight: 700;
            color: #fff;
        }

        .back-btn {
            background: #ffffff;
            color: #1e3a8a;
            font-weight: 600;
            border-radius: 12px;
            padding: 8px 16px;
            text-decoration: none;
        }

        /* ===== TITLE ===== */
        .course-title {
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        /* ===== VIDEO ===== */
        .video-wrapper {
            background: #000;
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 28px;
        }

        /* ===== CARD ===== */
        .card-custom {
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 28px;
        }

        /* ===== PRICE ===== */
        .price {
            font-size: 22px;
            font-weight: 700;
            color: var(--primary);
        }

        /* ===== BUTTON ===== */
        .btn-enroll {
            background: var(--primary);
            color: #fff;
            border-radius: 14px;
            padding: 12px 26px;
            font-weight: 600;
            text-decoration: none;
        }

        .btn-enroll:hover {
            background: #1d4ed8;
            color: #fff;
        }
        .btn-cart {
            background: #e5e7eb;
            color: #1f2937;
            border-radius: 14px;
            padding: 12px 22px;
            font-weight: 600;
            border: none;
        }

        .btn-cart:hover {
            background: #d1d5db;
        }

    </style>
</head>

<body>


<div class="container mt-4 mb-5">

    <!-- HEADER -->
    <div class="top-bar">
        <a href="${pageContext.request.contextPath}/courses" class="back-btn">
            ← Quay lại
        </a>
        <div class="brand">📚 HSR Academy</div>
    </div>

    <!-- TITLE -->
    <div class="mb-4">
        <h1 class="course-title">${course.title}</h1>
        <p class="text-muted">Khóa học công khai</p>
    </div>

    <!-- VIDEO -->
    <div class="video-wrapper">
        <div class="ratio ratio-16x9">
            <c:choose>
                <c:when test="${not empty course.imageUrl}">
                    <iframe
                            src="https://www.youtube.com/embed/${course.imageUrl}"
                            allowfullscreen>
                    </iframe>
                </c:when>
                <c:otherwise>
                    <div class="d-flex justify-content-center align-items-center text-white">
                        <p>Chưa có video giới thiệu</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- DESCRIPTION + PRICE -->
    <div class="card-custom">
        <h5 class="fw-bold mb-3">Mô tả khóa học</h5>

        <p class="text-secondary mb-4" style="line-height:1.6; white-space: pre-line;">
            ${course.description}
        </p>

        <hr>

        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <div class="text-muted">Giá khóa học</div>
                <div class="price">
                    <fmt:formatNumber value="${course.price}"
                                      type="number"
                                      groupingUsed="true"/> VND
                </div>
            </div>
            <!-- ADD TO CART -->
            <form action="${pageContext.request.contextPath}/cart/add"
                  method="post"
                  style="margin:0;">
                <input type="hidden" name="courseId" value="${course.courseId}">
                <button type="submit" class="btn-cart">
                    🛒 Add to Cart
                </button>
            </form>
            <a href="${pageContext.request.contextPath}/payment/detail?courseId=${course.courseId}"
               class="btn-enroll">
                💳 Thanh toán
            </a>

        </div>
    </div>

</div>

</body>
</html>
