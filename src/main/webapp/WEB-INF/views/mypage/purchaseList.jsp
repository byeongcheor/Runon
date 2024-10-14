<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        height: 900px;
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
</style>
<script>
    setTimeout(function(){
        $.ajax({
            url: "/mypage/viewOrder",
            type: "post",
            data: {
                username: username1,
                usercode: usercode1
            },
            success: function(r){
                var tag ="";
                console.log(r);
                $.each(r.list, function(i,vo){
                    if(vo.order_status=='end'){
                        vo.order_status="주문완료";
                    }else{
                        vo.order_status="주문취소";
                    }

                    tag += `
                        <div class="orderP2">
                            <div class="orderP3">
                                <span>`+vo.created_date+`</span>
                            </div>
                            <div class="orderPd">
                                <div class="orderPdImg">
                                    <div class="orderPdN">
                                        <span>`+vo.marathon_name+`/`+vo.quantity+`</span>
                                    </div>
                                </div>
                            </div>
                            <div class="orderPdP">
                                <span>`+vo.price+`</span>
                            </div>
                            <div class="orderStatus">
                                <span>`+vo.order_status+`</span>
                            </div>
                        </div>
                    `;
                });
                document.getElementById("orderlist").innerHTML = tag;
            },error: function(e){
                alert("실패")
            }
        })
    },1000)
</script>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">구매내역</div>
    <div class="body_container">
        <div class="orderStTop">
            <div class="orderStN">
                <br>
            </div>
            <div class="orderPt">
                <span>날짜</span>
                <span>상품명/옵션</span>
                <span>상품금액</span>
                <span>주문상태</span>
            </div>
            <div class="orderP" id="orderlist">
<%--                <div class="orderP2">--%>
<%--                    <div class="orderP3">--%>
<%--                        <span>2024/09/28</span>--%>
<%--                    </div>--%>
<%--                    <div class="orderPd">--%>
<%--                        <div class="orderPdImg">--%>
<%--                            <div class="orderPdN">--%>
<%--                                <span>2024 3대 마라톤 - 여의도 나이트런</span>--%>
<%--                                <span>5.5Km,티셔츠(L)/1개</span>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="orderPdP">--%>
<%--                        <span>25,000원</span>--%>
<%--                    </div>--%>
<%--                    <div class="orderStatus">--%>
<%--                        <span>주문완료</span>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</div>
