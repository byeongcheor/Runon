<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    window.onload = function(){
         function getLastSixMonths() {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                const result = [];
                const today = new Date();
                const currentMonth = today.getMonth();

                // 최근 6개월의 월 계산
                for (let i = 5; i >= 0; i--) {
                    const monthIndex = (currentMonth - i + 12) % 12;
                    result.push(months[monthIndex]);
                }
                return result;
         }
            const data = {
                labels: getLastSixMonths(),
                datasets: [{
                label: 'Line Chart',
                data: [0, 0, 0, 0, 12, 0],
                fill: false,
                borderColor: 'tomato',
                tension: 0.1
                }]
            };
            const config = {
                type: 'line',
                data: data,
            };
            new Chart(document.getElementById("line_chart"),config);
    }

</script>
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

    .content_body{
        display: flex;
        flex-direction: row;
        max-width: 1024px;
        margin: 0 auto;
    }
    .content_left{
        position: relative;
        width: 60%;
        margin-right: 20px;
        background-color: white;
        height: 900px;
        margin-top: 20px;
        border-radius: 10px 10px 0 0 ;
    }
    .content_right{
        width: 100%;
    }
    .section1{
        background-color: white;
        height: 370px;
        margin-bottom: 10px;
        border-radius: 10px;
    }
    .section2{
        background-color: white;
        height: 520px;
        border-radius: 10px 10px 0 0 ;
    }
    .section_title{
        padding: 20px;
        padding-top: 30px;
        font-weight: 700;
        font-size: 20px;
        line-height: 20px;
        margin-top: 20px;
        margin-left: 10px;
    }
    .menu_list{
        list-style: none;
    }
    .menu_list li{
        font-size: 18px;
        list-style: none;
    }
    .menu_list li a{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        text-decoration: none;
        cursor: pointer;
        align-items: center;
    }
    .menu_list li a:link, .menu_list li a:visited{
        list-style: none;
        text-decoration: none;
        color: #121212;
    }
    .menu_list li a:hover{
        font-weight: 500;
        color: #121212;
    }
    .list_container{
        display: flex;
        flex-direction: row;
        align-items: center;
    }
    .icons{
        font-size: 25px;
        margin: 0;
    }
    .list_title{
        margin-left: 15px;
    }
    .section3{
        padding: 20px;
    }
    .profile_container{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }
    .imgContainer{
        width: 80px;
        height: 80px;
        border-radius: 200px;
        margin-top: 10px;
        margin-right: 40px;
    }
    .imgContainer>img:first-child{
        width: 100%;
        height: 100%;
        border-radius: 200px;
        object-fit: cover;
    }
    .editIcon{
        width: 20px;
        height: 20px;
        position: absolute;
        top: 3%;
        right: 10%;
        opacity: 0.5;
    }
    .mystatus{
        padding-top: 20px;
        width: 100%;
        margin-top: 20px;
    }
    .status_items:first-child{
        float: left;
        margin-right: 20px;
        margin-left: 5px;
    }
    .status_items{
        width: 45%;
        background-color: #F8FAFB;
        border-radius: 10px;
        float: left;
        list-style: none;
    }
    .status_label{
        padding-left: 20px;
    }
    .status_label>p:first-child{
        font-weight: 700;
    }
    .statis{
        margin-top: 150px;
    }
    .names{
        margin-left: 5px;
    }
</style>
<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg"/>
    </div>
    <div class="content_body">
        <div class="content_left">
            <section class="section3">
                <div class="profile_container">
                    <div class="names">
                        <h1>김영현</h1>
                        <p>neoneon0518@naver.com</p>
                    </div>
                    <div class="profileimage">
                        <div class="imgContainer">
                            <img src="/crewProfile/crewlogo3.png">
                        </div>
                        <a href="">
                            <img src="/img/EditIcon.png" class="editIcon">
                        </a>
                    </div>
                </div>
                <div class="mystatus">
                    <li class="status_items">
                        <div class="status_label">
                            <p>나의 랭킹🏃‍♀️</p>
                            <p>123위</p>
                        </div>
                    </li>
                    <li class="status_items">
                        <div class="status_label">
                            <p>나의 포인트🪙</p>
                            <p>10,000</p>
                        </div>
                    </li>
                </div>
                <div class="statis">
                    <p style="font-weight: 700;">최근 내가 뛴 km</p>
                    <canvas id="line_chart" width="400" height="200"></canvas>
                </div>
            </section>
        </div>
        <div class="content_right">
            <section class="section1">
                <div class="section_title">나의 런온</div>
                <div class="section_menu">
                    <ul class="menu_list">
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">💰</p>
                                    <p class="list_title">구매내역</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">📜</p>
                                    <p class="list_title">마라톤 신청서</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">✍️</p>
                                    <p class="list_title">내 기록 인증하기</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">🤼‍♂️</p>
                                    <p class="list_title">나의 메이트</p>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="section2">
                <div class="section_title">설정</div>
                <div class="section_menu">
                    <ul class="menu_list">
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">❓</p>
                                    <p class="list_title">내 QnA</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">💳</p>
                                    <p class="list_title">결제수단추가</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">⚙️</p>
                                    <p class="list_title">회원정보 수정</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div class="list_container">
                                    <p class="icons">😥</p>
                                    <p class="list_title" style="color: tomato;">회원탈퇴</p>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </section>
        </div>
    </div>
</div>