<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AssignmentHSF - Hồ sơ cá nhân</title>

    <style>
        :root{
            --bg1:#0b1020;
            --bg2:#0c3a3a;
            --card:#ffffff;
            --text:#0f172a;
            --muted:#64748b;
            --line:#e5e7eb;
            --primary1:#4f46e5; /* tím xanh */
            --primary2:#22c55e; /* xanh lá */
            --shadow: 0 22px 60px rgba(0,0,0,.25);
            --radius: 18px;
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            color:var(--text);
            min-height:100vh;
            background:
                    radial-gradient(800px 500px at 20% 15%, rgba(79,70,229,.35), transparent 55%),
                    radial-gradient(900px 600px at 85% 30%, rgba(34,197,94,.28), transparent 55%),
                    radial-gradient(700px 520px at 45% 95%, rgba(251,191,36,.18), transparent 55%),
                    linear-gradient(135deg, var(--bg1) 0%, var(--bg2) 55%, #081024 100%);
            display:flex;
            align-items:center;
            justify-content:center;
            padding:34px 16px;
        }

        a{ color:inherit; text-decoration:none; }

        .wrap{
            width:min(1120px, 100%);
            position:relative;
        }

        .card{
            background:var(--card);
            border-radius: 22px;
            box-shadow: var(--shadow);
            overflow:hidden;
            display:grid;
            grid-template-columns: 1.05fr 0.95fr;
            min-height: 560px;
            border:1px solid rgba(255,255,255,.2);
        }

        .left{
            padding:34px 34px 28px 34px;
            background:
                    radial-gradient(900px 500px at 25% 25%, rgba(79,70,229,.20), transparent 55%),
                    radial-gradient(900px 500px at 75% 35%, rgba(34,197,94,.18), transparent 55%),
                    linear-gradient(180deg, #f8fbff 0%, #f2f7ff 60%, #f9fbff 100%);
            border-right:1px solid var(--line);
        }

        .brand{
            display:flex;
            align-items:center;
            gap:12px;
            margin-bottom:18px;
        }
        .logo{
            width:44px; height:44px;
            border-radius:14px;
            display:grid;
            place-items:center;
            font-weight:900;
            color:#fff;
            background: linear-gradient(135deg, var(--primary1), var(--primary2));
            box-shadow: 0 10px 24px rgba(79,70,229,.18);
        }
        .brandText .name{
            font-weight:900;
            letter-spacing:.2px;
        }
        .brandText .sub{
            color:var(--muted);
            font-size:13px;
            margin-top:2px;
        }

        .title{
            font-size:42px;
            line-height:1.12;
            margin:10px 0 8px 0;
            letter-spacing:-.6px;
        }
        .desc{
            color:var(--muted);
            line-height:1.65;
            max-width: 520px;
            margin:0 0 18px 0;
        }

        .chips{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
            margin-top:14px;
        }
        .chip{
            display:inline-flex;
            align-items:center;
            gap:8px;
            padding:10px 12px;
            border-radius:999px;
            background:#eef2ff;
            color:#4338ca;
            border:1px solid #e0e7ff;
            font-weight:700;
            font-size:13px;
        }

        .tip{
            margin-top:18px;
            padding-top:16px;
            border-top:1px dashed #dbeafe;
            color:var(--muted);
            font-size:14px;
        }

        .right{
            padding:34px;
            display:flex;
            flex-direction:column;
            gap:14px;
        }

        .right h2{
            margin:0;
            font-size:26px;
            letter-spacing:-.2px;
        }
        .right p.sub{
            margin:0 0 6px 0;
            color:var(--muted);
        }

        .alert{
            border:1px solid #fecaca;
            background:#fff1f2;
            color:#991b1b;
            padding:12px 14px;
            border-radius:14px;
            font-weight:600;
        }

        .grid{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:12px;
            margin-top:6px;
        }

        .field{
            border:1px solid var(--line);
            border-radius:14px;
            padding:12px 14px;
            background:#fff;
        }
        .field .label{
            font-size:12px;
            color:var(--muted);
            font-weight:800;
            letter-spacing:.3px;
            text-transform:uppercase;
        }
        .field .value{
            margin-top:6px;
            font-weight:800;
            color:#0f172a;
            word-break:break-word;
        }

        .status{
            display:inline-flex;
            align-items:center;
            gap:8px;
            margin-top:6px;
            padding:8px 10px;
            border-radius:999px;
            font-weight:800;
            font-size:12px;
            border:1px solid;
            width:fit-content;
        }
        .status--active{
            color:#166534;
            background:#ecfdf5;
            border-color:#bbf7d0;
        }
        .status--inactive{
            color:#991b1b;
            background:#fff1f2;
            border-color:#fecaca;
        }

        .actions{
            margin-top:auto;
            display:flex;
            gap:10px;
            align-items:center;
            flex-wrap:wrap;
            padding-top:10px;
            border-top:1px solid var(--line);
        }

        .btn{
            height:42px;
            padding:0 14px;
            border-radius:999px;
            border:1px solid var(--line);
            background:#fff;
            font-weight:800;
            cursor:pointer;
            display:inline-flex;
            align-items:center;
            gap:8px;
            transition:.18s ease;
        }
        .btn:hover{ background:#f8fafc; }

        .btnPrimary{
            border:none;
            color:#fff;
            background: linear-gradient(90deg, var(--primary1), var(--primary2));
            box-shadow: 0 12px 26px rgba(79,70,229,.18);
        }
        .btnPrimary:hover{ filter:brightness(.98); }

        .footer{
            position:absolute;
            left:0; right:0;
            bottom:-40px;
            text-align:center;
            color:rgba(255,255,255,.65);
            font-weight:600;
            font-size:13px;
            padding:8px 0;
        }

        @media (max-width: 980px){
            .card{ grid-template-columns: 1fr; }
            .left{ border-right:none; border-bottom:1px solid var(--line); }
            .title{ font-size:34px; }
            .grid{ grid-template-columns: 1fr; }
            .footer{ bottom:-52px; }
        }
    </style>
</head>

<body>
<div class="wrap">
    <div class="card">

        <!-- LEFT PANEL -->
        <div class="left">
            <div class="brand">
                <div class="logo">HSF</div>
                <div class="brandText">
                    <div class="name">AssignmentHSF</div>
                    <div class="sub">Course Management</div>
                </div>
            </div>

            <div class="title">Hồ sơ cá nhân ✨</div>
            <p class="desc">
                Xem thông tin tài khoản của bạn được lấy trực tiếp từ hệ thống.
                Nếu cần chỉnh sửa, bạn có thể bổ sung trang <b>Edit Profile</b> sau.
            </p>

            <div class="chips">
                <div class="chip">👤 Profile</div>
                <div class="chip">🔒 Secure</div>
                <div class="chip">⚡ MVC Flow</div>
            </div>

            <div class="tip">
                <b>Tip:</b> Nếu bạn chưa đăng nhập, hệ thống sẽ tự chuyển về trang login.
            </div>
        </div>

        <!-- RIGHT PANEL -->
        <div class="right">
            <h2>Thông tin user</h2>
            <p class="sub">Dữ liệu load từ database (users, roles)</p>

            <c:if test="${not empty error}">
                <div class="alert">${error}</div>
            </c:if>

            <c:if test="${not empty profile}">
                <div class="grid">
                    <div class="field">
                        <div class="label">User ID</div>
                        <div class="value">${profile.user_id}</div>
                    </div>

                    <div class="field">
                        <div class="label">Role</div>
                        <div class="value">
                            <c:choose>
                                <c:when test="${empty profile.role_name}">N/A</c:when>
                                <c:otherwise>${profile.role_name}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="field" style="grid-column: 1 / -1;">
                        <div class="label">Full name</div>
                        <div class="value">${profile.full_name}</div>
                    </div>

                    <div class="field" style="grid-column: 1 / -1;">
                        <div class="label">Email</div>
                        <div class="value">${profile.email}</div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${profile.status == 1}">
                        <div class="status status--active">✅ ACTIVE</div>
                    </c:when>
                    <c:otherwise>
                        <div class="status status--inactive">⛔ INACTIVE</div>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <div class="actions">
                <a class="btn" href="${pageContext.request.contextPath}/student/home">← Về Home Student</a>

                <a class="btn btnPrimary" href="${pageContext.request.contextPath}/logout">Logout →</a>
            </div>
        </div>

    </div>

    <div class="footer">© 2026 AssignmentHSF • All rights reserved</div>
</div>
</body>
</html>
