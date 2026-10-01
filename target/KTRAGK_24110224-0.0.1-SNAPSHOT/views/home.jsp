<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trang Chủ</title>
    <style>
        .welcome-section {
            position: relative;
            overflow: hidden;
            background-image: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/images/MAGICAL BOOK STORE.jpg');
            background-size: cover;
            background-position: center;
            height: calc(100vh - 160px);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            color: white;
            text-align: center;
            border-radius: var(--radius-lg);
            margin-top: -1rem;
            margin-left: -2rem;
            margin-right: -2rem;
            box-shadow: inset 0 0 50px rgba(0,0,0,0.5);
            perspective: 1000px;
        }
        
        /* Chữ nổi bật */
        .welcome-content {
            z-index: 50;
        }
        .welcome-section h1 {
            font-size: 3.5em;
            font-weight: 700;
            letter-spacing: 2px;
            text-shadow: 0 4px 15px rgba(255, 215, 0, 0.5);
            margin-bottom: 1rem;
        }
        .welcome-section p {
            font-size: 1.25rem;
            max-width: 600px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.8);
            margin: 0 auto;
        }
        .welcome-btn {
            margin-top: 2rem;
            padding: 1rem 2rem;
            font-size: 1.125rem;
            font-weight: 600;
            border-radius: 9999px;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            transition: transform 0.2s, background-color 0.2s;
            box-shadow: 0 4px 14px rgba(79, 70, 229, 0.4);
            display: inline-block;
        }
        .welcome-btn:hover {
            transform: translateY(-2px);
            background-color: var(--primary-hover);
        }

        /* Hiệu ứng Sách Ma Thuật Bay Lơ Lửng */
        .floating-book {
            position: absolute;
            width: 90px;
            height: 130px;
            box-shadow: 0 10px 20px rgba(255, 215, 0, 0.4), 0 0 20px rgba(255, 255, 255, 0.2);
            border-radius: 4px;
            animation: levitate 5s ease-in-out infinite;
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.4s ease;
            cursor: pointer;
            z-index: 10;
            transform-style: preserve-3d;
        }
        .floating-book a {
            display: block;
            width: 100%;
            height: 100%;
        }
        .floating-book img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid rgba(255, 215, 0, 0.5);
        }
        
        /* Hiệu ứng khi Hover chuột vào cuốn sách */
        .floating-book:hover {
            transform: scale(1.6) translateY(-20px) rotateY(15deg) rotateX(10deg) !important;
            box-shadow: 0 30px 50px rgba(255, 215, 0, 0.8), 0 0 50px rgba(255, 255, 255, 0.9);
            z-index: 100;
            animation-play-state: paused;
        }

        /* Ánh sáng ma thuật phát ra khi hover */
        .floating-book::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(255,255,255,0.4) 0%, rgba(255,255,255,0) 100%);
            opacity: 0;
            transition: opacity 0.4s;
            pointer-events: none;
        }
        .floating-book:hover::after {
            opacity: 1;
        }

        @keyframes levitate {
            0%, 100% { transform: translateY(0) rotate(-3deg); }
            50% { transform: translateY(-25px) rotate(3deg); }
        }
    </style>
</head>
<body>
    <div class="welcome-section">
        
        <!-- Các cuốn sách bay lơ lửng xung quanh (Sử dụng ảnh thật trong source) -->
        <div class="floating-book" style="top: 15%; left: 10%; animation-delay: 0s;">
            <a href="${pageContext.request.contextPath}/book?id=1">
                <img src="${pageContext.request.contextPath}/images/Harry Potter 1.jpg" alt="book1">
            </a>
        </div>
        <div class="floating-book" style="top: 60%; left: 18%; animation-delay: 1.5s;">
            <a href="${pageContext.request.contextPath}/book?id=2">
                <img src="${pageContext.request.contextPath}/images/Harry Potter 2.jpg" alt="book2">
            </a>
        </div>
        <div class="floating-book" style="top: 25%; right: 15%; animation-delay: 0.7s;">
            <a href="${pageContext.request.contextPath}/book?id=3">
                <img src="${pageContext.request.contextPath}/images/Harry Potter 3.jpg" alt="book3">
            </a>
        </div>
        <div class="floating-book" style="top: 65%; right: 25%; animation-delay: 2.2s;">
            <a href="${pageContext.request.contextPath}/book?id=4">
                <img src="${pageContext.request.contextPath}/images/Harry Potter 4.jpg" alt="book4">
            </a>
        </div>
        <div class="floating-book" style="top: 10%; left: 45%; animation-delay: 1.1s;">
            <a href="${pageContext.request.contextPath}/book?id=6">
                <img src="${pageContext.request.contextPath}/images/Clash of Kings.jpg" alt="book5">
            </a>
        </div>
        <div class="floating-book" style="bottom: 10%; left: 40%; animation-delay: 2.8s;">
            <a href="${pageContext.request.contextPath}/book?id=7">
                <img src="${pageContext.request.contextPath}/images/The Hobbit.jpg" alt="book6">
            </a>
        </div>

        <div class="welcome-content">
            <h1>MAGIC BOOK STORE</h1>
            <p>Khám phá thế giới ma thuật qua từng trang sách. Nơi hội tụ những tác phẩm kinh điển và huyền bí nhất.</p>
            <a href="${pageContext.request.contextPath}/products" class="welcome-btn">Khám Phá Ngay</a>
        </div>
    </div>
</body>
</html>
