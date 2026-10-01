<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><decorator:title default="Admin Panel - MAGIC BOOK STORE"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <decorator:head/>
</head>
<body>
    <header style="background: #1f2937; color: white;">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/home" class="logo" style="color: white;">MAGIC BOOK STORE <span style="font-size:1rem; font-weight:400; color:#9ca3af">| Admin</span></a>
            <nav>
                <a href="${pageContext.request.contextPath}/home" style="color: #d1d5db;">Trang Chủ</a>
                <a href="${pageContext.request.contextPath}/products" style="color: #d1d5db;">Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/admin/books" style="color: white; font-weight: 600;">Quản lý Sách</a>
                
                <c:if test="${not empty sessionScope.user}">
                    <span class="user-greeting" style="background: rgba(255,255,255,0.1); color: white;">👋 ${sessionScope.user.fullname}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn" style="border: 1px solid rgba(255,255,255,0.2); color:white;">Đăng xuất</a>
                </c:if>
            </nav>
        </div>
    </header>

    <main class="container">
        <decorator:body/>
    </main>

    <footer>
        <p>Họ và tên: Nguyễn Xuân Huy, Mssv: 24110224, Đề 2</p>
    </footer>
</body>
</html>
