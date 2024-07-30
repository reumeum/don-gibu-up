<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
/************모달************/

.product-list {
    display: flex;
    flex-wrap: wrap;
    gap: 15px; /* 상품 간의 간격을 줄임 */
    justify-content: space-between;
}

.product-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    width: 24%; /* 너비를 24%로 설정하여 한 줄에 4개가 보이도록 함 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    transition: transform 0.2s;
}

.product-item img {
    width: 130px; /* 이미지 크기를 조금 더 키움 */
    height: 130px;
    border-radius: 50%;
    margin-bottom: 10px;
}

.product-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.product-details {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.product-controls {
    margin-top: 10px;
}

/* 페이지 레이아웃
---------------------*/
.page-main {
    width: 98%;
    margin: 0 auto;
}

.page-one {
    width: 600px;
    margin: 0 auto;
}

/* 공통 메시지
---------------------*/
.result-display {
    width: 400px;
    height: 200px;
    margin: 50px auto;
    border: 1px solid #000;
    display: flex;
    align-items: center; /* 세로 정렬 */
    justify-content: center; /* 가로 정렬 */
}

.error-color {
    color: #ff0000;
}

/* 공통 정렬
---------------------*/
.align-center {
    text-align: center;
}

.align-right {
    text-align: right;
}

.align-left {
    text-align: left;
}

/* 상단 메뉴
---------------------*/
div#main_menu li {
    list-style: none;
}

div#main_menu ul li {
    margin-bottom: 5px;
}

/* 메인
---------------------*/
.image-space .horizontal-area {
    margin: 2px;
    padding: 3px;
    width: 220px;
    height: 240px;
    float: left;
    overflow: hidden;
    text-align: center;
}

.image-space .horizontal-area img {
    width: 215px;
    height: 195px;
}

.image-space .float-clear {
    clear: both;
}

/* 공통 등록, 수정 폼
---------------------*/
/* form {
    width: 600px;
    margin: 0 auto;
    border: 1px solid #000;
    padding: 10px 10px 30px 10px;
}
form ul li label {
    width: 110px;
    display: inline-block;
}
ul {
    list-style: none;
}
input, select {
    margin-top: 4px;
    padding: 5px;
}
input[type="text"], input[type="password"],
                                     input[type="email"] {
    width: 350px;
} */

/* Admin, MY페이지 공통
---------------------*/
.side-bar {
    margin: 10px 10px 10px 0;
    padding: 10px;
    /* 사이드바의 높이가 컨텐트의 높이와 동일하게 자동 조절 */
    margin-bottom: -9999px;
    padding-bottom: 9999px;
    background-color: #cecccc;
}

.side-bar ul {
    margin: 0;
    padding: 0;
}

.side-bar ul li {
    padding: 5px 10px 5px 10px;
}

.side-bar ul li img {
    margin-left: 3px;
}

.side-height {
    /* 사이드바의 높이가 컨텐트의 높이와 동이라하게 자동 조절하기 위해 흘러넘친 배경색은 숨김 */
    overflow: hidden;
    margin-bottom: 10px;
}

#page_nav {
    float: left;
    width: 25%;
    min-height: 530px;
}

#page_body {
    width: 75%;
    float: left;
}

.page-clear {
    clear: both;
}

/* 공통 프로필 
---------------------*/
.my-photo {
    object-fit: cover;
    /* 정사각형이 아니라 직사각형일 경우 원 안에 보여지게 할 중심 이미지의 위치를 지정 */
    object-position: top;
    border-radius: 50%;
}

.my-photo2 {
    width: 300px; /* 이미지의 가로 크기 */
    height: 300px; /* 이미지의 세로 크기 */
    border-radius: 0; /* 둥근 모서리를 제거 */
}

/* 공통 목록
---------------------*/
form#search_form {
    width: 98%;
    padding-bottom: 0;
    border: none;
}

ul.search {
    width: 380px;
    list-style: none;
    padding: 0;
    margin: 0 auto;
}

ul.search li {
    margin: 0 0 9px 0;
    padding: 0;
    display: inline;
}

.list-space {
    width: 700px;
    margin: 10px auto;
}

/* 공통 테이블
---------------------*/
/* table.basic-table {
    width: 100%;
    border: 1px solid #000;
    border-collapse: collapse;
    margin-top: 5px;
}
table.basic-table td, table.basic-table th {
    border: 1px solid #000;
    padding: 5px;
}
table.striped-table {
    width: 100%;
    border: 1px solid #FFF;
    border-collapse: collapse;
    font-size: 15px;
    margin: 7px 0;
}
table.striped-table td, table.striped-table th {
    padding: .7em .5em;
    vertical-align: middle;
}
table.striped-table th {
    font-weight: bold;
    background: #E1E1E1;
}
table.striped-table td {
    border-bottom: 1px solid rgba(0, 0, 0, .1);
}

/* 공통 버튼
---------------------*/
/* [type="submit"], [type="button"] {
    height: 30px;
} */

.menu-btn {
    width: 100%;
    height: 50px;
    font-size: 12pt;
    background-color: #fcfcfc;
    border-color: #b7b5b5;
    border-radius: 5px;
}

.default-btn {
    padding: 4px 20px;
    border: 1px solid #09aa5c;
    border-radius: 2px;
    color: #fff;
    background-color: #09aa5c;
    font-weight: bold;
    cursor: pointer;
}

.default-btn:hover {
    background-color: #FFF;
    color: #09aa5c;
    transition: 0.2s ease-out;
    height: 30px;
}

/* 상품
---------------------*/
.item-space .horizontal-area {
    margin: 2px;
    padding: 3px;
    width: 200px;
    height: 220px;
    float: left;
    overflow: hidden;
    text-align: center;
}

.item-space .horizontal-area img {
    width: 195px;
    height: 175px;
}

.item-space .horizontal-area span {
    padding: 5px;
    margin: 5px;
}

.item-space .float-clear {
    clear: both;
}

label[for="order_quatity"] {
    width: 80px;
}

.item-image {
    width: 400px;
    margin: 0 0 10px 0;
    float: left;
}

.item-image li {
    padding: 0 0 5px 0;
}

.item-detail form {
    border: none;
    width: 470px;
    margin: 0;
    float: left;
}

#item_total_txt {
    color: #000;
    font-weight: bold;
}

input[type="number"].quantity-width {
    width: 40px;
    margin-bottom: 3px;
}

.sold-out {
    color: red;
}

/* 장바구니
---------------------*/
form[id="cart_order"] {
    border: none;
}

form[id="order_modify"], form[id="order_form"] {
    width: 860px;
}

#delivery_text {
    color: red;
}

ul#delivery_info li span {
    width: 130px;
    display: inline-block;
}

.g-custom-btn {
    border-radius: 6px !important;
    color: #fff !important;
    background-color: #5a6f80 !important;
    border: none !important;
}

.goods-item {
    padding: 20px;
    margin: 0 10px;
}

.g-photo-div {
    margin-right: 5rem;
}

.g-basic-info {
    margin-bottom: 9rem;
}

.detail-content {
    margin-top: 5rem;
}

.card-title {
    font-size: 1.125rem;
}

.card-text {
    font-size: 0.88rem;
}

.g-buy-label {
    font-weight: bold;
}

</style>