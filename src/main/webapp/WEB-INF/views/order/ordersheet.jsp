<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/ordersheet.css" type="text/css">
<script src="js/ordersheet.js" type="text/javascript"></script>
<script>
      //주문성공 알림창
       window.onload = function() {
           alert("주문이 성공적으로 완료되었습니다!");
       };

</script>

<div class="orderSheetFrm">
    <div class="orderStName">
            <h1>주문내역</h1>
        </div>
        <div class="orderStTop">
            <div class="orderStN">
                <span>주문/배송상세</span>
                <span>주문번호: 2409281521550181</span>
            </div>
            <div class="orderPt">
                <span>날짜</span>
                <span>상품명/옵션</span>
                <span>상품금액</span>
                <span>주문상태</span>
            </div>
            <div class="orderP">
                <div class="orderP2">
                    <div class="orderP3">
                        <span>2024/09/28</span>
                    </div>
                    <div class="orderPd">
                        <div class="orderPdImg">
                                <img src="../img/cart/marathonposter1.png" alt="상품이미지">
                            <div class="orderPdN">
                                <span>2024 3대 마라톤 - 여의도 나이트런</span>
                                <span>5.5Km,티셔츠(L)/1개</span>
                            </div>
                        </div>
                    </div>
                    <div class="orderPdP">
                        <span>25,000원</span>
                    </div>
                    <div class="orderStatus">
                        <span>주문완료</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="discountList">
             <div class="discountListN">
              <span>할인 정보</span>
             </div>
             <div class="discountL">
                <div class="discountL2">
                    <span>포인트 사용</span>
                    <span>0원</span>
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
                    <span>25,000원</span>
                </div>
                <div class="discountL2">
                    <span>할인 합계</span>
                    <span>0원</span>
                </div>
                <div class="discountL2">
                    <span>최종 결제 금액</span>
                    <span>25,000원</span>
                </div>
                <div class="discountL2">
                    <span>결제 수단</span>
                    <span>카드</span>
                </div>
            </div>
        </div>
        <div class="orderOk">
            <span>확인</span>
        </div>
    </div>
</div>