var PaymentSearchType=null;
var PaymentSearchValue=null;
var schedule=null;
var sort=null;
var isAmountDescending = true;
var isLatestDescending = true;

var page=0;
var now;

setTimeout(function() {
    loadPayList(page);
    document.getElementById('amountSortBtn').addEventListener('click', function () {
        var icon = this.querySelector('i');
        schedule="total_amount";// button 내의 i 태그 선택

        var  icon2=document.getElementById("latestSortBtn").querySelector('i')
        icon2.classList.remove('fa-arrow-up-wide-short');
        icon2.classList.remove('fa-arrow-down-wide-short');

        if (isAmountDescending) {

            sort = 'desc';  // 내림차순 (비싼 순)
            console.log("금액순: 내림차순");
            icon.classList.remove('fa-arrow-up-wide-short');  // 기존 클래스 제거
            icon.classList.add('fa-arrow-down-wide-short');  // 내림차순 아이콘 추가
        } else {
            sort = 'asc';  // 오름차순 (저렴한 순)
            console.log("금액순: 오름차순");
            icon.classList.remove('fa-arrow-down-wide-short');  // 기존 클래스 제거
            icon.classList.add('fa-arrow-up-wide-short');  // 오름차순 아이콘 추가
        }

        isAmountDescending = !isAmountDescending;
        loadPayList(1,PaymentSearchType,PaymentSearchValue,schedule,sort);// 상태 반전
    });

// 최신순 버튼 클릭 이벤트
    document.getElementById('latestSortBtn').addEventListener('click', function () {
        schedule="completed_date";
        var icon = this.querySelector('i'); // button 내의 i 태그 선택
        var  icon2=document.getElementById("amountSortBtn").querySelector('i')
        icon2.classList.remove('fa-arrow-up-wide-short');
        icon2.classList.remove('fa-arrow-down-wide-short');

        if (isLatestDescending) {

            sort = 'desc';  // 내림차순 (최신 순)
            console.log("최신순: 내림차순");
            icon.classList.remove('fa-arrow-up-wide-short');  // 기존 클래스 제거
            icon.classList.add('fa-arrow-down-wide-short');  // 내림차순 아이콘 추가
        } else {
            sort = 'asc';  // 오름차순 (과거 순)
            console.log("최신순: 오름차순");
            icon.classList.remove('fa-arrow-down-wide-short');  // 기존 클래스 제거
            icon.classList.add('fa-arrow-up-wide-short');  // 오름차순 아이콘 추가
        }
        isLatestDescending = !isLatestDescending;
        loadPayList(1,PaymentSearchType,PaymentSearchValue,schedule,sort);// 상태 반전
    });
}, 400);

function loadPayList(page,PaymentSearchType,PaymentSearchValue,schedule,sort) {
    if (page==0){
        page=1;
    }
    var PaymentData={
        page:page
    }
    now=page;
    if (PaymentSearchType&&PaymentSearchValue){
        PaymentData.searchKey=PaymentSearchType;
        PaymentData.searchWord=PaymentSearchValue;
    }
    if (schedule&&sort){
        PaymentData.schedule=schedule;
        PaymentData.sort=sort;
    }
    if (usercode1){
        PaymentData.usercode=usercode1;
    }
    $.ajax({
        url:"/adminPages/PaymentList",
        type:"post",
        data:PaymentData,
        success:function(r){
            var PayVo=r.Payvo;
            var pVO=r.pvo;
            var avo=r.Avo;
            if(avo.role<2||avo.admin_code==0){
                var tag = "<li>" +
                    "<div id='payment_title2'>" +
                    "<div class='orderId'>주문번호</div>" +
                    "<div  class='marathon_name'>마라톤명</div>" +
                    "<div id='total_amount' class='total_amount'>총가격</div>";
                tag +=  "<div class='payment_method'>결제방식</div>" +
                    "<div class='nickname'>닉네임</div>";
                tag += "<div class='completed_date'>결제일자</div>";
                tag += "</div></li>";
                PayVo.forEach(function(PayVo){
                    var totalamount=PayVo.total_amount;

                    tag +="<li  onclick='detail(\""+PayVo.orderId+"\",\""+PayVo.payment_method+"\")'>" +
                        "<div class='payment_title3'>" +
                        "<div class='orderId'>"+PayVo.orderId+"</div>" +
                        "<div class='marathon_name'>"+PayVo.latest_marathon_name;
                    if (PayVo.marathon_count!=0){
                        tag+= " 외"+PayVo.marathon_count;
                    }
                    tag += "</div><div class='total_amount'>"+PayVo.total_amount+"</div>";
                    tag += "<div class='payment_method'>"+PayVo.payment_method+"</div>";
                    tag += "<div class='nickname'>"+PayVo.nickname+"</div>";
                    tag += "<div class='completed_date'>"+PayVo.completed_date+"</div>";
                    tag += "</div></li>";

                });



                document.getElementById("PaymentList").innerHTML=tag;


                var paginationTag="";


                if (pVO.nowpage>1){
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadPayList(" + (pVO.nowPage - 1) +
                        ", PaymentSearchType,PaymentSearchValue,schedule,sort);'>Previous</a></li>";
                }
                for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:loadPayList(" + p
                            + ", PaymentSearchType,PaymentSearchValue,schedule,sort);'>" + p + "</a></li>";
                    }
                }
                if (pVO.nowPage < pVO.totalPage) {

                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadPayList(" + (pVO.nowPage + 1) +
                        ", PaymentSearchType,PaymentSearchValue,schedule,sort);'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);


            }
        }
    });

}
function enterKey(event) {

    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
function searchbutton(){
    PaymentSearchType=document.getElementById("CertificateSearchValue").value;
    PaymentSearchValue=document.getElementById("searchtext").value;
    alert(PaymentSearchType+":"+PaymentSearchValue);
    loadPayList(1,PaymentSearchType,PaymentSearchValue,schedule,sort);


}
function reset(){
    loadPayList(1);
}
function detail(orderId,payment_method){
    console.log(payment_method);
    $.ajax({
        url:"/payment/completed",
        type:"post",
        data:{
            orderId:orderId,
            usercode:usercode1
        },
        success:function(r){
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
            document.getElementById("paymentdetailbackground").style.display="block";
            document.getElementById("usepoint").innerText=allCvo.discount_amount.toLocaleString('ko-KR')+"P";
            document.getElementById("realamount").innerText=allCvo.real_amount.toLocaleString('ko-KR')+"원";
            document.getElementById("orderP2").innerHTML=orderListTag;
            document.getElementById("discount2").innerText=allCvo.discount_amount.toLocaleString('ko-KR')+"원";
            document.getElementById("totalamount").innerText=(allCvo.real_amount+allCvo.discount_amount).toLocaleString('ko-KR')+"원";
            document.getElementById("method").innerText=payment_method;
        }
    });

}

function closedetail(){
    document.getElementById("paymentdetailbackground").style.display="none";
}