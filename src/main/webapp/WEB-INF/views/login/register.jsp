<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Register | AssignmentHSF</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css?v=1">

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

            <h1 class="auth-heading">Create account <span class="wave">✨</span></h1>
            <p class="auth-desc">
                Đăng ký để bắt đầu học và quản lý khoá học của bạn.
            </p>

            <div class="auth-highlights">
                <div class="chip">🧑‍🎓 Student-ready</div>
                <div class="chip">🔐 Secure</div>
                <div class="chip">🚀 Fast setup</div>
            </div>

            <div class="auth-footer">
                <span>Tip:</span> Sau khi đăng ký, bạn có thể đăng nhập ngay.
            </div>
        </div>

        <div class="auth-right">
            <div class="auth-form-head">
                <h2>Đăng ký</h2>
                <p>Điền thông tin để tạo tài khoản.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <form class="form" method="post" action="${pageContext.request.contextPath}/register">

                <!-- Full name -->
                <label class="field">
                    <span class="label">Full name</span>
                    <input class="input" type="text" name="fullName"
                           value="${param.fullName}"
                           placeholder="vd: Dũng Trịnh" required />
                </label>

                <!-- Email -->
                <label class="field">
                    <span class="label">Email (dùng để đăng nhập)</span>
                    <input class="input" type="email" name="email"
                           value="${param.email}"
                           placeholder="vd: dung@gmail.com" required />
                </label>

                <!-- Role dropdown -->
                <label class="field">
                    <span class="label">Role</span>
                    <select class="input" name="roleName" required>
                        <c:forEach var="r" items="${roles}">
                            <option value="${r}"
                                    <c:if test="${r == selectedRole}">selected</c:if>>
                                    ${r}
                            </option>
                        </c:forEach>
                    </select>
                </label>

                <!-- Password -->
                <label class="field">
                    <span class="label">Password</span>
                    <div class="input-wrap">
                        <input id="pw" class="input" type="password"
                               name="password" placeholder="••••••••" required />
                        <button type="button" class="toggle"
                                onclick="toggle('pw')" aria-label="Show password">👁</button>
                    </div>
                </label>

                <!-- Confirm password -->
                <label class="field">
                    <span class="label">Confirm password</span>
                    <div class="input-wrap">
                        <input id="pw2" class="input" type="password"
                               name="confirmPassword" placeholder="••••••••" required />
                        <button type="button" class="toggle"
                                onclick="toggle('pw2')" aria-label="Show password">👁</button>
                    </div>
                </label>

                <label class="check" style="margin-top: 6px;">
                    <input type="checkbox" required />
                    <span>Tôi đồng ý với điều khoản sử dụng</span>
                </label>

                <button class="btn" type="submit">
                    Create account
                    <span class="btn-arrow">→</span>
                </button>

                <div class="divider">
                    <span>or</span>
                </div>

                <a class="btn btn-ghost" href="${pageContext.request.contextPath}/login">
                    Back to login
                </a>
            </form>
        </div>
    </section>

    <p class="copyright">
        © <%= java.time.Year.now() %> AssignmentHSF · All rights reserved
    </p>
</main>

<script>
    function toggle(id) {
        const el = document.getElementById(id);
        el.type = (el.type === "password") ? "text" : "password";
    }
</script>
</body>
</html>
