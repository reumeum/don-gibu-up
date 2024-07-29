<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    let itemName = "${goods.item_name}";
    let itemPrice = "${goods.item_price}";
    let buyerName = "${sessionScope.user.mem_nick}";
    let itemNum = "${goods.item_num}";
    let pageContextPath = "${pageContext.request.contextPath}";  
    
    function addToCart() {
        var form = document.getElementById('cartForm');
        form.submit();
    }
</script>
<div class="page-main">
    <h2>${goods.item_name}</h2>
    <ul class="detail-info">
        <li><img src="${pageContext.request.contextPath}${goods.item_photo}" width="300" height="300" class="my-photo2"></li>
        <li>재고: ${goods.item_stock}<br> 카테고리: ${goods.dcate_num}<br> 가격: <fmt:formatNumber value="${goods.item_price}" type="number" groupingUsed="true"/>원<br> 수량: <input type="number" id="quantity" name="quantity" value="0" min="0" max="${goods.item_stock}"></li>
    </ul>
    <div class="detail-content">${goods.item_detail}</div>
    <div>
        <input type="button" value="목록" onclick="location.href='list'">

        <form id="purchaseForm" method="post">
            <input type="hidden" name="merchantUid" value="${goods.item_num}_${System.currentTimeMillis()}">
            <input type="hidden" id="goods_do_price" name="amount" value="${goods.item_price}">
            <input type="button" value="구매하기" id="buy_now_button">
        </form>

        <form id="cartForm" action="${pageContext.request.contextPath}/cart/insert" method="post">
            <input type="hidden" name="item_num" value="${goods.item_num}">
            <c:if test="${not empty sessionScope.user}">
                <input type="hidden" name="mem_num" value="${sessionScope.user.mem_num}">
            </c:if>
            <label for="cart_quantity">수량:</label>
            <input type="number" id="cart_quantity" name="cart_quantity" value="1" min="1" max="${goods.item_stock}">
            <input type="button" value="장바구니 담기" onclick="addToCart()">
        </form>
    </div>
    <hr size="1" width="100%">
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const quantityInput = document.getElementById('quantity');
        const stock = parseInt("${goods.item_stock}");
        
        quantityInput.addEventListener('input', function() {
            if (this.value > stock) {
                alert('재고 수량을 초과할 수 없습니다.');
                this.value = stock;
            } else if (this.value < 1) {
                this.value = 1;
            }
        });
    });
</script>
<!-- 다음 주소 검색 API -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var jibunAddr = data.jibunAddress; // 지번 주소 변수

                // 사용자가 선택한 주소를 검색 창에 넣습니다.
                document.getElementById('delivery_address').value = roadAddr ? roadAddr : jibunAddr;
            }
        }).open();
    }
</script>

<!-- 모달 창 -->
<div class="modal fade" id="staticBackdrop" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">구매 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 포인트 입력 필드 -->
                <div class="mb-3">
                    <label for="goods_do_point" class="form-label">사용할 포인트</label>
                    <input type="number" class="form-control calculate" id="goods_do_point" placeholder="사용할 포인트 입력">
                </div>
                <!-- 결제 금액 출력 필드 -->
                <div class="mb-3">
                    <label class="form-label">결제 금액</label>
                    <span id="pay_sum"></span>
                </div>
                <!-- 주소 입력 필드 -->
                <div class="mb-3">
                    <label for="delivery_address" class="form-label">배송 주소</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="delivery_address" placeholder="배송 받을 주소 입력" readonly>
                        <button type="button" class="btn btn-outline-secondary" onclick="execDaumPostcode()">주소 검색</button>
                    </div>
                </div>
                <!-- 보유 포인트 -->
                <input type="hidden" id="mem_point" value="${sessionScope.user.mem_point}">
                <!-- 결제 금액 메시지 -->
                <div id="no"></div>
                 <!-- 기부처 정보 -->
                <div id="donation_info">
                    구매 금액의 10%는 
                    <c:choose>
                        <c:when test="${goods.dcate_num == 1}">독거노인 종합 지원센터</c:when>
                        <c:when test="${goods.dcate_num == 2}">안무서운회사</c:when>
                        <c:when test="${goods.dcate_num == 3}">동물권행동 카라</c:when>
                        <c:when test="${goods.dcate_num == 4}">희망 조약돌</c:when>
                        <c:when test="${goods.dcate_num == 5}">Save the Children</c:when>
                        <c:when test="${goods.dcate_num == 6}">굿네이버스</c:when>
                        <c:when test="${goods.dcate_num == 7}">서울환경연합</c:when>
                        <c:when test="${goods.dcate_num == 8}">푸르메 재단</c:when>
                        <c:otherwise>기타</c:otherwise>
                    </c:choose>
                    에 전달됩니다.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="confirm_purchase_button">결제</button>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/goods/purchase.js"></script>
