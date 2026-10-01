<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng ký</title>
</head>
<body>
    <div class="form-container">
        <h2 style="text-align: center; margin-bottom: 2rem; color: var(--text-main);">Tạo tài khoản mới</h2>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label>Họ và tên</label>
                <input type="text" name="fullname" required placeholder="Nguyễn Văn A">
            </div>
            <div class="form-group">
                <label>Email liên hệ</label>
                <input type="email" name="email" required placeholder="email@example.com">
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="number" name="phone" placeholder="0987654321">
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="passwd" required placeholder="••••••••">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.75rem; margin-top: 1rem;">Đăng ký</button>
        </form>

        <p style="text-align: center; margin-top: 1.5rem; font-size: 0.875rem; color: var(--text-muted);">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color: var(--primary-color); font-weight: 500;">Đăng nhập</a>
        </p>
    </div>
</body>
</html>
