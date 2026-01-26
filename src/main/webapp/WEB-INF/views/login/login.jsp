<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login | AssignmentHSF</title>

    <!-- CSS (Cách 1: assets nằm ngoài WEB-INF) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css" />

    <!-- Optional: Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>

<body class="auth-body">
<div class="auth-bg"></div>

<main class="auth-wrap">
    <section class="auth-card">
        <div class="auth-left">
            <div class="brand">
                <div class="brand-badge">HSF</div>
                <div class="brand-text">
                    <div class="brand-title">AssignmentHSF</div>
                    <div class="brand-subtitle">Course Management</div>
                </div>
            </div>

            <h1 class="auth-heading">Welcome back <span class="wave">👋</span></h1>
            <p class="auth-desc">
                Đăng nhập để quản lý khoá học, bài học và hồ sơ của bạn.
            </p>

            <div class="auth-highlights">
                <div class="chip">⚡ Fast Spring MVC</div>
                <div class="chip">🔒 Secure Login</div>
                <div class="chip">✨ Clean UI</div>
            </div>

            <div class="auth-footer">
                <span>Tip:</span> Bạn đang chạy trên Tomcat 10.1 + Spring 6
            </div>
        </div>

        <div class="auth-right">
            <div class="auth-form-head">
                <h2>Đăng nhập</h2>
                <p>Nhập thông tin để tiếp tục.</p>
            </div>

            <!-- Thông báo lỗi (nếu bạn set từ Controller) -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                        ${error}
                </div>
            </c:if>

            <!-- Thông báo thành công (nếu bạn set từ Controller) -->
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                        ${message}
                </div>
            </c:if>

            <!-- Form -->
            <form class="form" method="post" action="${pageContext.request.contextPath}/login">
                <label class="field">
                    <span class="label">Username / Email</span>
                    <input
                            class="input"
                            type="text"
                            name="username"
                            placeholder="vd: dungtrinh"
                            autocomplete="username"
                            required
                    />
                </label>

                <label class="field">
                    <span class="label">Password</span>
                    <div class="input-wrap">
                        <input
                                id="password"
                                class="input"
                                type="password"
                                name="password"
                                placeholder="••••••••"
                                autocomplete="current-password"
                                required
                        />
                        <button type="button" class="toggle" onclick="togglePassword()" aria-label="Show password">
                            👁
                        </button>
                    </div>
                </label>

                <div class="row">
                    <label class="check">
                        <input type="checkbox" name="remember" />
                        <span>Remember me</span>
                    </label>

                    <a class="link" href="${pageContext.request.contextPath}/forgot-password">
                        Forgot password?
                    </a>
                </div>

                <button class="btn" type="submit">
                    Sign in
                    <span class="btn-arrow">→</span>
                </button>

                <div class="divider">
                    <span>or</span>
                </div>

                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/register">
                    Create account
                </a>
            </form>
        </div>
    </section>

    <p class="copyright">
        © <%= java.time.Year.now() %> AssignmentHSF · All rights reserved
    </p>
</main>

<script>
    function togglePassword() {
        const pw = document.getElementById("password");
        pw.type = (pw.type === "password") ? "text" : "password";
    }
</script>

</body>
</html>
