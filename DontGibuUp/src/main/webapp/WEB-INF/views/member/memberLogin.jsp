<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/challenge.css">

  <div class="container-scroller nanum">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
            
              <h4>돈기부업과 함께 Don't Give Up!</h4>
              <h6 class="fw-light">즐겁게 기부에 동참하세요</h6>
			  <form:form class="pt-3 nanum" action="login" id="member_login" modelAttribute="memberVO">
			  
                <form:errors element="div" cssClass="form-error"/>
                <c:if test="${!empty error}"><div class="form-error nanum">${error}</div></c:if>
                <br>
                
                <div class="form-group">
                  <form:input path="mem_email" type="email" class="form-control form-control-lg" id="exampleInputEmail1" placeholder="Email"/>
                  <form:errors path="mem_email" cssClass="form-error"></form:errors>
                </div>
                <div class="form-group">
                  <form:password path="mem_pw" class="form-control form-control-lg" id="exampleInputPassword1" placeholder="Password"/>
                  <form:errors path="mem_pw" cssClass="form-error"></form:errors>
                </div>

                <div class="submit-button mt-3 d-flex justify-content-center align-items-center submit-button">
                  <form:button class="submit-button2 btn btn-block btn-primary font-weight-medium auth-form-btn nanum custom-btn">로그인</form:button>
                </div>

                <div class="align-center">
                  <a href="findPassword" class="auth-link text-black nanum">비밀번호 찾기</a> |
                  <a href="signup" class="auth-link text-black nanum">회원가입</a>
				</div>
				<br>
				<hr>
                <div class="mb-2 align-center">
                	 <p><small>SNS로 간편하게 시작하기</small></p>
                  <a href="${pageContext.request.contextPath}/member/oauth/kakao" class="me-2">
                    <img alt="카카오톡 간편 로그인" width="60" src="${pageContext.request.contextPath}/images/logo_sns/kakaotalk_logo.png">
                  </a>
                  <a href="${pageContext.request.contextPath}/member/oauth/naver">
                    <img alt="네이버 간편 로그인" width="60" src="${pageContext.request.contextPath}/images/logo_sns/naver_logo.png">
                  </a>
                </div>
              </form:form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="${pageContext.request.contextPath}/t2/vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="${pageContext.request.contextPath}/t2/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="${pageContext.request.contextPath}/t2/js/off-canvas.js"></script>
  <script src="${pageContext.request.contextPath}/t2/js/hoverable-collapse.js"></script>
  <script src="${pageContext.request.contextPath}/t2/js/template.js"></script>
  <script src="${pageContext.request.contextPath}/t2/js/settings.js"></script>
  <script src="${pageContext.request.contextPath}/t2/js/todolist.js"></script>
  <!-- endinject -->
