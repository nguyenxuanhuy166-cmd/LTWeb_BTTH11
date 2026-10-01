<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${empty book ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}</title>
</head>
<body>
    <div style="max-width: 800px; margin: 0 auto; background: var(--bg-white); padding: 2.5rem; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem;">
            <h2 style="color: var(--text-main); font-size: 1.5rem;">${empty book ? 'Thêm Sách Mới' : 'Cập Nhật Sách'}</h2>
            <a href="${pageContext.request.contextPath}/admin/books" style="color: var(--text-muted); text-decoration: none; font-size: 0.875rem;">← Quay lại</a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/books/form" method="post">
            <input type="hidden" name="bookid" value="${book.bookId}">
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                <div class="form-group">
                    <label>Tiêu đề sách</label>
                    <input type="text" name="title" value="${book.title}" required placeholder="Nhập tên sách...">
                </div>
                
                <div class="form-group">
                    <label>Mã ISBN</label>
                    <input type="number" name="isbn" value="${book.isbn}" required placeholder="Nhập mã ISBN">
                </div>
                
                <div class="form-group">
                    <label>Nhà xuất bản</label>
                    <input type="text" name="publisher" value="${book.publisher}" placeholder="Tên nhà xuất bản">
                </div>
                
                <div class="form-group">
                    <label>Ngày xuất bản (YYYY-MM-DD)</label>
                    <input type="date" name="publish_date" value="${book.publishDate}">
                </div>

                <div class="form-group">
                    <label>Giá bán ($)</label>
                    <input type="number" step="0.01" name="price" value="${book.price}" placeholder="Ví dụ: 25.50">
                </div>
                
                <div class="form-group">
                    <label>Số lượng tồn kho</label>
                    <input type="number" name="quantity" value="${book.quantity}" placeholder="Số lượng...">
                </div>
            </div>

            <div class="form-group" style="margin-top: 1rem;">
                <label>Đường dẫn Ảnh bìa (URL / Thư mục)</label>
                <input type="text" name="cover_image" value="${book.coverImage}" placeholder="Ví dụ: images/Tên sách.jpg">
            </div>

            <div class="form-group" style="margin-top: 1rem;">
                <label>Mô tả nội dung</label>
                <textarea name="description" rows="5" placeholder="Tóm tắt nội dung sách...">${book.description}</textarea>
            </div>
            
            <div style="display: flex; gap: 1rem; margin-top: 2rem; justify-content: flex-end; padding-top: 1.5rem; border-top: 1px solid var(--border-color);">
                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-outline">Hủy bỏ</a>
                <button type="submit" class="btn btn-primary" style="padding: 0.5rem 2rem;">${empty book ? 'Lưu Sách Mới' : 'Cập Nhật'}</button>
            </div>
        </form>
    </div>
</body>
</html>
