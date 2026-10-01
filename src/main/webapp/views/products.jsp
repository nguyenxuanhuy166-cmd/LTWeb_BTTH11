<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Sản phẩm</title>
</head>
<body>
    <div style="margin-bottom: 2rem;">
        <h1 style="font-size: 2rem; font-weight: 700; color: var(--text-main);">Tủ Sách Ma Thuật</h1>
        <p style="color: var(--text-muted);">Những cuốn sách được yêu thích nhất hiện nay</p>
    </div>
    
    <c:set var="currentAuthor" value="" />
    
    <div class="grid">
        <c:forEach var="book" items="${books}">
            <c:if test="${book.authorNames ne currentAuthor}">
                <div style="grid-column: 1 / -1; margin-top: 1rem;">
                    <h3 class="author-title">✒️ Tác giả: ${book.authorNames}</h3>
                </div>
                <c:set var="currentAuthor" value="${book.authorNames}" />
            </c:if>
            <div class="card">
                <div class="card-img-wrapper">
                    <a href="${pageContext.request.contextPath}/book?id=${book.bookId}">
                        <img src="${pageContext.request.contextPath}/${book.coverImage}" alt="${book.title}" />
                    </a>
                </div>
                <div class="card-body">
                    <h3 class="card-title">
                        <a href="${pageContext.request.contextPath}/book?id=${book.bookId}">${book.title}</a>
                    </h3>
                    <p class="card-text" style="color: var(--primary-color); font-weight: 600; font-size: 1.125rem; margin-bottom: 0.75rem;">$${book.price}</p>
                    <p class="card-text"><strong>ISBN:</strong> ${book.isbn}</p>
                    <p class="card-text"><strong>NXB:</strong> ${book.publisher}</p>
                    <div style="margin-top: auto; padding-top: 1rem; display:flex; justify-content: space-between; align-items:center; border-top: 1px solid var(--border-color);">
                        <span style="font-size: 0.875rem; color: #f59e0b; font-weight: 600;">⭐ ${book.reviewCount} Đánh giá</span>
                        <div style="display: flex; gap: 5px;">
                            <a href="${pageContext.request.contextPath}/book?id=${book.bookId}" class="btn btn-outline" style="padding: 0.25rem 0.75rem;">Chi tiết</a>
                            <c:if test="${book.quantity > 0}">
                                <a href="${pageContext.request.contextPath}/cart?action=add&bookId=${book.bookId}" class="btn btn-primary" style="padding: 0.25rem 0.75rem;" title="Thêm vào giỏ hàng">🛒</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">← Trước</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">Sau →</a>
        </c:if>
    </div>
</body>
</html>
