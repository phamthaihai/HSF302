<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thanh toán khóa học</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f5f7fa;
    }

    .payment-container {
      width: 420px;
      margin: 60px auto;
      background: #ffffff;
      padding: 25px 30px;
      border-radius: 8px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #2c3e50;
    }

    .course-title {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #34495e;
    }

    .price {
      margin-bottom: 20px;
      color: #e74c3c;
      font-size: 16px;
    }

    label {
      font-weight: 600;
      display: block;
      margin-bottom: 6px;
      margin-top: 12px;
    }

    input[type="text"],
    select {
      width: 100%;
      padding: 9px 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 14px;
    }

    input[readonly] {
      background: #f1f1f1;
    }

    button {
      width: 100%;
      margin-top: 22px;
      padding: 12px;
      background: #27ae60;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 15px;
      font-weight: bold;
      cursor: pointer;
    }

    button:hover {
      background: #219150;
    }

    .note {
      margin-top: 15px;
      font-size: 12px;
      color: #777;
      text-align: center;
    }
  </style>
</head>
<body>

<div class="payment-container">

  <h2>💳 Thanh toán khóa học</h2>

  <div class="course-title">
    ${course.title}
  </div>

  <div class="price">
    Giá:
    <fmt:formatNumber value="${course.price}" groupingUsed="true"/> VND
  </div>

  <form action="${pageContext.request.contextPath}/payment/detail/confirm" method="post">

    <!-- gửi courseId -->
    <input type="hidden" name="courseId" value="${course.courseId}"/>

    <label>Số tiền</label>
    <input type="text"
           value="<fmt:formatNumber value='${course.price}' groupingUsed='true'/> VND"
           readonly>

    <label>Chọn ngân hàng</label>
    <select name="bank" required>
      <option value="">-- Chọn ngân hàng --</option>
      <option value="Vietcombank">Vietcombank</option>
      <option value="Techcombank">Techcombank</option>
      <option value="BIDV">BIDV</option>
      <option value="MB Bank">MB Bank</option>
      <option value="ACB">ACB</option>
    </select>

    <label>Số tài khoản ngân hàng</label>
    <input type="text"
           name="bankAccount"
           placeholder="VD: 0123456789"
           required
           pattern="[0-9]{6,20}"
           title="Số tài khoản phải là số (6–20 chữ số)">

    <button type="submit">✅ Xác nhận thanh toán</button>
  </form>

  <div class="note">
    Hệ thống sẽ tự động kích hoạt khóa học sau khi thanh toán thành công.
  </div>

</div>

</body>
</html>
