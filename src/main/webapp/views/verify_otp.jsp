<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Xác thực OTP</title>
</head>
<body>
    <div class="form-container">
        <div style="text-align: center; margin-bottom: 2rem;">
            <h2 style="color: var(--text-main); margin-bottom: 0.5rem;">Xác thực Email</h2>
            <p style="color: var(--text-muted); font-size: 0.875rem;">Chúng tôi đã gửi một mã OTP gồm 6 chữ số tới email của bạn.</p>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <div class="form-group">
                <label style="text-align: center; font-size: 1rem;">Nhập mã OTP</label>
                <input type="text" name="otp" required placeholder="Ví dụ: 123456" style="text-align: center; font-size: 1.5rem; letter-spacing: 0.2em; padding: 1rem;">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.75rem; margin-top: 1rem;">Xác nhận</button>
        </form>
    </div>
</body>
</html>
