<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<link rel="stylesheet" href="/css/orderForm.css" type="text/css">
<script src="/js/orderForm.js" type="text/javascript"></script>
<script src="https://js.tosspayments.com/v2/standard"></script>
<div class="cartFrm">
    <div class="cartName" id="cartItemsContainer">
        <h1>주문서 작성</h1>
    </div>
    <div class="orderMain">
        <div class="orderM">
            <div>상품정보</div>
            <div>수량</div>
            <div>상품단가</div>
            <div>상품금액</div>

        </div>

        <div id="ticket_order" class="ticket_order">
            <c:forEach var="order" items="${Ovo}">
                <div class="oneline">
                    <div class="ticket">
                        <img src="${order.poster_img}"/>
                        <span class="marathonT">${order.marathon_name}</span>
                    </div>
                    <div class="num">${order.quantity}</div>
                    <div class="price">${order.price}</div>
                    <div class="amount">${order.price*order.quantity}</div>
                </div>
            </c:forEach>
            <h1>할인정보</h1>
            <div>포인트사용</div>
            <div id="pointTable">
                <input type="text" id="pointInput" placeholder="100p부터 사용가능"/>
                <button type="button" onclick="usePoints()">사용</button>
                <button type="button" onclick="useAllPoints()">전액 사용</button>
                <div>보유 포인트: <span id="userPoints">0원</span></div>

            </div>
        </div>
    </div>

    <div class="paymentC">
        <ul class="payD">
            <li>총 주문 금액 </li>
        </ul>
        <ul class="payP" id="totalAmountDisplay">
            <li id="totalAmounts">00원</li>
        </ul>

    </div>
    <div class="orderC">
        <div class="checkOrder">
            <button class="button" id="orderButton" onclick="goOrder()">마라톤 신청하기</button>
        </div>
    </div>
</div>

