<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Courses | StudyHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #f5f7fb;
            --card: #ffffff;
            --primary: #2563eb;
            --primary-light: #60a5fa;
            --text: #0f172a;
            --muted: #6b7280;
            --radius: 16px;
            --shadow: 0 10px 28px rgba(0,0,0,0.08);
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(180deg, rgba(37,99,235,0.05), transparent 40%), var(--bg);
            color: var(--text);
            padding: 32px;
        }
        .container {
            max-width: 1100px;
            margin: auto;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
        }
        form.search {
            display: flex;
            gap: 8px;
        }
        form.search input {
            padding: 10px 14px;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            min-width: 220px;
        }
        form.search button {
            padding: 10px 16px;
            border-radius: 10px;
            border: none;
            background: var(--primary);
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 22px;
        }
        .card {
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform .2s ease, box-shadow .2s ease;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 36px rgba(0,0,0,0.12);
        }
        .thumb {
            height: 160px;
            background: linear-gradient(135deg, #7c3aed, #2563eb);
        }
        .content {
            padding: 18px;
            flex: 1;
            display: flex;
            flex-direction: column;
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
            flex: 1;
            margin-bottom: 14px;
        }
        .footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .price {
            font-weight: 700;
            color: var(--primary);
        }
        .btn {
            padding: 8px 14px;
            border-radius: 10px;
            background: var(--primary);
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
        .back {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
        }
        .empty {
            padding: 30px;
            background: #fff;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            text-align: center;
            color: var(--muted);
        }
    </style>
</head>
<body>
<div class="container">

    <a class="back" href="javascript:history.back()">⬅ Back</a>

    <div class="top-bar">
        <h2>📚 Collections selected by FPT University</h2>
        <form class="search" action="${pageContext.request.contextPath}/courses" method="get">
            <input type="text" name="keyword" placeholder="Search course..." value="${param.keyword}" />
            <button type="submit">Search</button>
        </form>
    </div>

    <c:if test="${empty courses}">
        <div class="empty">❌ No courses found</div>
    </c:if>

    <div class="grid">
        <c:forEach items="${courses}" var="c">
            <div class="card">
                <div class="thumb"></div>
                <div class="content">
                    <div class="title">${c.title}</div>
                    <div class="desc">${c.description}</div>
                    <div class="footer">
                        <div class="price">${c.price} VND</div>
                        <a class="btn" href="${pageContext.request.contextPath}/courses/detail?id=${c.courseId}">
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