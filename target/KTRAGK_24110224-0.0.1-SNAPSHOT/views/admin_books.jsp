<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quản lý Sách</title>
</head>
<body>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
        <h1 style="font-size: 1.5rem; color: var(--text-main);">Quản lý Danh mục Sách</h1>
        <a href="${pageContext.request.contextPath}/admin/books/form" class="btn btn-primary">+ Thêm Sách Mới</a>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tiêu đề sách</th>
                    <th>Mã ISBN</th>
                    <th>Nhà xuất bản</th>
                    <th>Giá bán ($)</th>
                    <th style="text-align: right;">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td style="color: var(--text-muted); font-weight: 500;">#${book.bookId}</td>
                        <td style="font-weight: 500; color: var(--text-main);">
                            <div style="display: flex; align-items: center; gap: 1rem;">
                                <img src="${pageContext.request.contextPath}/${book.coverImage}" alt="cover" style="width: 40px; height: 40px; object-fit: cover; border-radius: 4px;">
                                ${book.title}
                            </div>
                        </td>
                        <td>${book.isbn}</td>
                        <td>${book.publisher}</td>
                        <td style="font-weight: 600;">${book.price}</td>
                        <td style="text-align: right;" class="action-links">
                            <a href="${pageContext.request.contextPath}/admin/books/form?id=${book.bookId}">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/books?action=delete&id=${book.bookId}" class="delete" onclick="return confirm('Hành động này không thể hoàn tác. Bạn có chắc muốn xóa cuốn sách này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="pagination" style="margin-top: 2rem;">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
    </div>
</body>
</html>
