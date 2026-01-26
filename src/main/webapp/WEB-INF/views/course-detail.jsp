<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course Detail</title>
    <style>
        body {
            font-family: "Segoe UI", Arial;
            background: #f5f7fa;
            padding: 40px;
        }
        .detail-box {
            background: white;
            max-width: 900px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .banner {
            height: 260px;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .content {
            padding: 30px;
        }
        h1 {
            margin-top: 0;
        }
        .price {
            font-size: 20px;
            font-weight: bold;
            margin: 20px 0;
        }
        .btn {
            display: inline-block;
            padding: 12px 20px;
            background: #0056d2;
            color: white;
            text-decoration: none;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="detail-box">
    <div class="banner"></div>

    <div class="content">
        <h1>${course.title}</h1>

        <p style="color:#555; line-height:1.6">
            ${course.description}
        </p>

        <div class="price">${course.price} VND</div>

        <a class="btn"
        href="${pageContext.request.contextPath}/payment?courseId=${course.courseId}">
            Payment
        </a>
        </a>
        </a>
    </div>
</div>

</body>
</html>
