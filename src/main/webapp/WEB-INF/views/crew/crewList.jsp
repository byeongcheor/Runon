<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/crewList.css" type="text/css">
<script>
    function toggleDropdown(box) {
        const selectBoxes = document.querySelectorAll('.select-box');
        selectBoxes.forEach(b => {
            if (b !== box) {
                b.classList.remove('active');
            }
        });
        box.classList.toggle('active');
    }
</script>
<style>
    /* 셀렉트박스 섹션 */
    .crew_filter{
        width: 50%;
        margin: 0 auto;
    }
    .select-section {
        display: flex;
        gap: 5px;  /* 셀렉트 박스 간격을 줄임 */
        justify-content: flex-start;  /* 가운데 정렬 */
        align-items: center;
        margin: 35px 0;
        margin-bottom:55px;
    }
    .select-box-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;  /* 간격을 조금 줄임 */
        margin-left: 50px;
    }

    .select-box {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;  /* 텍스트 중간 정렬 */
        padding: 10px 10px;
        border: 1px solid grey;  /* 헤더의 메뉴와 같은 테두리 색상 */
        border-radius: 20px;
        color: black;  /* 헤더 메뉴 텍스트 색상 */
        font-size: 16px;  /* 헤더 메뉴와 동일한 텍스트 크기 */
        font-weight: 500;  /* 헤더 메뉴와 동일한 굵기 */
        cursor: pointer;
        width: 100px;
        text-align: center;
        transition: transform 0.3s ease, border-color 0.3s ease;
    }


    .select-box.active {
        border-color: #CCFF47;  /* hover 시 강조 색상 */
        background: rgba(18, 18, 18, 0.8);
        color: white;
    }



    .dropdown-menu {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background: rgba(18, 18, 18, 0.8);
        border: 1px solid #fff;
        border-radius: 10px;
        list-style: none;
        padding: 0;
        margin-top: 5px;
        width: 100%;
        z-index: 1000;
        opacity: 0;
        transform: scaleY(0);
        transform-origin: top;
        transition: transform 0.3s ease, opacity 0.3s ease;
    }

    .dropdown-menu li {
        padding: 10px;
        cursor: pointer;
        border-bottom: none;
        color: white;
        font-size: 16px;  /* 헤더 메뉴와 동일한 텍스트 크기 */
        font-weight: 500;  /* 헤더 메뉴와 동일한 굵기 */
    }


     .dropdown-menu li:hover {
        background-color: transparent;
        color: #CCFF47;
        font-size: 16px;  /* hover 시에도 동일한 크기 */
        font-weight: bold;
        cursor: pointer;
        transition: color 0.3s ease, font-size 0.3s ease;
     }

     .select-box.active .dropdown-menu {
        display: block;
        opacity: 1;
        transform: scaleY(1);
     }
     .select-box:hover {
         transform: scale(1.05);
         border-color: #CCFF47;
     }


     .search_match {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px 20px;
        border: 2px solid #fff;
        border-radius: 10px;
        background-color: #CCFF47;
        color: black;
        font-size: 16px;  /* 헤더 메뉴와 동일한 텍스트 크기 */
        font-weight: bold;  /* 헤더 메뉴와 동일한 굵기 */
        cursor: pointer;
        text-align: center;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .search_match:hover {
        background-color: black;  /* hover 시 배경색 검정 */
        color: white;  /* hover 시 텍스트 색상 흰색 */
    }
</style>
    <div class="container">
        <div id="bannerBox">
            <img src="/img/크루배너.jpg" id="bannerImg"/>
        </div>
        <div id="crew_body">
            <div id="crew_nav">
                <ul>
                    <li><a href="/crew/crewList">크루모집</a></li>
                    <li>크루생성</li>
                    <li>나의크루</li>
                </ul>
            </div>
        </div>
        <div class="crew_filter">
            <div class="select-section">
               <div class="select-box-container">
                   <div class="select-box" onclick="toggleDropdown(this)">
                       내 대회 <span>&nbsp;▼</span>
                       <ul class="dropdown-menu">
                           <li>대회 1</li>
                           <li>대회 2</li>
                           <li>대회 3</li>
                       </ul>
                   </div>
                   <div class="select-box" onclick="toggleDropdown(this)">
                       나이 <span>&nbsp;▼</span>
                       <ul class="dropdown-menu">
                           <li>10대</li>
                           <li>20대</li>
                           <li>30대</li>
                           <li>40대 이상</li>
                           <li>모든 나이</li>
                       </ul>
                   </div>
                   <div class="select-box" onclick="toggleDropdown(this)">
                       성별 <span>&nbsp;▼</span>
                       <ul class="dropdown-menu">
                           <li>남성</li>
                           <li>여성</li>
                           <li>모두</li>
                       </ul>
                   </div>
                   <div class="select-box" onclick="toggleDropdown(this)">
                       참가횟수 <span>&nbsp;▼</span>
                       <ul class="dropdown-menu">
                           <li>1~5</li>
                           <li>6~10</li>
                           <li>11~15</li>
                           <li>15회 이상</li>
                       </ul>
                   </div>
                   <button class="search_match">&nbsp;매칭하기&nbsp;</button>
               </div>
           </div>
        </div>
        <div class="crew_list">
            <div class="list_wrapper">
                <ul>
                    <c:forEach var="i" begin="1" end="8">
                        <li class="list_item">
                            <div class="crew_profileimage">
                                <div class="profileBox">
                                    <img src="/img/a8.png" class="profileImg">
                                </div>
                            </div>
                            <div class="crew_content">
                                <div class="crew_title">
                                    <span class="crewname"><b>말달리자</b></span>
                                    <span class="count">🏃‍♀️8<span>
                                </div>
                                <div class="crew_info">
                                    <span class="crewaddr">서울시 영등포구</span>
                                    <span class="crewIntro">남녀모두 환영합니다. 함께하실 분을 찾습니다.</span>
                                    <span class="crewhit">조회 3,490</span>
                                </div>
                            </div>
                            <div class="recruit">
                                <button class="recruitbtn">가입신청하기</button>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
