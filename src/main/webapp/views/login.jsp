<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
    <div class="form-container">
        <h2 style="text-align: center; margin-bottom: 2rem; color: var(--text-main);">Đăng nhập</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty param.msg}">
            <div class="alert alert-success">${param.msg}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Email của bạn</label>
                <input type="email" name="email" required placeholder="ví dụ: xuanhuy@gmail.com">
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="passwd" required placeholder="••••••••">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.75rem; margin-top: 1rem;">Đăng nhập ngay</button>
        </form>
        
        <p style="text-align: center; margin-top: 1.5rem; font-size: 0.875rem; color: var(--text-muted);">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: var(--primary-color); font-weight: 500;">Đăng ký tại đây</a>
        </p>
    </div>
</body>
</html>
