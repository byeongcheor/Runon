<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body{
        background-color: #F8FAFB;
    }
    #bannerBox{
        width:100%;
        height:200px;
        margin: 0 auto;
    }
    #bannerImg{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .page_title{
        font-size: 18pt;
        text-align: center;
        margin: 30px;
        font-weight: 500;
    }
    .body_container{
        background-color: white;
        width: 900px;
        height: auto;
        margin: 0 auto;
        border-radius: 10px 10px 0 0;
    }
    .orderStTop{
        width: 90%;
        margin: 0px auto;
    }
    .orderStN span:nth-of-type(1) {
        font-size: 20px;
        font-weight: bold;
        text-align: left;
        color: rgb(51, 51, 51);
    }
    .orderStN span:nth-of-type(2) {
        font-size: 15px;
        font-weight: 500;
        text-align: left;
        color: rgb(102, 102, 102);
        margin-left: 10px;
    }
    .orderPt{
        flex: 1 1 0%;
        display: flex;
        border-top: 1px solid rgb(102, 102, 102);
        margin-top: 14px;
    }
    .orderPt span{
        font-size: 15px;
        font-weight: bold;
        text-align: center;
        color: rgb(51, 51, 51);
        padding: 16px 0px;
    }
    .orderPt span:nth-of-type(1) {
        flex: 1 1 0%;
    }
    .orderPt span:nth-of-type(2) {
        flex: 2 1 0%;
    }
    .orderPt span:nth-of-type(3) {
        flex: 1 1 0%;
    }
    .orderPt span:nth-of-type(4) {
        flex: 1 1 0%;
    }
    .orderPt span:nth-of-type(5) {
         flex: 1 1 0%;
    }
    .orderP{
        display: flex;
        flex-direction: column;
        -webkit-box-pack: center;
        justify-content: center;
        align-items: flex-start;
        border-bottom: 1px solid rgb(102, 102, 102);
    }
    .orderP2{
        width: 100%;
        flex: 1 1 0%;
        display: flex;
        border-top: 1px solid rgb(221, 221, 221);
        padding: 24px 0px;
    }
    .orderP3{
        flex: 1 1 0%;
        display: flex;
        flex-direction: column;
        -webkit-box-pack: center;
        justify-content: center;
        -webkit-box-align: center;
        align-items: center;
    }
    .orderP3 span {
        font-size: 15px;
        font-weight: normal;
        text-align: center;
        color: rgb(51, 51, 51);
    }
    .orderPd{
        flex: 2 1 0%;
        display: flex;
        flex-direction: row;
        -webkit-box-pack: start;
        justify-content: start;
        -webkit-box-align: center;
        align-items: center;
    }
    .orderPdImg{
        display: flex;
        flex: 1 1 0%;
    }
    .orderPdImg img {
        width: 92px;
        height: 92px;
        border-radius: 10px;
        margin-left: 30px;
        flex: 1 1 0%;
    }
    .orderPdN{
        display: flex;
        flex-direction: column;
        -webkit-box-pack: center;
        justify-content: center;
        -webkit-box-align: center;
        align-items: center;
        margin-left: 20px;
        margin-right: 30px;
        flex: 2 1 0%;
    }
    .orderPdN span:nth-of-type(1) {
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        color: rgb(51, 51, 51);
    }
    .orderPdN span:nth-of-type(2) {
        font-size: 14px;
        font-weight: normal;
        text-align: center;
        color: rgb(119, 119, 119);
    }
    .orderPdP{
        flex: 1 1 0%;
        display: flex;
        flex-direction: column;
        -webkit-box-pack: center;
        justify-content: center;
        -webkit-box-align: center;
        align-items: center;
    }
    .orderPdP span {
        font-size: 15px;
        font-weight: normal;
        text-align: center;
        color: rgb(51, 51, 51);
    }
    .orderStatus{
        flex: 1 1 0%;
        display: flex;
        flex-direction: column;
        -webkit-box-pack: center;
        justify-content: center;
        -webkit-box-align: center;
        align-items: center;
    }
    .orderStatus span {
        font-size: 15px;
        font-weight: 500;
        text-align: center;
        color:rgb(51, 51, 51);
    }
    .pagination .page-link{
        color: black;
    }
    .pagination .page-link:hover {
        color: #fff; /* 호버 시 텍스트 색상 */
        background-color: black; /* 호버 시 배경색 */
    }
    /* 활성화된 페이지 아이템 색상 변경 */
    .pagination .page-item.active .page-link {
        background-color: black; /* 배경색 */
        border-color: black;     /* 테두리 색상 */
        color: white;              /* 텍스트 색상 */
    }

    /* 활성화된 페이지 아이템 호버 시 색상 변경 */
    .pagination .page-item.active .page-link:hover {
        background-color: grey; /* 호버 시 배경색 */
        border-color: grey;     /* 호버 시 테두리 색상 */
    }
     #paging{
         display: flex;
         justify-content: center;
         padding-bottom: 20px;
     }
     .orderStatus button{
         font-size: 10pt;
     }
     .proName{
         white-space: nowrap;
         overflow: hidden;
         text-overflow: ellipsis;
         width: 250px;
     }
</style>
<script>
    setTimeout(function(){
        var page;
        reloadPage(page)
    },100)
    function reloadPage(page) {
        if(page==null){
            page=1;
        }
        $.ajax({
            url: "/mypage/viewOrder",
            type: "post",
            data: {
                username: username1,
                usercode: usercode1,
                page: page
            },
            success: function (r) {
                var tag = "";
                var pvo = r.pvo;

                if(r.list.length == 0){
                    tag += `
                        <div class="row" style="margin-top: 40px;margin-bottom: 500px; margin-left: 40%;">
                            <p>구매내역이 없습니다.</p>
                        </div>
                    `;
                }else{
                    $.each(r.list, function (i, vo) {
                        if (vo.is_completed == 1) {
                            vo.is_completed = "주문완료";
                        } else {
                            vo.is_completed = "주문취소";
                        }
                        var marathonCountText = (vo.marathon_count > 1) ? ` 및 ...` : '';
                        tag += `
                        <div class="orderP2">
                            <div class="orderP3">
                                <span>` + vo.completed_date + `</span>
                            </div>
                            <div class="orderPd">
                                <div class="orderPdImg">
                                    <div class="orderPdN">
                                        <span class="proName">` + vo.latest_marathon_name + marathonCountText+ `</span>
                                    </div>
                                </div>
                            </div>
                            <div class="orderPdP">
                                <span>` + vo.payment_method + `</span>
                            </div>
                            <div class="orderStatus">
                                <span>` + vo.total_amount + `</span>
                            </div>
                            <div class="orderStatus">
                                <span><button type="button" class="btn btn-outline-secondary" onclick="orderDetails('`+vo.orderId+`')">주문상세</button></span>
                            </div>
                        </div>
                    `;
                    });
                }
                document.getElementById("orderlist").innerHTML = tag;

                // 2. 페이징 정보 렌더링
                var paginationTag = "";

                // 이전 버튼
                if (pvo.nowPage > 1) {
                    paginationTag += "<li class= 'page-item'><a class='page-link' href='javascript:reloadPage("+(pvo.nowPage - 1)+");'><</a></li>";
                }

                // 페이지 번호 출력
                for (var p = pvo.startPageNum; p <= pvo.startPageNum + pvo.onePageNum - 1; p++) {
                    if (p <= pvo.totalPage) {
                        paginationTag += "<li class='page-item " + (pvo.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:reloadPage(" + p + ");'>" + p + "</a></li>";
                    }
                }

                // 다음 버튼
                if (pvo.nowPage < pvo.totalPage) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pvo.nowPage + 1) + ");'>></a></li>";
                }

                $(".pagination").html(paginationTag);

            }, error: function (e) {
                alert("실패")
            }
        })
    }
</script>
<script>
    function orderDetails(orderId){
        var orderId = orderId;
        $.ajax({
            url: "/mypage/viewOrderDetails",
            type: "post",
            data:{
                usercode: usercode1,
                orderId: orderId,
                username: username1
            },
            success: function(r){
                if(r=="success"){
                    //window.location.href="/mypage/viewOrderDetail"+orderId;
                    // 동적으로 폼 생성
                    let form = document.createElement("form");
                    form.method = "post";
                    form.action = "/mypage/complete";
                    // 전달할 값을 폼에 숨겨진 필드로 추가
                    let orderIdInput = document.createElement("input");
                    orderIdInput.type = "hidden";
                    orderIdInput.name = "orderId";
                    orderIdInput.value = orderId;
                    form.appendChild(orderIdInput);

                    // 동적으로 생성한 폼을 문서에 추가하고 제출
                    document.body.appendChild(form);
                    form.submit();
                }
            },error: function(e){
                alert("다시 로드해주세요.");
                console.log(e);
            }
        })
    }
</script>

<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">구매내역💰</div>
    <div class="body_container">
        <div class="why" style="margin-bottom: 50px;">
        <div class="orderStTop">
            <div class="orderStN">
                <br>
            </div>
            <div class="orderPt">
                <span>날짜</span>
                <span>상품명</span>
                <span>결제방식</span>
                <span>주문금액</span>
                <span></span>
            </div>
            <div class="orderP" id="orderlist">
            </div>
        </div>
        </div>
        <div class="pagination" id="paging"></div>
    </div>
</div>

