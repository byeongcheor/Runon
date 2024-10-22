<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/complete.css" type="text/css">

<%--<p style="font-size: 20pt;">Order ID: ${orderId}</p>--%>
<%--<script>--%>
<%--    var orderId = `${orderId}`;--%>
<%--</script>--%>
<script>
    var orderId = "${orderId != null ? orderId : ''}";
    if(!orderId){
        console.log("orderId가 정의되지 않았습니다.")
    }
    setTimeout(function(){
        console.log(usercode1);
        console.log(orderId);
        $.ajax({
            url:"/mypage/completed",
            type:"post",
            data:{
                orderId:orderId,
                usercode:usercode1
            },
            success:function(r){
                console.log(r.Cvo);
                var Cvo=r.Cvo;
                var allCvo=r.Cvo[0];
                var orderIdTag=` <span>주문</span>
            <span>주문번호: `+Cvo[0].orderId+`</span>`;
                document.getElementById("orderStN").innerHTML=orderIdTag;
                var orderListTag="";

                Cvo.forEach(function (cvo){
                    var orderStatusText = cvo.status === 1 ? "주문완료" : "주문중";
                    orderListTag +=`<div class="orderP2">
                <div class="orderP3">
                    <span>`+ new Date(cvo.create_time).toLocaleDateString()+`</span>
                </div>
                <div class="orderPd">
                    <div class="orderPdImg">
                        <img src="../img/cart/marathonposter1.png" alt="상품이미지">
                        <div class="orderPdN">
                            <span>` + cvo.marathon_name + `</span>
                        </div>
                    </div>
                </div>
                <div class="orderPdP">
                    <span>`+cvo.amount+`</span>
                </div>
                <div class="orderStatus">
                    <span>`+orderStatusText+`</span>
                </div>
            </div>`;


                });

                document.getElementById("usepoint").innerText=allCvo.discount_amount.toLocaleString('ko-KR')+"P";
                document.getElementById("realamount").innerText=allCvo.real_amount.toLocaleString('ko-KR')+"원";
                document.getElementById("orderP2").innerHTML=orderListTag;
                document.getElementById("discount2").innerText=allCvo.discount_amount.toLocaleString('ko-KR')+"원";
                document.getElementById("totalamount").innerText=(allCvo.real_amount+allCvo.discount_amount).toLocaleString('ko-KR')+"원";

            },
            error:function(e){
                console.error(e);
                console.log("실패");
            }
        });
    },400);

    function goBack() {
        history.back(); // 이전 페이지로 돌아갑니다.
    }
</script>

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
        <button type="button" onclick="goBack()"><span>확인</span></button>
    </div>
</div>
</div>