<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/ordersheet.css" type="text/css">

<div class="orderSheetFrm">
    <div class="orderStName">
        <h1>주문내역</h1>
    </div>
    <div class="orderStTop">
        <div class="orderStN">
            <span>주문/배송상세</span>
            <span>주문번호: ${order.order_code}</span> <!-- 주문번호를 변수로 가져옵니다. -->
        </div>
        <div class="orderPt">
            <span>날짜</span>
            <span>상품명/옵션</span>
            <span>상품금액</span>
            <span>주문상태</span>
        </div>
        <c:forEach var="order" items="${orderHistory}">
            <div class="orderP">
                <div class="orderP2">
                    <div class="orderP3">
                        <span>${order.created_date}</span>
                    </div>
                    <div class="orderPd">
                        <div class="orderPdImg">
                            <img src="../img/cart/marathonposter1.png" alt="상품이미지">
                            <div class="orderPdN">
                                <span>${order.marathon_name}</span> <!-- 주문한 상품명 -->
                                <span>5.5Km, 티셔츠(L) / ${order.quantity}개</span> <!-- 수량 -->
                            </div>
                        </div>
                    </div>
                    <div class="orderPdP">
                        <span>${order.total_amount}원</span> <!-- 상품 금액 -->
                    </div>
                    <div class="orderStatus">
                        <span>${order.order_status}</span> <!-- 주문 상태 -->
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="discountList">
        <div class="discountListN">
            <span>할인 정보</span>
        </div>
        <div class="discountL">
            <div class="discountL2">
                <span>포인트 사용</span>
                <span>${appliedPoints}원</span> <!-- 사용된 포인트 -->
            </div>
        </div>
    </div>
    <div class="payList">
        <div class="payListN">
            <span>결제 정보</span>
        </div>
        <div class="discountL">
            <div class="discountL2">
                <span>상품금액</span>
                <span>${order.total_amount}원</span> <!-- 상품 금액 -->
            </div>
            <div class="discountL2">
                <span>할인 합계</span>
                <span>${order.discountAmount}원</span> <!-- 할인 합계 -->
            </div>
            <div class="discountL2">
                <span>최종 결제 금액</span>
                <span>${order.real_amount}원</span> <!-- 최종 결제 금액 -->
            </div>
            <div class="discountL2">
                <span>결제 수단</span>
                <span>${order.payment_method}</span> <!-- 결제 수단 -->
            </div>
        </div>
    </div>
    <div class="orderOk">
        <span>확인</span>
    </div>
</div>
