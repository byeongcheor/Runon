<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/css/complete.css" type="text/css">

<script>
    var orderId = `${orderId}`;
</script>
<script src="/js/complete.js" type="text/javascript"></script>

<div class="orderSheetFrm">
    <div class="orderStName">
        <h1>주문내역</h1>
    </div>
    <div class="orderStTop">
        <div id="orderStN" class="orderStN">

        </div>
        <div class="orderPt">
            <span>날짜</span>
            <span>상품명/옵션</span>
            <span>상품금액</span>
            <span>주문상태</span>
        </div>
        <div id="orderP2" class="orderP">

        </div>
    </div>
    <div class="discountList">
        <div class="discountListN">
            <span>할인 정보</span>
        </div>
        <div class="discountL">
            <div class="discountL2">
                <span>포인트 사용</span>
                <span id="usepoint">0원</span>
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
                <span id="totalamount">25,000원</span>
            </div>
            <div  class="discountL2">
                <span>할인 합계</span>
                <span id="discount2">0원</span>
            </div>
            <div class="discountL2">
                <span>최종 결제 금액</span>
                <span id="realamount"></span>
            </div>
            <div class="discountL2">
                <span>결제 수단</span>
                <span>${method}</span>
            </div>
        </div>
    </div>
    <div class="orderOk">
        <span>확인</span>
    </div>
</div>
</div>