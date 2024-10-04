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
        height: 550px;
        margin-bottom: 10px;
        border-radius: 10px;
    }
    .section2{
        background-color: white;
        height: 340px;
        border-radius: 10px 10px 0 0 ;
    }
    .section_nav{
        padding-top: 10px;
        font-weight: 700;
        font-size: 20px;
        line-height: 20px;
        margin-top: 20px;
        display: flex;
        flex-direction: row;
    }
    .section_nav ul, .section_nav li{
        list-style: none;
        text-decoration: none;
        float: left;
    }
    .section_nav li{
        margin-right: 15px;
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
        margin-left: 10px;
    }
    .crew_infos{
        display: flex;
        flex-direction: row;
        margin-bottom: 20px;
    }
    .crew_imogi{
        font-size: 15pt;
        margin-right: 5px;
    }
    .crew_addr{
        font-weight: 500;
        font-size: 13pt;
    }
    .crew_addr2{
        margin-left: auto;
        max-width: 60%;
        white-space: nowrap;
        font-size: 13pt;
        color: tomato;
    }
    .info_body{
        padding: 30px;
    }
    #editCrewBtn{
        margin-top: 20px;
        background-color: white;
        border-radius: 3px;
        margin-left: 8px;
        border: 1px solid lightgrey;
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
                        <h1>수박런</h1>
                        <p>watermelonrun</p>
                        <p>성별무관/나이무관</p>
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
                <div class="editCrew">
                    <button type="button" id="editCrewBtn">크루정보변경</button>
                </div>
                <div class="statis">
                    <p style="font-weight: 700;">팀원변화</p>
                    <canvas id="line_chart" width="400" height="200"></canvas>
                </div>
            </section>
        </div>
        <div class="content_right">
            <section class="section1">
                <div class="section_nav">
                    <ul>
                        <li>멤버</li>
                        <li>공지</li>
                        <li>크루관리<li>
                    </ul>
                </div>
                //여기에 비동기
            </section>
            <section class="section2">
                <div class="section_title">크루정보</div>
                <div class="info_body">
                    <div class="crew_infos">
                        <span class="crew_imogi">📍</span>
                        <span class="crew_addr">활동지역</span>
                        <span class="crew_addr2">서울시 성동구</span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🏃‍</span>
                        <span class="crew_addr">️멤버수</span>
                        <span class="crew_addr2">4명</span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🔍‍</span>
                        <span class="crew_addr">평균나이</span>
                        <span class="crew_addr2">27.2세</span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">✨</span>
                        <span class="crew_addr">크루생성일</span>
                        <span class="crew_addr2">2024-10-04</span>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>