<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/complete.css" type="text/css">

<%--<p style="font-size: 20pt;">Order ID: ${orderId}</p>--%>
<%--<script>--%>
<%--    var orderId = `${orderId}`;--%>
<%--</script>--%>


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
                <span>${payment_method}</span>
            </div>
        </div>
    </div>
    <div id="orderOk" class="orderOk">

    </div>
</div>
</div>


<script>
    var payment_method=`${payment_method}`;
    /*console.log("${payment_method}");*/
    var orderId = "${orderId != null ? orderId : ''}";
    if(!orderId){
        /*console.log("orderId가 정의되지 않았습니다.")*/
    }
    setTimeout(function(){
      /*  console.log(usercode1);
        console.log(orderId);*/
        $.ajax({
            url:"/mypage/completed",
            type:"post",
            data:{
                orderId:orderId,
                usercode:usercode1
            },
            success:function(r){
                /*console.log(r.Cvo);*/
                var Cvo=r.Cvo;
                var allCvo=r.Cvo[0];
                var orderIdTag=` <span>주문</span>
            <span>주문번호: `+Cvo[0].orderId+`</span>`;
                document.getElementById("orderStN").innerHTML=orderIdTag;
                var buttonTag=`<button type="button" onclick="goBack()"><span>확인</span></button>
        <button type="button" style="background-color: lightgray" onclick="cancel('`+Cvo[0].paymentKey+`')"><span>주문취소</span></button>`;
                document.getElementById("orderOk").innerHTML=buttonTag;


                var orderListTag="";

                Cvo.forEach(function (cvo){
                    var orderStatusText = cvo.status === 1 ? "주문완료" : "주문취소";
                    orderListTag +=`<div class="orderP2">`;
                    if (cvo.status == 1){
                        orderListTag+=`
                    <input type="checkbox" value="`+cvo.payment_detail_id+`"class="detailid">`;
                    }
                    orderListTag+=`
                <div class="orderP3">
                    <span>`+ new Date(cvo.create_time).toLocaleDateString()+`</span>
                </div>
                <div class="orderPd">
                    <div class="orderPdImg">
                        <img src="../img/marathonPoster/`+cvo.poster_img+`" alt="상품이미지">
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
                document.getElementById("method").innerText=payment_method;

            },
            error:function(e){
                /*console.error(e);
                console.log("실패");*/
            }
        });
    },400);


    var return_amount =0;
    var return_discount=0;
    function cancel(paymentKey){
        const elements = document.querySelectorAll('.detailid');
        const checkedValues = Array.from(elements)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.value);
        if (checkedValues!=null &&checkedValues!=""){
            if (confirm("정말 환불하시겠습니까?")){

                $.ajax({
                    url:"/payment/cancelpayment",
                    type:"post",
                    data:{
                        paymentdetail_codes:checkedValues
                    },success:function(r){
                        var pdvo=r.Pdvo;
                        var onepdvo=r.Pdvo[0];
                        var payment_code=pdvo[0].payment_code;
                        var paymentKey=pdvo[0].paymentKey;
                        var discount=0;
                        var total=0;
                        //총 사용 포인트
                        var discount_amount=pdvo[0].discount_amount
                        //총 사용 금액
                        var real_amount= pdvo[0].real_amount;
                        pdvo.forEach(function(pdvo){
                            total+=pdvo.total_amount;
                        });
                        /*console.log("총금액"+real_amount);
                        console.log("총사용포인트"+discount_amount);*/
                        if (pdvo[0].discount_amount!=0&&pdvo[0].discount_amount!=""&&pdvo[0].discount_amount!=null){
                            discount = total/(pdvo[0].discount_amount + pdvo[0].real_amount);
                        }
                        /*console.log("환불신청금액"+total);
                        console.log('퍼센트'+discount);*/

                        return_discount=Math.round(discount_amount*discount);
                        return_amount=Math.round(total-return_discount);


                        if (real_amount==total-discount_amount){
                            return_amount=real_amount;
                            return_discount=discount_amount;
                          /*  console.log("환불할 all포인트"+return_discount);
                            console.log("환불할 all금액"+return_amount);*/

                        }/*else if (real_amount<total-discount_amount){
                        return_amount=real_amount;
                        return_discount=discount_amount-(total-discount_amount);
                        console.log("환불할 all포인트"+return_discount);
                        console.log("환불할 all금액"+return_amount);
                    }

                    console.log("진짜포인트환불"+return_discount);
                    console.log("진짜환불"+return_amount);*/
                        $.ajax({
                            url:"https://api.tosspayments.com/v1/payments/"+paymentKey+"/cancel",
                            type:'POST',
                            headers:{
                                'Authorization': 'Basic dGVzdF9nc2tfZG9jc19PYVB6OEw1S2RtUVhrelJ6M3k0N0JNdzY6',
                                'Content-Type':'application/json'
                            },
                            data:JSON.stringify({
                                cancelReason: '고객이 취소를 원함',
                                cancelAmount:return_amount
                            }),
                            success:function(r){
                                /*console.log(r);*/
                                var refund_amount=r.balanceAmount;
                                $.ajax({
                                    url:"/payment/refund",
                                    type:"post",
                                    data:{
                                        refund_amount:refund_amount,
                                        usercode:usercode1,
                                        order_codes:checkedValues,
                                        return_discount:return_discount,
                                        paymentKey:paymentKey,
                                        reason: '고객이 취소를 원함'
                                    },
                                    success:function(r){
                                        window.location.reload();
                                    }
                                });
                            },error:function(e){
                                /*console.log(e);*/
                            }

                        });

                    }
                });
            }else{
                alert("환불을 취소하였습니다");
            }
        }else{
            alert("    취소가능한 상품이 없거나 \n혹은 취소하실 물품을 선택해주세요");
        }

    }

    function goBack() {
       window.location.href="/mypage/purchaseList" // 이전 페이지로 돌아갑니다.
    }
</script>