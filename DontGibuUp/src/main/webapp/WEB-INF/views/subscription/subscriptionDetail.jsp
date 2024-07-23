<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
    <meta charset="UTF-8">
    <title>Subscription Page</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/subscriptionDetail.css" type="text/css">
    <script>
        // 서버에서 전달된 템플릿 변수를 JavaScript 변수로 설정
        var subPayDate = "${sub_paydate}".trim();
        var cancelDate = "${cancel_date}".trim();
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/subscription/subscriptionDetail.js"></script>
    <div class="tabs">
        <button class="tab-button active" onclick="location.href='subscriptionList'">나의 정기기부 목록</button>
        <button class="tab-button" onclick="location.href='paymentHistory'">정기기부 결제내역</button>
    </div>
  <div style="display: flex; /* Flexbox를 사용하여 요소를 가로로 정렬합니다. */">
    <div class="item_subscribe">
        <dl class="header-item">
            <dt>
                <img src="${pageContext.request.contextPath}/upload/${category.dcate_icon}" alt="기부처 아이콘">
                ${category.dcate_name} / ${category.dcate_charity}
                <c:if test="${subscription.sub_status == 0}">
                     &nbsp; <span class="focus">정기 기부중</span> 입니다.
                </c:if>
            </dt>
            <dd>
                <c:if test="${subscription.sub_status == 0}">
                    상태 : 기부 진행중 >
                </c:if>
                <c:if test="${subscription.sub_status == 1}">
                    <span class="small"> 해지됨 (${cancel_date})</span>
                </c:if>
            </dd>
        </dl>
        <div class="cont-item">
            <dl class="info-item">
                <dt>
                    시작일 <span class="reg_date">${reg_date}</span>
                    <br><br>
                    기간 <span class="reg_date">${reg_date}</span> ~ 
                    <c:if test="${subscription.sub_status == 0}">
                        <span class="next-pay-date"></span>
                    </c:if>
                    <c:if test="${subscription.sub_status == 1}">
                        ${cancel_date}
                    </c:if>
                </dt>
                <dd>
                    이번 결제&nbsp;&nbsp;<fmt:formatNumber value="${subscription.sub_price}" type="number"/>원  (결제일 ${sub_paydate})<br><br>
                    <c:if test="${subscription.sub_status == 0}">
                        다음 결제&nbsp;&nbsp;<fmt:formatNumber value="${subscription.sub_price}" type="number"/>원 (결제일 <span class="next-pay-date"></span>)
                    </c:if>
                    <c:if test="${subscription.sub_status == 1}">
                        다음 결제 --
                    </c:if>
                </dd>
            </dl>
        </div>
    

    <c:if test="${subscription.sub_status == 0}">
        <input type="button" value="해지하기" class="modify-btn" data-num="${subscription.sub_num}">
    </c:if>
    <c:if test="${subscription.sub_status == 1}">
        <input type="button" value="해지된 정기기부" class="modify-btn" disabled="disabled">
    </c:if>
    </div>
    <div class="refundDiv">
    	<input type="button" value="환불 신청">
    </div>
</div>