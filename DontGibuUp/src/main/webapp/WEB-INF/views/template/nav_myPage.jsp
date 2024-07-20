<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

<!-- MyPage 메뉴 시작 -->
	<div class="category-block d-flex flex-column">
		<h5 class="mb-3">나의 정보</h5>
		<a href="${pageContext.request.contextPath}/member/myPage/memberInfo" class="category-block-link"> 회원정보 수정</a>
		<a href="${pageContext.request.contextPath}/member/myPage/changePassword" class="category-block-link"> 비밀번호 수정</a>
		<a href="${pageContext.request.contextPath}/member/myPage/inviteFriendEvent" class="category-block-link"> 친구초대</a>
		<a href="${pageContext.request.contextPath}/member/myPage/point" class="category-block-link"> 포인트</a>
	</div>
	<div class="category-block d-flex flex-column">
		<h5 class="mb-3">기부</h5>
		<a href="#" class="category-block-link"> 정기기부</a>
		<a href="#" class="category-block-link"> 기부박스</a>
	</div>
	<div class="category-block d-flex flex-column">
		<h5 class="mb-3">챌린지</h5>
		<a href="${pageContext.request.contextPath}/challenge/join/list?status=pre" class="category-block-link"> 시작 전 챌린지</a>
		<a href="${pageContext.request.contextPath}/challenge/join/list?status=on" class="category-block-link"> 참가중인 챌린지</a>
		<a href="${pageContext.request.contextPath}/challenge/join/list?status=post" class="category-block-link"> 완료된 챌린지</a>
	</div>
	<div class="category-block d-flex flex-column">
		<h5 class="mb-3">주문</h5>
		<a href="#" class="category-block-link"> 주문/배송조회</a>
		<a href="${pageContext.request.contextPath}/cart/list" class="category-block-link"> 장바구니</a>
	</div>
	<div class="category-block d-flex flex-column">
		<h5 class="mb-3">고객센터</h5>
		<a href="${pageContext.request.contextPath}/member/myPage/inquiry" class="category-block-link"> 문의/신고</a>
	</div>
<!-- MyPage 메뉴 끝 -->
