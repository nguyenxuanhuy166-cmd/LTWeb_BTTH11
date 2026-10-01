<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><decorator:title default="MAGIC BOOK STORE"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <decorator:head/>
</head>
<body>
    <header>
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/home" class="logo">MAGIC BOOK STORE</a>
            <nav>
                <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/cart">Giỏ hàng 
                    <c:if test="${not empty sessionScope.cart and sessionScope.cart.totalQuantity > 0}">
                        (${sessionScope.cart.totalQuantity})
                    </c:if>
                </a>
                <c:if test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Đăng ký</a>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <span class="user-greeting">👋 Xin chào, ${sessionScope.user.fullname}</span>
                    <c:if test="${sessionScope.user.admin}">
                        <a href="${pageContext.request.contextPath}/admin/books" style="color:var(--primary-color); font-weight:600;">⚙️ Quản lý Sách</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Đăng xuất</a>
                </c:if>
            </nav>
        </div>
    </header>

    <main class="container">
        <c:if test="${not empty sessionScope.msg}">
            <div style="background-color: #d4edda; color: #155724; padding: 15px; margin-bottom: 20px; border-radius: 4px;">
                ${sessionScope.msg}
            </div>
            <c:remove var="msg" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.err}">
            <div style="background-color: #f8d7da; color: #721c24; padding: 15px; margin-bottom: 20px; border-radius: 4px;">
                ${sessionScope.err}
            </div>
            <c:remove var="err" scope="session"/>
        </c:if>
        <decorator:body/>
    </main>

    <footer>
        <p>Họ và tên: Nguyễn Xuân Huy, Mssv: 24110224, Đề 2</p>
    </footer>
</body>
</html>
