<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thanh toán thành công</title>

  <style>
    body {
      background: #f5f7fa;
      font-family: Arial, sans-serif;
    }

    .success-container {
      width: 420px;
      margin: 80px auto;
      background: #ffffff;
      padding: 30px;
      text-align: center;
      border-radius: 8px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.12);
    }

    .icon {
      font-size: 64px;
      color: #27ae60;
      margin-bottom: 15px;
    }

    h2 {
      color: #2c3e50;
      margin-bottom: 10px;
    }

    p {
      color: #555;
      margin-bottom: 25px;
    }

    .btn {
      display: inline-block;
      padding: 12px 20px;
      background: #3498db;
      color: white;
      text-decoration: none;
      border-radius: 4px;
      font-weight: bold;
    }

    .btn:hover {
      background: #2980b9;
    }
  </style>
</head>
<body>

<div class="success-container">
  <div class="icon">✅</div>

  <h2>Thanh toán thành công!</h2>

  <p>
    Cảm ơn bạn đã mua khóa học.<br>
    Khóa học đã được kích hoạt trong tài khoản của bạn.
  </p>

  <a class="btn" href="${pageContext.request.contextPath}/home">
    ⬅ Quay lại trang chủ
  </a>
</div>

</body>
</html>
