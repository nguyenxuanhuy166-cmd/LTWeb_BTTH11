<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<head>
    <title>Giỏ hàng của bạn</title>
    <style>
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .cart-table th, .cart-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .cart-table th {
            background-color: #f2f2f2;
        }
        .cart-img {
            width: 60px;
            height: auto;
        }
        .cart-actions {
            display: flex;
            gap: 10px;
        }
        .total-row {
            font-size: 1.2em;
            font-weight: bold;
            text-align: right;
            padding-top: 20px;
        }
        .qty-input {
            width: 60px;
            padding: 5px;
        }
        .checkout-box {
            margin-top: 30px;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <h2>Giỏ Hàng</h2>

        <c:choose>
            <c:when test="${empty sessionScope.cart.items}">
                <p>Giỏ hàng của bạn đang trống. <a href="${pageContext.request.contextPath}/products">Tiếp tục mua sắm</a></p>
            </c:when>
            <c:otherwise>
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sách</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Tổng</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.cart.items}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/${item.book.coverImage}" alt="${item.book.title}" class="cart-img">
                                </td>
                                <td>${item.book.title}</td>
                                <td>$<fmt:formatNumber value="${item.book.price}" pattern="#,##0.00"/></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="bookId" value="${item.book.bookId}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.book.quantity}" class="qty-input">
                                        <button type="submit" class="btn btn-outline" style="padding: 5px 10px; font-size: 0.9em;">Cập nhật</button>
                                    </form>
                                    <br><small style="color:#666;">(Có sẵn: ${item.book.quantity})</small>
                                </td>
                                <td>$<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&bookId=${item.book.bookId}" class="btn" style="background-color: #dc3545; color: white; padding: 5px 10px;" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="total-row">
                    Tổng cộng: <span style="color:var(--primary-color);">$<fmt:formatNumber value="${sessionScope.cart.totalMoney}" pattern="#,##0.00"/></span>
                </div>

                <div class="checkout-box">
                    <h3>Thanh toán (COD - Giao hàng nhận tiền)</h3>
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <p><strong>Người nhận:</strong> ${sessionScope.user.fullname}</p>
                                <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                                <div style="margin-bottom: 15px;">
                                    <label>Địa chỉ giao hàng:</label><br>
                                    <textarea name="address" required style="width: 100%; height: 80px; padding: 10px; margin-top: 5px;"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px; font-size: 1.1em;">Xác nhận đặt hàng</button>
                            </c:when>
                            <c:otherwise>
                                <p style="color:red;">Vui lòng <a href="${pageContext.request.contextPath}/login">đăng nhập</a> để tiến hành thanh toán.</p>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
