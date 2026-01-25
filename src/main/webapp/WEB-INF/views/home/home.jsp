<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Home | AssignmentHSF</title>

  <!-- Dùng chung CSS với login/register -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css?v=1">

  <!-- Optional: Google Font -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>

<body class="auth-body">
<div class="auth-bg"></div>

<main class="auth-wrap">
  <section class="auth-card">
    <!-- LEFT (giống layout login) -->
    <div class="auth-left">
      <div class="brand">
        <div class="brand-badge">HSF</div>
        <div class="brand-text">
          <div class="brand-title">AssignmentHSF</div>
          <div class="brand-subtitle">Course Management</div>
        </div>
      </div>

      <h1 class="auth-heading">
        Xin chào,
        <span class="wave">👋</span>
        <span style="display:inline-block;margin-left:6px;">
                    <c:out value="${sessionScope.currentUser}" />
                </span>
      </h1>

      <p class="auth-desc">
        Chọn nhanh chức năng bạn cần: hồ sơ, danh sách khoá học, và khoá học đã mua.
      </p>

      <div class="auth-highlights">
        <div class="chip">👤 Profile</div>
        <div class="chip">📚 Courses</div>
        <div class="chip">🛒 Purchased</div>
      </div>

      <div class="auth-footer">
        <span>Status:</span> Logged in · <a class="link" href="${pageContext.request.contextPath}/logout">Logout</a>
      </div>
    </div>

    <!-- RIGHT (nội dung Home) -->
    <div class="auth-right">
      <div class="auth-form-head">
        <h2>Dashboard</h2>
        <p>Trang chính sau khi đăng nhập</p>
      </div>

      <!-- Quick actions -->
      <div style="display:grid; gap:12px; margin-top:10px;">
        <a class="btn" href="${pageContext.request.contextPath}/profile">
          👤 Xem Profile
          <span class="btn-arrow">→</span>
        </a>

        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/courses">
          📚 Xem danh sách khoá học
          <span class="btn-arrow">→</span>
        </a>

        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/my-courses">
          🛒 Khoá học đã mua
          <span class="btn-arrow">→</span>
        </a>
      </div>

      <!-- Sections (placeholder list) -->
      <div style="margin-top:16px;">
        <div class="divider"><span>Overview</span></div>

        <div class="alert" style="margin-top:12px;">
          Tip: Sau này bạn sẽ map 3 link trên tới Controller thật để lấy dữ liệu từ DB.
        </div>

        <div style="display:grid; gap:10px; margin-top:12px;">
          <div class="chip" style="justify-content:space-between; width:100%;">
            <span>✅ Account</span>
            <span style="opacity:.8;">Active</span>
          </div>

          <div class="chip" style="justify-content:space-between; width:100%;">
            <span>📌 Courses</span>
            <span style="opacity:.8;">Browse / Search</span>
          </div>

          <div class="chip" style="justify-content:space-between; width:100%;">
            <span>🧾 My Courses</span>
            <span style="opacity:.8;">Purchase history</span>
          </div>
        </div>
      </div>
    </div>
  </section>

  <p class="copyright">
    © <%= java.time.Year.now() %> AssignmentHSF · All rights reserved
  </p>
</main>

</body>
</html>
