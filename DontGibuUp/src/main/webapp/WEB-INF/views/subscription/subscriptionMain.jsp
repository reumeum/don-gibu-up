<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/subscription/subscriptionMain.js"></script>
<section class="nanum">
<div class="container1">
	<!-- 캐러셀 시작 -->
	<div id="carouselExample2" class="carousel slide carousel-fade"
		data-bs-ride="carousel">
		<div class="carousel-indicators">
			<!-- 캐러셀 인디케이터 동적 생성 -->
			<c:forEach var="category" items="${list}" varStatus="loop">
				<c:if test="${!empty category.dcate_banner}">
					<button type="button" data-bs-target="#carouselExample2"
						data-bs-slide-to="${loop.index}"
						class="${loop.index == 0 ? 'active' : ''}"
						aria-current="${loop.index == 0 ? 'true' : 'false'}"
						aria-label="Slide ${loop.index + 1}"></button>
				</c:if>
			</c:forEach>
		</div>
		<div class="carousel-inner">
			<!-- 캐러셀 아이템 동적 생성 -->
			<c:forEach var="category" items="${list}" varStatus="loop">
				<c:if test="${!empty category.dcate_banner}">
					<div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
						<a
							href="../category/categoryDetail?dcate_num=${category.dcate_num}">
							<img
							src="${pageContext.request.contextPath}/upload/${category.dcate_banner}"
							class="d-block w-100" alt="Slide ${loop.index + 1}">
						</a>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExample2" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExample2" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- 캐러셀 끝 -->
</div>
</section>

<section class="section-padding nanum">
	<div class="container d-flex justify-content-center">
		<div class="row col-lg-9 justify-content-center">
			<div class="col-lg-10 col-12 text-center mx-auto">
				<h4 class="mb-5">마음이 움직이는 주제를 선택하세요.</h4>
			</div>
			<c:forEach var="category" items="${list}" varStatus="loop">
				<div class="col-lg-3 col-md-6 col-12 mb-4 mb-lg-0 ct-item">
					<div
						class="featured-block d-flex justify-content-center align-items-center">
						<a
							href="../category/categoryDetail?dcate_num=${category.dcate_num}">
							<img
							src="${pageContext.request.contextPath}/upload/${category.dcate_icon}"
							class="featured-block-image img-fluid icon"
							alt="Slide ${loop.index + 1}">
							<p class="featured-block-text">
								<span class="dcate_name">${category.dcate_name}</span>
							</p>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div class="container col-lg-7" id="faq_container">
		<h4>
			<a href="/cs/faqlist?category=0">자주 묻는 질문</a>
		</h4>
		<hr class="header-hr">
		<div class="container px-0">
			<section class="accordion-section mx-0">
			<c:forEach var="faq" items="${faqlist}">
				<div class="accordion-item px-0">
					<div class="accordion-header">
						${faq.faq_question}
						<div class="align-right accordion-icon">▼</div>
					</div>
					<div class="accordion-body">
						${faq.faq_answer}
					</div>
				</div>
				<hr class="item-hr">
			</c:forEach>
			</section>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</section>