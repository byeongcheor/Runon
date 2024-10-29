
setTimeout(function(){



/*    console.log(usercode1);
    console.log(orderId);*/
    $.ajax({
        url:"/payment/completed",
        type:"post",
        data:{
            orderId:orderId,
            usercode:usercode1
        },
        success:function(r){
      /*      console.log(r.Cvo);*/
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

        },
        error:function(e){
          /*  console.error(e);
            console.log("실패");*/
        }
    });



},400);
function gomain(){
    window.location.href="/marathon/marathonList";
}