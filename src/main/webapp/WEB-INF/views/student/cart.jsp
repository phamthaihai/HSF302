<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Giỏ hàng</title>

  <style>
    body {
      font-family: Inter, system-ui, sans-serif;
      background: #f5f7fb;
      padding: 40px;
    }

    .cart-box {
      max-width: 800px;
      margin: auto;
      background: #fff;
      border-radius: 18px;
      padding: 30px;
      box-shadow: 0 12px 30px rgba(0,0,0,.08);
    }

    h2 {
      margin-bottom: 24px;
    }

    .item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 0;
      border-bottom: 1px solid #e5e7eb;
    }

    .item h3 {
      margin: 0;
      font-size: 18px;
    }

    .price {
      font-weight: 700;
      color: #2563eb;
    }

    .total {
      text-align: right;
      margin-top: 20px;
      font-size: 18px;
      font-weight: 700;
    }

    .actions {
      margin-top: 30px;
      display: flex;
      justify-content: space-between;
      gap: 16px;
    }

    .btn {
      padding: 12px 22px;
      border-radius: 14px;
      font-weight: 600;
      text-decoration: none;
      border: none;
      cursor: pointer;
    }

    .btn-back {
      background: #e5e7eb;
      color: #000;
    }

    .btn-pay {
      background: #2563eb;
      color: #fff;
    }

    .btn-pay:hover {
      background: #1d4ed8;
    }

    .empty {
      text-align: center;
      color: #6b7280;
    }
  </style>
</head>

<body>

<div class="cart-box">
  <h2>🛒 Giỏ hàng của bạn</h2>

  <!-- GIỎ HÀNG TRỐNG -->
  <c:if test="${sessionScope.CART == null || empty sessionScope.CART.items}">
    <p class="empty">Giỏ hàng trống</p>

    <div class="actions">
      <a class="btn btn-back"
         href="${pageContext.request.contextPath}/public/courses">
        ← Tiếp tục mua khóa học
      </a>
    </div>
  </c:if>

  <!-- GIỎ HÀNG CÓ SẢN PHẨM -->
  <c:if test="${sessionScope.CART != null && not empty sessionScope.CART.items}">
    <c:forEach items="${sessionScope.CART.items}" var="item">
      <div class="item">
        <h3>${item.course.title}</h3>
        <div class="price">
          <fmt:formatNumber value="${item.course.price}"
                            type="number"
                            groupingUsed="true"/> VND
        </div>
      </div>
    </c:forEach>

    <div class="total">
      Tổng tiền:
      <fmt:formatNumber value="${sessionScope.CART.totalAmount}"
                        type="number"
                        groupingUsed="true"/> VND
    </div>

    <!-- ACTIONS -->
    <div class="actions">
      <a class="btn btn-back"
         href="${pageContext.request.contextPath}/public/courses">
        ← Mua thêm
      </a>

      <!-- NÚT THANH TOÁN -->
      <form action="${pageContext.request.contextPath}/checkout" method="post">
        <input type="hidden" name="method" value="BANK"/>

        <button type="submit" class="btn btn-primary">
          Thanh toán
        </button>
      </form>

    </div>
  </c:if>

</div>

</body>
</html>
