<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${book.title}</title>
</head>
<body>
    <div style="margin-bottom: 1.5rem;">
        <a href="${pageContext.request.contextPath}/products" style="color: var(--text-muted); text-decoration: none;">← Quay lại danh sách</a>
    </div>

    <div class="book-detail-wrapper">
        <div class="book-detail-grid">
            <div class="book-cover">
                <img src="${pageContext.request.contextPath}/${book.coverImage}" alt="${book.title}" style="width: 100%; height: auto; object-fit: contain;" />
            </div>
            <div>
                <h1 style="font-size: 2rem; margin-bottom: 0.5rem; color: var(--text-main);">${book.title}</h1>
                <p style="font-size: 1.125rem; color: var(--text-muted); margin-bottom: 1.5rem;">Tác giả: <strong>${book.authorNames}</strong></p>
                
                <div style="background: var(--bg-light); padding: 1.5rem; border-radius: var(--radius-md); margin-bottom: 2rem;">
                    <p style="font-size: 1.5rem; font-weight: 700; color: var(--primary-color); margin-bottom: 1rem;">$${book.price}</p>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; font-size: 0.875rem;">
                        <p><strong>Mã ISBN:</strong> ${book.isbn}</p>
                        <p><strong>Nhà xuất bản:</strong> ${book.publisher}</p>
                        <p><strong>Ngày xuất bản:</strong> ${book.publishDate}</p>
                        <p><strong>Tồn kho:</strong> ${book.quantity} quyển</p>
                    </div>
                    <c:if test="${book.quantity > 0}">
                        <form action="${pageContext.request.contextPath}/cart" method="post" style="margin-top: 1rem;">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="bookId" value="${book.bookId}">
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <input type="number" name="quantity" value="1" min="1" max="${book.quantity}" style="width: 60px; padding: 8px;">
                                <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${book.quantity <= 0}">
                        <p style="color: red; font-weight: bold; margin-top: 1rem;">Hết hàng</p>
                    </c:if>
                </div>

                <div>
                    <h3 style="margin-bottom: 0.5rem;">Mô tả nội dung</h3>
                    <p style="color: var(--text-muted); line-height: 1.6;">
                        ${not empty book.description ? book.description : 'Chưa có mô tả cho cuốn sách này.'}
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="reviews-section">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 2px solid var(--border-color); padding-bottom: 1rem;">
            <h2 style="font-size: 1.5rem;">Đánh giá & Nhận xét (${book.reviewCount})</h2>
        </div>
        
        <div style="margin-bottom: 3rem;">
            <c:if test="${empty ratings}">
                <p style="color: var(--text-muted); text-align: center; padding: 2rem 0;">Chưa có đánh giá nào. Hãy là người đầu tiên nhận xét!</p>
            </c:if>
            <c:forEach var="r" items="${ratings}">
                <div class="review-item">
                    <div class="review-author">👤 ${r.userFullname}</div>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">${r.reviewText}</p>
                </div>
            </c:forEach>
        </div>
        
        <div style="background: var(--bg-light); padding: 1.5rem; border-radius: var(--radius-md);">
            <h3 style="margin-bottom: 1rem;">Viết đánh giá của bạn</h3>
            <c:if test="${empty sessionScope.user}">
                <p style="color: var(--text-muted); margin-bottom: 1rem;">Vui lòng <a href="${pageContext.request.contextPath}/login" style="color: var(--primary-color);">đăng nhập</a> để gửi đánh giá.</p>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <form action="${pageContext.request.contextPath}/review" method="post">
                    <input type="hidden" name="bookid" value="${book.bookId}">
                    <div class="form-group">
                        <textarea name="review_text" rows="4" required placeholder="Chia sẻ cảm nghĩ của bạn về cuốn sách này..." style="resize: vertical;"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Gửi Đánh Giá</button>
                </form>
            </c:if>
        </div>
    </div>
</body>
</html>
