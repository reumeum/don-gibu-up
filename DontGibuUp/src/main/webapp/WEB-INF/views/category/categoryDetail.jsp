<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/category/category.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<img
	src="${pageContext.request.contextPath}/upload/${category.dcate_banner}"
	id="banner" width="100%;">
<div class="page-main nanum">
	<h2 style="margin-top: 80px;">${category.dcate_name}</h2>
	<ul class="detail-info">
		<li>${category.dcate_charity}<br>
		</li>
	</ul>
	<div class="main-content align-center">${category.dcate_content}
		<div class="box-guide">
			<div class="header">
				<div class="align-left" style="margin-left:45px;">
					<strong>${category.dcate_charity}</strong>
					<p>세상을 바꾸는 정기기부, 같이 시작해요!</p>
				</div>
				<div class="align-right" style="margin-right:35px;">
					<img
						src="${pageContext.request.contextPath}/upload/${category.dcate_icon}"
						width="50px">
				</div>
			</div>
			<div class="wrap_list">
				<dl>
					<dt>${category.dcate_name}</dt>
					<dd>월 3,000원 지원</dd>
				</dl>
				<dl>
					<dt>${category.dcate_name}</dt>
					<dd>월 5,000원 지원</dd>
				</dl>
				<dl>
					<dt>${category.dcate_name}</dt>
					<dd>월 10,000원 지원</dd>
				</dl>
				<dl>
					<dt>${category.dcate_name}</dt>
					<dd>월 20,000원 지원</dd>
				</dl>
				<dl>
					<dt>${category.dcate_name}</dt>
					<dd>월 30,000원 지원</dd>
				</dl>
				<dl>
					<dt>${category.dcate_name}</dt>
					<dd>월 50,000원 지원</dd>
				</dl>
			</div>
	</div>
		<div class="container">
			<section class="accordion-section">
					<div class="accordion-item">
						<div class="accordion-header">
							결제안내
							<div class="align-right">▼</div>
						</div>
						<div class="accordion-body align-left">
							<ul>
								<li>매월 등록된 결제수단으로 정기결제가 됩니다.</li>
								<li>결제한 내역은 myPage > 정기기부 > 정기기부 상세에서 확인할 수 있습니다.</li>
								<li>결제방법 변경 및 해지는 myPage > 정기기부에서 확인할 수 있습니다.</li>
								<li>해지 완료후 취소 불가하며, 다시 가입해야 합니다.</li>
							</ul>
						</div>
					</div>
			</section>
			<section class="accordion-section">
					<div class="accordion-item">
						<div class="accordion-header">
							상품안내
							<div class="align-right">▼</div>
						</div>
						<div class="accordion-body align-left">
							<ul>
								<li>돈기부업 채널을 통해 정기기부 소식을 알려드립니다.</li>
								<li>해당 기부처 또는 서비스 상황에 따라, 해당 상품이 중단 될 수 있습니다.</li>					
							</ul>
						</div>
					</div>
					</section>
				</div>
		</div>
</div>
<div class="align-right">
	<c:if test="${!empty user && user.mem_status==9}">
		<input type="button" value="수정"
			onclick="location.href='/category/updateCategory?dcate_num=${category.dcate_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<input type="button" value="목록" onclick="location.href='/admin/categoryList'">
	</c:if>
	
	<script>
					const delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick = function() {
						const choice = confirm('삭제하시겠습니까?');
						if (choice) {
							location
									.replace('/category/deleteCategory?dcate_num=${category.dcate_num}');
						}
					};
				</script>
	<div class="pay-button">
		<button id="paybutton" class="btn btn-info nanum" data-bs-toggle="modal"
			data-bs-target="#staticBackdrop">정기기부 신청</button>
	</div>
	
</div>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/subscription/reg_pay.js"></script>
<div class="container">
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static">
		<div class="modal-dialog modal-lg-custom">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<img
							src="${pageContext.request.contextPath}/upload/${category.dcate_icon}"
							width="30"> <span>${category.dcate_name}</span>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<form:form id="registerSubscription"
						modelAttribute="subscriptionVO" action="registerSubscription"
						method="post" style="width: 465px;">
						<input type="hidden" name="dcate_num"
							value="${category.dcate_num}">
						<input type="hidden" name="mem_num" value="${user.mem_num}"
							id="mem_num">
						<input type="hidden" name="card_nickname" id="card_nickname">
						<input type="hidden" name="sub_date" id="sub_date" />
						<!-- 익명 여부 체크박스 -->
						<div class="form-group">
							<label>익명 여부</label>
							<div class="form-check">
								<form:checkbox class="form-check-input" id="anonymousCheck"
									path="sub_annoy" />
								<label class="form-check-label" for="anonymousCheck">익명으로
									기부</label>
							</div>
						</div>
						<!-- 기부자 이름 입력 필드 -->
						<div class="form-group">
							<label for="sub_name">기부자명</label>
							<form:input type="text" class="form-control" id="sub_name"
								path="sub_name" value="${user.mem_nick}" />
						</div>

						<!-- 기부 금액 라디오 버튼 -->
						<div class="form-group">
							<label>기부 금액</label>
							<div class="form-check">
								<form:radiobutton class="form-check-input" id="radio1"
									path="sub_price" value="3000" />
								<label class="form-check-label" for="radio1">
									${category.dcate_charity} 3,000원/월 지원 </label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" id="radio2"
									path="sub_price" value="5000" />
								<label class="form-check-label" for="radio2">
									${category.dcate_charity} 5,000원/월 지원 </label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" id="radio3"
									path="sub_price" value="10000" />
								<label class="form-check-label" for="radio3">
									${category.dcate_charity} 10,000원/월 지원 </label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" id="radio4"
									path="sub_price" value="20000" />
								<label class="form-check-label" for="radio4">
									${category.dcate_charity} 20,000원/월 지원 </label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" id="radio4"
									path="sub_price" value="30000" />
								<label class="form-check-label" for="radio4">
									${category.dcate_charity} 30,000원/월 지원 </label>
							</div>
							<div class="form-check">
								<form:radiobutton class="form-check-input" id="radio5"
									path="sub_price" value="50000" />
								<label class="form-check-label" for="radio5">
									${category.dcate_charity} 50,000원/월 지원 </label>
							</div>
							<form:errors path="sub_price" cssClass="text-danger" />
						</div>

						<!-- 결제 수단 라디오 버튼 -->
						<div class="form-group">
							<label>결제 수단</label><br>
							<div class="payment-methods">
								<label class="payment-method" for="card"> <form:radiobutton
										path="sub_method" id="card" value="card" />카드
								</label> <label class="payment-method" for="easy_pay"> <form:radiobutton
										path="sub_method" id="easy_pay" value="easy_pay" />간편결제
								</label>
							</div>
						</div>

						<!-- 이미 등록된 카드 목록, 새 카드 등록 -->
						<div id="card-options" style="display: none;">
							<label>내가 보유한 카드</label>
							<c:forEach var="card" items="${list}">
								<c:if test="${!empty card.card_nickname}">
									<div>
										<input type="radio" class="oldCard" name="selectedCard"
											value="${card.card_nickname}"> <label
											for="card_${card.card_nickname}">
											${card.card_nickname}</label>
									</div>
								</c:if>
							</c:forEach>
							<div>
								<input type="radio" id="newCard" name="selectedCard"
									value="newCard"> <label for="newCard">새 카드 등록</label>
							</div>
							<!-- 새 카드 별명 입력 필드 -->
							<div id="newCardNickname" style="display: none;">
								<input type="text" class="form-control" id="newCardname"
									class="newCard" placeholder="새 카드 별명" maxlength="10">
							</div>
						</div>

						<!-- 간편 결제 수단 라디오 버튼 -->
						<div class="form-group easypay-container" style="display: none;">
							<label>간편 결제</label><br>
							<div class="easypay_methods">
								<label class="easypay_method" for="kakao"> <form:radiobutton
										path="easypay_method" id="kakao" value="kakao" /><img
									src="../upload/카카오페이 로고.jpg" width="40"
									style="border-radius: 25%">
								</label> <label class="easypay_method" for="payco"> <form:radiobutton
										path="easypay_method" id="payco" value="payco" /><img
									src="../upload/페이코 로고.jpg" width="40"
									style="border-radius: 25%">
								</label>
							</div>
						</div>
						<!-- 오늘 날짜와 결제 일자 안내 -->
						<div style="margin-top: 10px;">
							매월 <span id="paymentDateInfo"
								style="color: red; font-size: 21px;"></span>일에 정기 결제가 이루어집니다.
						</div>
						<!-- 기부 시작하기 버튼 -->
						<button type="submit" class="btn btn-primary"
							style="margin-top: 10px;">기부 시작하기</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>

