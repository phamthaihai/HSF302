<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Courses | HSR Academy</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>


        .hero {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 40px;
            padding: 60px;
            margin-bottom: 60px;
            border-radius: 28px;
            background: linear-gradient(135deg, #eef2ff, #f8fafc);
            align-items: center;
        }

        .hero h1 {
            font-size: 40px;
            font-weight: 800;
            margin-bottom: 16px;
        }

        .hero p {
            color: #475569;
            max-width: 480px;
            line-height: 1.6;
        }



        .stats {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }

        .stats div strong {
            font-size: 22px;
            display: block;
        }

        .stats span {
            font-size: 13px;
            color: #64748b;
        }

        .hero-img img {
            width: 100%;
            border-radius: 20px;
        }

        :root {
            --bg: #f5f7fb;
            --card: #ffffff;
            --primary: #2563eb;
            --text: #0f172a;
            --muted: #6b7280;
            --radius: 18px;
            --shadow: 0 12px 30px rgba(0,0,0,.08);
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: Inter, system-ui, sans-serif;
            background: var(--bg);
            color: var(--text);
            padding: 32px;
        }

        .container {
            max-width: 1280px;
            margin: auto;
        }

        /* ===== HEADER ===== */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            flex-wrap: wrap;
            gap: 16px;

            background: linear-gradient(90deg, #1e3a8a, #2563eb);
            padding: 20px 28px;
            border-radius: 18px;
            box-shadow: 0 10px 25px rgba(0,0,0,.12);
        }


        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 24px;
            font-weight: 700;
            color: #ffffff;
        }


        .search {
            display: flex;
            gap: 10px;
        }

        .search input {
            padding: 12px 16px;
            border-radius: 12px;
            border: none;
            min-width: 260px;
            outline: none;
        }

        .search button {
            padding: 12px 20px;
            border-radius: 12px;
            border: none;
            background: #facc15;
            color: #000;
            font-weight: 700;
            cursor: pointer;
        }


        /* ===== GRID ===== */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 28px;
        }

        /* ===== CARD ===== */
        .card {
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: .25s ease;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 45px rgba(0,0,0,.12);
        }

        .thumb {
            height: 170px;
            background: linear-gradient(135deg, #7c3aed, #2563eb);
        }

        .content {
            padding: 18px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .title {
            font-size: 17px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .desc {
            font-size: 14px;
            color: var(--muted);
            line-height: 1.5;
            margin-bottom: 16px;

            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
        }

        .price {
            font-weight: 700;
            color: var(--primary);
        }

        .btn {
            padding: 8px 16px;
            border-radius: 12px;
            background: var(--primary);
            color: white;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        .empty {
            background: #fff;
            padding: 32px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            text-align: center;
            color: var(--muted);
        }
        .actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .cart-link {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 10px 14px;
            background: rgba(255,255,255,0.15);
            color: #fff;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.2s;
        }

        .cart-link:hover {
            background: rgba(255,255,255,0.25);
        }
        .thumb {
            height: 170px;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

    </style>

</head>

<body>



<div class="container">

    <div class="top-bar">
        <div class="brand">📚 HSF Academy</div>

        <div class="actions">

            <!-- SEARCH -->
            <form class="search"
                  action="${pageContext.request.contextPath}/courses"
                  method="get">
                <input type="text" name="keyword"
                       placeholder="Tìm kiếm khóa học..."
                       value="${param.keyword}">
                <button>Search</button>
            </form>

            <!-- CART -->
            <a href="${pageContext.request.contextPath}/cart/view"
               class="cart-link">
                🛒 Giỏ hàng
            </a>

        </div>
    </div>


    <c:if test="${empty courses}">
        <div class="empty">❌ Không tìm thấy khóa học</div>
    </c:if>
    <section class="hero">
        <div class="hero-text">
            <h1>Quản lý việc học của bạn<br>hiệu quả hơn</h1>
            <p>
                HSR Academy giúp bạn nâng cao kỹ năng lập trình
                với các khóa học được xây dựng bài bản và thực tế.
            </p>

            <div class="stats">
                <div><strong>12k+</strong><span>Học viên</span></div>
                <div><strong>89%</strong><span>Hoàn thành</span></div>
                <div><strong>3.5k</strong><span>Khóa học</span></div>
            </div>
        </div>

        <div class="hero-img">
            <img src="https://interdata.vn/blog/wp-content/uploads/2025/03/Java-01.jpg"
                 alt="hero">
        </div>
    </section>

    <div class="grid">
        <c:forEach items="${courses}" var="c">
            <div class="card">

                <div class="thumb"
                     style="background-image: url('${c.imageUrl}')">
                </div>


                <div class="content">
                    <div class="title">${c.title}</div>

                    <div class="desc" title="${c.description}">
                            ${c.description}
                    </div>

                    <div class="footer">
                        <div class="price">
                            <fmt:formatNumber value="${c.price}"
                                              type="number"
                                              groupingUsed="true"/> VND
                        </div>

                        <a class="btn"
                           href="${pageContext.request.contextPath}/public/courses/detail?id=${c.courseId}">
                            View details
                        </a>
                    </div>
                </div>

            </div>
        </c:forEach>
    </div>

</div>
</body>
</html>
