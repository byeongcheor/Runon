<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/cart.css" type="text/css">
<script src="/js/cart.js" type="text/javascript"></script>
<script src="https://js.tosspayments.com/v2/standard"></script>
<div class="cartFrm">
    <div class="cartName" id="cartItemsContainer">
        <h1>장바구니🛒</h1>
    </div>
    <div class="cartMain">
        <div class="cartM">
            <div>
                <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
            </div>
            <div>상품정보</div>
            <div>수량</div>
            <div>상품단가</div>
            <div>상품금액</div>
            <div></div>
        </div>

        <div id="ticket_cart" class="ticket_cart">

        </div>
    </div>
    <div class="cartBottom">
        <button id="deleteSelectedItems" onclick="deleteSelectedItems()">선택 상품 삭제</button>
    </div>
    <div class="paymentC">
        <ul class="payD">
            <li>상품 금액</li>
            <li>총 주문 금액</li>
        </ul>

    </div>
    <div class="orderC">
        <div class="shoppingC">
            <a href="/order/cart"><span>쇼핑 계속하기</span></a>
        </div>
        <div class="checkOrder">
            <button class="button" id="orderButton">선택 상품 주문하기</button>
        </div>
    </div>
</div>

