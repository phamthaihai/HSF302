<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SkillUp - Home (Guest)</title>

  <style>
    :root{
      /* ===== NEW THEME (match register/admin dark gradient) ===== */
      --bgDark1:#0b1030;
      --bgDark2:#071018;
      --bgDark3:#0b2a2a;

      --text:#1c1f2a;
      --muted:#6b7280;

      --border:#e5e7eb;
      --card:#ffffff;

      --primary1:#5b5ce8; /* purple */
      --primary2:#21c07a; /* green */
      --primaryText:#ffffff;

      --shadow: 0 22px 60px rgba(0,0,0,0.35);
      --radius: 18px;

      /* keep for compatibility */
      --bg: #f6fbff;
      --bg2:#eef7ff;
      --primary: var(--primary1);
    }

    *{ box-sizing:border-box; }
    body{
      margin:0;
      font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
      color:var(--text);
      min-height:100vh;

      /* dark gradient like register/admin */
      background:
              radial-gradient(1200px 600px at 18% 10%, rgba(91,92,232,0.35), transparent 60%),
              radial-gradient(1200px 600px at 85% 18%, rgba(33,192,122,0.22), transparent 55%),
              linear-gradient(135deg, var(--bgDark1) 0%, var(--bgDark2) 40%, var(--bgDark3) 100%);
    }
    a{ text-decoration:none; color:inherit; }
    .container{
      width:min(1180px, calc(100% - 40px));
      margin:0 auto;
    }

    /* Wrap whole page in white "card" like register */
    .pageShell{
      width:min(1180px, calc(100% - 40px));
      margin: 26px auto;
      background: var(--card);
      border-radius: 24px;
      box-shadow: var(--shadow);
      overflow:hidden;
      border: 1px solid rgba(255,255,255,0.10);
    }

    .btn{
      display:inline-flex;
      align-items:center;
      justify-content:center;
      gap:8px;
      height:40px;
      padding:0 14px;
      border-radius:999px;
      border:1px solid transparent;
      font-weight:600;
      cursor:pointer;
      transition: .2s ease;
      white-space: nowrap;
    }
    /* primary now gradient like register */
    .btn--primary{
      background: linear-gradient(90deg, var(--primary1), var(--primary2));
      color:var(--primaryText);
      box-shadow: 0 12px 26px rgba(91,92,232,0.18);
    }
    .btn--primary:hover{ filter: brightness(0.98); transform: translateY(-1px); }

    .btn--ghost{
      background:#fff;
      border-color:var(--border);
    }
    .btn--ghost:hover{ background:#fafafa; }
    .btn--pill{
      background:#fff;
      border:1px solid var(--border);
    }
    .btn--pill:hover{ background:#fafafa; }
    .btn--lg{
      height:46px;
      padding:0 18px;
      border-radius:999px;
    }

    /* ===== HEADER ===== */
    .header{
      position:sticky;
      top:0;
      z-index:50;

      /* match register feel: light but slightly glassy */
      background: rgba(255,255,255,0.92);
      backdrop-filter: blur(10px);
      border-bottom:1px solid var(--border);
    }
    .header__inner{
      display:flex;
      align-items:center;
      gap:16px;
      padding:14px 0;
    }

    .brand{
      display:flex;
      align-items:center;
      gap:10px;
      min-width: 150px;
    }
    .brand__logo{
      width:42px; height:42px;
      border-radius:12px;
      display:grid; place-items:center;

      /* gradient logo like register */
      background: linear-gradient(90deg, var(--primary1), var(--primary2));
      color:#fff;
      border:1px solid rgba(0,0,0,0.06);
      font-weight:900;
      box-shadow: 0 10px 25px rgba(91,92,232,0.18);
    }
    .brand__title{ font-weight:900; line-height:1; }
    .brand__sub{ font-size:12px; color:var(--muted); margin-top:2px; }

    .search{
      flex:1;
      display:flex;
      align-items:center;
      gap:10px;
      background:#fff;
      border:1px solid var(--border);
      border-radius:999px;
      padding:10px 14px;
    }
    .search__input{
      border:none;
      outline:none;
      width:100%;
      font-size:14px;
    }
    .search__icon{ color:var(--muted); }

    .nav{
      display:flex;
      align-items:center;
      gap:16px;
    }
    .nav__link{
      font-weight:700;
      color:#2b2f3a;
      padding:10px 6px;
    }
    .nav__link.active{
      position:relative;
    }
    .nav__link.active::after{
      content:"";
      position:absolute;
      left:6px; right:6px; bottom:2px;
      height:3px;
      border-radius:999px;
      background: linear-gradient(90deg, var(--primary1), var(--primary2));
    }
    .nav__icon{ font-size:18px; padding:8px 10px; }

    .auth{
      display:flex;
      align-items:center;
      gap:10px;
    }

    /* categories row */
    .categories{
      display:flex;
      justify-content:center;
      gap:24px;
      padding:8px 0 14px 0;
    }
    .categories__item{
      font-weight:700;
      color:#2b2f3a;
      padding:6px 10px;
      border-radius:999px;
    }
    .categories__item:hover{ background:#f5f7fb; }

    /* ===== HERO ===== */
    .hero{
      /* keep structure, just adjust background to softer gradient */
      background:
              radial-gradient(900px 450px at 20% 10%, rgba(91,92,232,0.10), transparent 55%),
              radial-gradient(900px 450px at 80% 15%, rgba(33,192,122,0.08), transparent 55%),
              linear-gradient(180deg, #ffffff 0%, #fbfbff 70%, #ffffff 100%);
      padding:52px 0;
    }
    .hero__inner{
      display:grid;
      grid-template-columns: 1.1fr 0.9fr;
      gap:34px;
      align-items:center;
    }
    .badge{
      display:inline-flex;
      align-items:center;
      gap:8px;
      background:#ffffff;
      border:1px solid var(--border);
      padding:8px 12px;
      border-radius:999px;
      color:#374151;
      font-weight:700;
      width:fit-content;
    }
    .hero__title{
      font-size:44px;
      margin:14px 0 12px 0;
      line-height:1.15;
      letter-spacing:-0.5px;
    }
    .hero__desc{
      color:var(--muted);
      font-size:15px;
      line-height:1.6;
      max-width: 560px;
      font-weight:600;
    }
    .hero__actions{ margin-top:18px; }

    .stats{
      display:flex;
      gap:22px;
      margin-top:26px;
      flex-wrap:wrap;
    }
    .stat__label{
      font-size:11px;
      color:var(--muted);
      font-weight:800;
      letter-spacing:0.3px;
    }
    .stat__value{
      font-size:22px;
      font-weight:900;
      margin-top:6px;
    }

    /* hero placeholder (no image) */
    .hero__placeholder{
      border-radius: 22px;
      box-shadow: 0 18px 40px rgba(0,0,0,0.18);
      aspect-ratio: 4 / 3;
      background:
              radial-gradient(1200px 400px at 20% 20%, rgba(91,92,232,0.38), transparent 60%),
              radial-gradient(900px 450px at 80% 30%, rgba(33,192,122,0.22), transparent 55%),
              linear-gradient(135deg, #0b1220 0%, #141b2b 100%);
      border:1px solid rgba(255,255,255,0.08);
      display:flex;
      align-items:flex-end;
      padding:18px;
      overflow:hidden;
      position:relative;
    }
    .hero__placeholder::before{
      content:"";
      position:absolute;
      inset:-40%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.10), transparent);
      transform: rotate(18deg);
    }
    .hero__placeholderText{
      position:relative;
      color:rgba(255,255,255,0.88);
      font-weight:900;
      line-height:1.2;
    }
    .hero__placeholderSub{
      position:relative;
      color:rgba(255,255,255,0.62);
      margin-top:6px;
      font-size:13px;
      font-weight:700;
    }

    /* ===== SECTIONS ===== */
    .section{
      padding:46px 0;
    }
    .section--alt{
      background:
              radial-gradient(900px 450px at 10% 10%, rgba(91,92,232,0.08), transparent 55%),
              radial-gradient(900px 450px at 90% 20%, rgba(33,192,122,0.06), transparent 55%),
              linear-gradient(180deg, #ffffff 0%, #fbfbff 70%, #ffffff 100%);
    }
    .section__head{
      display:flex;
      align-items:flex-start;
      justify-content:space-between;
      gap:20px;
      margin-bottom:18px;
    }
    .section__title{
      font-size:26px;
      margin:0 0 10px 0;
      letter-spacing:-0.2px;
    }
    .section__desc{
      margin:0;
      color:var(--muted);
      max-width: 720px;
      line-height:1.6;
      font-size:14px;
      font-weight:600;
    }

    /* ===== COURSE CARD (no image) ===== */
    .course-card{
      background: var(--card);
      border:1px solid var(--border);
      border-radius: var(--radius);
      box-shadow: 0 8px 20px rgba(0,0,0,0.06);
      overflow:hidden;
      min-width: 270px;
      transition: .2s ease;
    }
    .course-card:hover{
      transform: translateY(-2px);
      box-shadow: 0 16px 34px rgba(0,0,0,0.10);
    }
    .course-card__thumb{
      height:150px;
      display:flex;
      align-items:center;
      justify-content:center;
      background:
              radial-gradient(700px 180px at 20% 20%, rgba(91,92,232,0.18), transparent 60%),
              radial-gradient(700px 180px at 80% 35%, rgba(33,192,122,0.14), transparent 55%),
              linear-gradient(135deg, #f3f4f6 0%, #ffffff 100%);
      border-bottom:1px solid var(--border);
      position:relative;
    }
    .course-card__thumb::after{
      content:"COURSE";
      font-weight:900;
      letter-spacing:2px;
      color:rgba(17,24,39,0.28);
      font-size:18px;
    }
    .course-card__body{
      padding:14px 14px 12px 14px;
    }
    .course-card__title{
      margin:0;
      font-size:15px;
      font-weight:900;
      line-height:1.35;
      min-height: 42px;
    }
    .course-card__author{
      margin-top:6px;
      font-size:13px;
      color:var(--muted);
      font-weight:700;
    }
    .course-card__rating{
      margin-top:8px;
      color:#9ca3af;
      letter-spacing:1px;
      font-size:14px;
    }
    .course-card__meta{
      margin-top:12px;
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:10px;
      font-weight:800;
      font-size:13px;
    }
    .course-card__students{ color:#374151; }
    .course-card__price{ color:#111827; }

    /* ===== CAROUSEL ===== */
    .carousel{
      position:relative;
    }
    .carousel__track{
      display:flex;
      gap:18px;
      overflow:auto;
      scroll-behavior:smooth;
      padding: 6px 2px 12px 2px;
    }
    .carousel__track::-webkit-scrollbar{ height:10px; }
    .carousel__track::-webkit-scrollbar-thumb{
      background: rgba(91,92,232,0.22);
      border-radius:999px;
    }
    .carousel__btn{
      position:absolute;
      top:50%;
      transform: translateY(-60%);
      width:40px;
      height:40px;
      border-radius:999px;
      border:1px solid var(--border);
      background:#ffffff;
      box-shadow: 0 12px 26px rgba(0,0,0,0.10);
      cursor:pointer;
      display:grid;
      place-items:center;
      font-size:22px;
      color:#111827;
      opacity: 0.95;
    }
    .carousel__btn:hover{ filter:brightness(0.98); }
    .carousel__btn.left{ left:-14px; }
    .carousel__btn.right{ right:-14px; }

    /* ===== GRID (newest) ===== */
    .grid{
      display:grid;
      grid-template-columns: repeat(3, 1fr);
      gap:18px;
    }

    /* ===== RESPONSIVE ===== */
    @media (max-width: 980px){
      .header__inner{ flex-wrap:wrap; }
      .nav{ order:3; width:100%; justify-content:center; }
      .auth{ margin-left:auto; }
      .hero__inner{ grid-template-columns: 1fr; }
      .hero__title{ font-size:36px; }
      .carousel__btn{ display:none; }
      .grid{ grid-template-columns: repeat(2, 1fr); }
      .pageShell{ margin: 18px auto; }
    }
    @media (max-width: 640px){
      .container{ width: calc(100% - 24px); }
      .search{ display:none; }
      .hero{ padding:36px 0; }
      .hero__title{ font-size:30px; }
      .grid{ grid-template-columns: 1fr; }
      .categories{ gap:10px; }
      .pageShell{ width: calc(100% - 24px); }
    }
  </style>
</head>

<body>

<div class="pageShell">

  <header class="header">
    <div class="container header__inner">
      <a class="brand" href="${pageContext.request.contextPath}/">
        <div class="brand__logo">SU</div>
        <div class="brand__name">
          <div class="brand__title">SkillUp</div>
          <div class="brand__sub">Learning Platform</div>
        </div>
      </a>

      <div class="search">
        <span class="search__icon">🔍</span>
        <input class="search__input" type="text" placeholder="Tìm kiếm khóa học..." />
      </div>

      <nav class="nav">
        <a href="#" class="nav__link active">Trang chủ</a>
        <a href="#" class="nav__link">Diễn đàn</a>
        <a href="#" class="nav__link">Tin tức</a>
        <a href="#" class="nav__icon" title="Giỏ hàng">🛒</a>
      </nav>

      <div class="auth">
        <a class="btn btn--ghost" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        <a class="btn btn--primary" href="${pageContext.request.contextPath}/register">Đăng ký</a>
      </div>
    </div>

    <div class="container categories">
      <a class="categories__item" href="#">Lập trình</a>
      <a class="categories__item" href="#">Kinh tế</a>
      <a class="categories__item" href="#">Luật</a>
    </div>
  </header>

  <section class="hero">
    <div class="container hero__inner">
      <div class="hero__left">
        <div class="badge">✨ Lộ trình học tập rõ ràng, dễ theo dõi</div>

        <h1 class="hero__title">
          Quản lý việc học của bạn<br/>
          hiệu quả hơn
        </h1>

        <p class="hero__desc">
          SkillUp giúp bạn nâng cao kỹ năng AI, sự nghiệp và cuộc sống với những
          khóa học được cập nhật và hướng dẫn bởi chuyên gia.
        </p>

        <div class="hero__actions">
          <a href="#" class="btn btn--primary btn--lg">Bắt đầu học ngay</a>
        </div>

        <div class="stats">
          <div class="stat">
            <div class="stat__label">HỌC VIÊN ĐANG HOẠT ĐỘNG</div>
            <div class="stat__value">12k+</div>
          </div>
          <div class="stat">
            <div class="stat__label">TỶ LỆ HOÀN THÀNH</div>
            <div class="stat__value">89%</div>
          </div>
          <div class="stat">
            <div class="stat__label">KHÓA HỌC ĐƯỢC QUẢN LÝ</div>
            <div class="stat__value">3.5k</div>
          </div>
        </div>
      </div>

      <div class="hero__right">
        <!-- Không dùng ảnh: placeholder -->
        <div class="hero__placeholder">
          <div>
            <div class="hero__placeholderText">SkillUp Dashboard</div>
            <div class="hero__placeholderSub">Placeholder (không dùng ảnh)</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="container section__head">
      <div>
        <h2 class="section__title">Tất cả công cụ bạn cần để học tập chủ động</h2>
        <p class="section__desc">
          Khám phá các khóa học được yêu thích nhất, được đánh giá cao bởi cộng đồng học viên của chúng tôi.
        </p>
      </div>
      <a class="btn btn--pill" href="#">Xem tất cả →</a>
    </div>

    <div class="container">
      <div class="carousel">
        <button class="carousel__btn left" type="button" data-target="featuredTrack">‹</button>

        <div class="carousel__track" id="featuredTrack">
          <article class="course-card">
            <div class="course-card__thumb"></div>
            <div class="course-card__body">
              <h3 class="course-card__title">Lập trình Java</h3>
              <div class="course-card__author">Vũ Đức Hiền</div>
              <div class="course-card__rating">☆☆☆☆☆</div>
              <div class="course-card__meta">
                <span class="course-card__students">👥 0</span>
                <span class="course-card__price">₫10,000</span>
              </div>
            </div>
          </article>

          <article class="course-card">
            <div class="course-card__thumb"></div>
            <div class="course-card__body">
              <h3 class="course-card__title">Khóa học SQL Server cho người mới</h3>
              <div class="course-card__author">Vũ Đức Hiền</div>
              <div class="course-card__rating">☆☆☆☆☆</div>
              <div class="course-card__meta">
                <span class="course-card__students">👥 0</span>
                <span class="course-card__price">₫10,000</span>
              </div>
            </div>
          </article>

          <article class="course-card">
            <div class="course-card__thumb"></div>
            <div class="course-card__body">
              <h3 class="course-card__title">Khóa học lập trình Python cơ bản</h3>
              <div class="course-card__author">Vũ Đức Hiền</div>
              <div class="course-card__rating">☆☆☆☆☆</div>
              <div class="course-card__meta">
                <span class="course-card__students">👥 0</span>
                <span class="course-card__price">₫10,000</span>
              </div>
            </div>
          </article>

          <article class="course-card">
            <div class="course-card__thumb"></div>
            <div class="course-card__body">
              <h3 class="course-card__title">Khóa học Python Howkteam</h3>
              <div class="course-card__author">quatbt</div>
              <div class="course-card__rating">☆☆☆☆☆</div>
              <div class="course-card__meta">
                <span class="course-card__students">👥 0</span>
                <span class="course-card__price">₫10,000</span>
              </div>
            </div>
          </article>
        </div>

        <button class="carousel__btn right" type="button" data-target="featuredTrack">›</button>
      </div>
    </div>
  </section>

  <section class="section section--alt">
    <div class="container section__head">
      <div>
        <h2 class="section__title">Khóa học mới nhất</h2>
        <p class="section__desc">
          Cập nhật những khóa học mới nhất được thiết kế để giúp bạn theo kịp xu hướng công nghệ và kỹ năng hiện đại.
        </p>
      </div>
      <a class="btn btn--pill" href="#">Xem tất cả →</a>
    </div>

    <div class="container grid">
      <article class="course-card">
        <div class="course-card__thumb"></div>
        <div class="course-card__body">
          <h3 class="course-card__title">Khóa học mới #1</h3>
          <div class="course-card__author">Giảng viên</div>
          <div class="course-card__rating">☆☆☆☆☆</div>
          <div class="course-card__meta">
            <span class="course-card__students">👥 0</span>
            <span class="course-card__price">₫0</span>
          </div>
        </div>
      </article>

      <article class="course-card">
        <div class="course-card__thumb"></div>
        <div class="course-card__body">
          <h3 class="course-card__title">Khóa học mới #2</h3>
          <div class="course-card__author">Giảng viên</div>
          <div class="course-card__rating">☆☆☆☆☆</div>
          <div class="course-card__meta">
            <span class="course-card__students">👥 0</span>
            <span class="course-card__price">₫0</span>
          </div>
        </div>
      </article>

      <article class="course-card">
        <div class="course-card__thumb"></div>
        <div class="course-card__body">
          <h3 class="course-card__title">Khóa học mới #3</h3>
          <div class="course-card__author">Giảng viên</div>
          <div class="course-card__rating">☆☆☆☆☆</div>
          <div class="course-card__meta">
            <span class="course-card__students">👥 0</span>
            <span class="course-card__price">₫0</span>
          </div>
        </div>
      </article>
    </div>
  </section>

  <script>
    // Carousel scroll (bấm mũi tên)
    (function(){
      const btns = document.querySelectorAll(".carousel__btn");
      btns.forEach(btn => {
        btn.addEventListener("click", () => {
          const id = btn.getAttribute("data-target");
          const track = document.getElementById(id);
          if(!track) return;

          const card = track.querySelector(".course-card");
          const step = (card ? card.getBoundingClientRect().width : 280) + 18;

          const isLeft = btn.classList.contains("left");
          track.scrollBy({ left: isLeft ? -step : step, behavior: "smooth" });
        });
      });
    })();
  </script>

</div> <!-- /pageShell -->

</body>
</html>
