<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<h2>구매내역</h2>
<c:if test="${not empty purchaseList}">
    <table border="1">
        <thead>
            <tr>
                <th>상품명</th>
                <th>사진</th>
                <th>총액</th>
                <th>구매일</th>
                <th>상태</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="purchase" items="${purchaseList}">
                <tr>
                    <td>${purchase.item_name}</td>
                    <td><img src="${pageContext.request.contextPath}${purchase.item_photo}" alt="${purchase.item_name}" width="100" height="100"></td>
                    <td>${purchase.amount}</td>
                    <td>${purchase.payDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${purchase.payStatus == 0}">
                                결제완료
                            </c:when>
                            <c:when test="${purchase.payStatus == 2}">
                                환불완료
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${purchase.payStatus == 0}">
                            <button onclick="requestRefund('${purchase.imp_uid}')">Refund</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<c:if test="${empty purchaseList}">
    <p>구매 내역 없음</p>
</c:if>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/goods/refund.js"></script>
