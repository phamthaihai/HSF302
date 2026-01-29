<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Home | AssignmentHSF</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css?v=1">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body.dashboard .auth-wrap{
            width: 100%;
            max-width: none;
            min-height: 100vh;
            padding: 24px;
            display: flex;
            justify-content: center;
            align-items: stretch;
        }
        body.dashboard .auth-card{
            width: 100%;
            max-width: none;
            min-height: calc(100vh - 48px);
            border-radius: 18px;
            display: flex;
        }
        body.dashboard .auth-left,
        body.dashboard .auth-right{
            flex: 1;
        }
    </style>
</head>

<body class="auth-body dashboard">
<div class="auth-bg"></div>

<main class="auth-wrap">
    <section class="auth-card">

        <!-- LEFT -->
        <div class="auth-left">
            <div class="brand">
                <div class="brand-badge">HSF</div>
                <div class="brand-text">
                    <div class="brand-title">AssignmentHSF</div>
                    <div class="brand-subtitle">Course Management</div>
                </div>
            </div>

            <h1 class="auth-heading">
                Xin chào Admin,
                <span class="wave">👋</span>
                <span style="display:inline-block;margin-left:6px;">
          <c:out value="${sessionScope.currentUserName}" />
        </span>
            </h1>

            <p class="auth-desc">
                Quản trị hệ thống: quản lý người dùng, phân quyền, khoá học và theo dõi thống kê.
            </p>

            <div class="auth-highlights">
                <div class="chip">👑 Admin</div>
                <div class="chip">👤 Users</div>
                <div class="chip">🔐 Roles</div>
            </div>

            <div class="auth-footer">
                <span>Status:</span> Logged in ·
                <a class="link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>

        <!-- RIGHT -->
        <div class="auth-right">
            <div class="auth-form-head">
                <h2>Admin Dashboard</h2>
                <p>Trang quản trị sau khi đăng nhập</p>
            </div>

            <!-- Quick actions -->
            <div style="display:grid; gap:12px; margin-top:10px;">
                <a class="btn" href="${pageContext.request.contextPath}/admin/users">
                    👤 Quản lý Users
                    <span class="btn-arrow">→</span>
                </a>

                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/roles">
                    🔐 Quản lý Roles
                    <span class="btn-arrow">→</span>
                </a>

                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/courses">
                    📚 Quản lý Courses
                    <span class="btn-arrow">→</span>
                </a>

                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/reports">
                    📊 Reports / Statistics
                    <span class="btn-arrow">→</span>
                </a>
            </div>

            <!-- Overview -->
            <div style="margin-top:16px;">
                <div class="divider"><span>Overview</span></div>

                <div class="alert" style="margin-top:12px;">
                    Tip: Sau này bạn sẽ map các link admin/* tới controller thật để lấy dữ liệu từ DB.
                </div>

                <div style="display:grid; gap:10px; margin-top:12px;">
                    <div class="chip" style="justify-content:space-between; width:100%;">
                        <span>✅ System</span>
                        <span style="opacity:.8;">Running</span>
                    </div>

                    <div class="chip" style="justify-content:space-between; width:100%;">
                        <span>👥 User Management</span>
                        <span style="opacity:.8;">Create / Lock</span>
                    </div>

                    <div class="chip" style="justify-content:space-between; width:100%;">
                        <span>🔐 Role & Access</span>
                        <span style="opacity:.8;">RBAC</span>
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
