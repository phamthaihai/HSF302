<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Student Home</title>

    <style>
        :root{
            --bg1:#0b1030;
            --bg2:#071018;
            --bg3:#0b2a2a;

            --card:#ffffff;
            --border: rgba(255,255,255,0.12);
            --text:#111827;
            --muted:#6b7280;

            --p1:#5b5ce8;
            --p2:#21c07a;
            --shadow: 0 22px 60px rgba(0,0,0,0.35);
            --radius: 18px;
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            min-height:100vh;
            background:
                    radial-gradient(1200px 600px at 18% 10%, rgba(91,92,232,0.35), transparent 60%),
                    radial-gradient(1200px 600px at 85% 18%, rgba(33,192,122,0.22), transparent 55%),
                    linear-gradient(135deg, var(--bg1) 0%, var(--bg2) 40%, var(--bg3) 100%);
            padding: 26px 0;
        }

        a{ text-decoration:none; color:inherit; }
        .shell{
            width:min(1180px, calc(100% - 40px));
            margin:0 auto;
            background: var(--card);
            border-radius: 24px;
            box-shadow: var(--shadow);
            overflow:hidden;
            border: 1px solid rgba(255,255,255,0.10);
        }

        .topbar{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:16px;
            padding: 16px 20px;
            border-bottom: 1px solid #eef2f7;
            background: rgba(255,255,255,0.92);
            backdrop-filter: blur(10px);
        }

        .brand{
            display:flex;
            align-items:center;
            gap:10px;
            font-weight:900;
        }
        .logo{
            width:42px; height:42px;
            border-radius:12px;
            display:grid; place-items:center;
            background: linear-gradient(90deg, var(--p1), var(--p2));
            color:#fff;
            font-weight:900;
            box-shadow: 0 10px 25px rgba(91,92,232,0.18);
        }
        .sub{ font-size:12px; color:var(--muted); margin-top:2px; font-weight:700; }

        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            height:40px;
            padding:0 14px;
            border-radius:999px;
            border:1px solid transparent;
            font-weight:700;
            cursor:pointer;
            transition:.2s ease;
            white-space:nowrap;
        }
        .btn-primary{
            background: linear-gradient(90deg, var(--p1), var(--p2));
            color:#fff;
            box-shadow: 0 12px 26px rgba(91,92,232,0.18);
        }
        .btn-primary:hover{ filter:brightness(0.98); transform:translateY(-1px); }
        .btn-ghost{
            background:#fff;
            border-color:#e5e7eb;
        }

        .content{
            padding: 22px 20px 26px 20px;
        }

        .hero{
            display:grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap:18px;
            align-items:stretch;
        }
        .card{
            border:1px solid #e5e7eb;
            border-radius: var(--radius);
            padding: 16px;
            background:#fff;
            box-shadow: 0 10px 22px rgba(0,0,0,0.06);
        }
        .title{
            margin:0;
            font-size:22px;
            letter-spacing:-0.2px;
            font-weight:900;
        }
        .muted{
            color:var(--muted);
            font-weight:600;
            line-height:1.6;
            margin: 8px 0 0 0;
        }

        .grid{
            display:grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-top: 14px;
        }
        .tile{
            border:1px solid #e5e7eb;
            border-radius: 16px;
            padding: 14px;
            background:
                    radial-gradient(700px 180px at 20% 20%, rgba(91,92,232,0.10), transparent 60%),
                    radial-gradient(700px 180px at 80% 35%, rgba(33,192,122,0.08), transparent 55%),
                    linear-gradient(135deg, #ffffff 0%, #fbfbff 100%);
            transition:.2s ease;
        }
        .tile:hover{ transform: translateY(-2px); box-shadow: 0 14px 30px rgba(0,0,0,0.08); }
        .tile h3{ margin:0; font-size:14px; font-weight:900; }
        .tile p{ margin:6px 0 0 0; font-size:13px; color:var(--muted); font-weight:600; }

        .rightBox{
            border-radius: 22px;
            padding: 16px;
            color:#fff;
            border: 1px solid rgba(255,255,255,0.10);
            background:
                    radial-gradient(900px 450px at 20% 20%, rgba(91,92,232,0.38), transparent 60%),
                    radial-gradient(900px 450px at 80% 30%, rgba(33,192,122,0.22), transparent 55%),
                    linear-gradient(135deg, #0b1220 0%, #141b2b 100%);
            box-shadow: 0 18px 40px rgba(0,0,0,0.18);
            position:relative;
            overflow:hidden;
        }
        .rightBox::before{
            content:"";
            position:absolute;
            inset:-40%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.10), transparent);
            transform: rotate(18deg);
        }
        .rightBox .kicker{
            position:relative;
            font-weight:900;
            font-size:16px;
        }
        .rightBox .small{
            position:relative;
            margin-top:6px;
            color: rgba(255,255,255,0.75);
            font-weight:700;
            font-size:13px;
            line-height:1.6;
        }

        @media (max-width: 980px){
            .hero{ grid-template-columns: 1fr; }
            .grid{ grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 640px){
            .grid{ grid-template-columns: 1fr; }
            .shell{ width: calc(100% - 24px); }
        }
    </style>
</head>
<body>

<div class="shell">

    <div class="topbar">
        <div class="brand">
            <div class="logo">SU</div>
            <div>
                <div>SkillUp</div>
                <div class="sub">Student Dashboard</div>
            </div>
        </div>

        <div style="display:flex; gap:10px; align-items:center;">

            <a class="btn btn-primary" href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="content">
        <div class="hero">
            <div class="card">
                <h1 class="title">
                    Xin chào,
                    <c:out value="${sessionScope.currentUserName}" default="Student"/>
                    👋
                </h1>
                <p class="muted">
                    Đây là trang Home của Student. Bạn có thể tiếp tục học, xem khóa học đã mua, hoặc cập nhật hồ sơ.
                </p>

                <div class="grid">
                    <a class="tile" href="${pageContext.request.contextPath}/public/courses">
                        <h3>Khám phá khóa học</h3>
                        <p>Xem danh sách khóa học công khai</p>
                    </a>

                    <a class="tile" href="${pageContext.request.contextPath}/student/my-courses">
                        <h3>Khóa học của tôi</h3>
                        <p>Danh sách khóa học đã đăng ký</p>
                    </a>

                    <a class="tile" href="${pageContext.request.contextPath}/student/profile">
                        <h3>Hồ sơ cá nhân</h3>
                        <p>Cập nhật thông tin của bạn</p>
                    </a>

                </div>
            </div>

            <div class="rightBox">
                <div class="kicker">Gợi ý hôm nay</div>
                <div class="small">
                    • Hoàn thành 1 bài học<br/>
                    • Xem lại ghi chú<br/>
                    • Chọn 1 khóa học mới để bắt đầu
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>
