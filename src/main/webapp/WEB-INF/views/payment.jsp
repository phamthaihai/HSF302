<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Payment | StudyHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #f5f7fb;
            --card: #ffffff;
            --primary: #2563eb;
            --primary-dark: #1e40af;
            --text: #0f172a;
            --muted: #6b7280;
            --radius: 18px;
            --shadow: 0 12px 32px rgba(0,0,0,0.12);
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, rgba(37,99,235,0.12), rgba(124,58,237,0.12)), var(--bg);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            color: var(--text);
        }
        .wrapper {
            width: 100%;
            max-width: 420px;
        }
        .back {
            display: inline-block;
            margin-bottom: 16px;
            text-decoration: none;
            font-weight: 600;
            color: var(--primary);
        }
        .card {
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 28px;
        }
        .header {
            text-align: center;
            margin-bottom: 24px;
        }
        .header .icon {
            font-size: 36px;
        }
        .header h2 {
            margin: 8px 0 4px;
            font-size: 22px;
            font-weight: 700;
        }
        .header p {
            margin: 0;
            font-size: 14px;
            color: var(--muted);
        }
        .amount {
            background: linear-gradient(135deg, #7c3aed, #2563eb);
            color: #fff;
            border-radius: 14px;
            padding: 14px 16px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .amount span {
            font-size: 14px;
            opacity: .9;
        }
        .amount strong {
            font-size: 18px;
        }
        label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin: 14px 0 6px;
        }
        input {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            font-size: 14px;
        }
        input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(37,99,235,0.15);
        }
        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        button {
            margin-top: 22px;
            width: 100%;
            padding: 14px;
            border-radius: 14px;
            border: none;
            background: var(--primary);
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background .2s ease, transform .1s ease;
        }
        button:hover {
            background: var(--primary-dark);
        }
        button:active {
            transform: translateY(1px);
        }
        .secure {
            margin-top: 16px;
            font-size: 13px;
            color: var(--muted);
            text-align: center;
        }
    </style>
</head>
<body>

<div class="wrapper">
    <a class="back" href="javascript:history.back()">⬅ Back</a>

    <div class="card">
        <div class="header">
            <div class="icon">💳</div>
            <h2>Payment</h2>
            <p>Secure payment via StudyHub</p>
        </div>

        <div class="amount">
            <span>Total amount</span>
            <strong>${amount} VND</strong>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/payment/pay">
            <input type="hidden" name="userId" value="1">
            <input type="hidden" name="courseId" value="${courseId}">
            <input type="hidden" name="amount" value="${amount}">

            <label>Card Holder Name</label>
            <input type="text" name="cardName" placeholder="John Doe" required>

            <label>Card Number</label>
            <input type="text" name="cardNumber" placeholder="1234 5678 9012 3456" required>

            <div class="row">
                <div>
                    <label>Expiry</label>
                    <input type="text" placeholder="MM/YY" required>
                </div>
                <div>
                    <label>CVV</label>
                    <input type="password" placeholder="***" required>
                </div>
            </div>

            <button type="submit">Confirm Payment</button>
        </form>

        <div class="secure">🔒 Your payment information is encrypted and secure</div>
    </div>
</div>

</body>
</html>