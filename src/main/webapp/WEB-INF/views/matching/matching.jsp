<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/slick.css" type="text/css">
<link rel="stylesheet" href="/css/slick-theme.css" type="text/css">
<link rel="stylesheet" href="/css/main.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/slick.min.js"></script>
</head>

<style>
     .section4 {
         width: 70%; /* 메인 컨텐츠를 차지할 너비 */
         margin-left:30px;
     }
    .section4 #inner1 {
        background-color: #f1f3f5;
        border-radius: 30px 30px 0 0;
        width: 100%;
        height: 80px;
    }

    .section4 #inner2 {
        width: 100%;
        height: 800px;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .select-box-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        align-items: center;
        margin: 30px 0;
    }

     .select-box {
         position: relative;
         display: flex;
         align-items: center;
         padding: 10px 20px;
         border: 1px solid #dcdcdc;
         border-radius: 30px;  /* 셀렉트 박스 테두리 둥글기 */
         background-color: #f8f8f8;
         color: #8b8b8b;
         font-size: 14px;
         cursor: pointer;
         width: 100px;
         text-align: center;
     }

    .select-box.active {
        border-color: #121212;  /* 검은색 테두리 */
        background: rgba(18, 18, 18, 0.8);
        color: #f1f3f5;  /* 흰색 텍스트 */
    }

    .select-box img {
        width: 20px;
        height: 20px;
        margin-right: 5px;
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background: rgba(18, 18, 18, 0.8);
        border: 1px solid #dcdcdc;
        border-radius: 30px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        list-style: none;
        padding: 0;
        margin-top: 5px;
        width: 100%;
        z-index: 1000;
    }

    .dropdown-menu li {
        padding: 10px;
        cursor: pointer;
        border-bottom: none;
    }


     .dropdown-menu li:hover {
        background-color: transparent;
        color: #CCFF47;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
        transition: color 0.3s ease, font-size 0.3s ease;
     }

     .select-box.active .dropdown-menu {
         display: block;
     }

     .search_match {
        position: relative;
         display: flex;
         align-items: center;
         justify-content: center;
         padding: 10px 20px;
         border: 2px solid #dcdcdc;
         border-radius: 30px;  /* 셀렉트 박스 테두리 둥글기 */
         background-color: #f8f8f8;
         color: #8b8b8b;
         font-size: 14px;
         cursor: pointer;
         width: 120px;
         text-align: center;
    }

    .search_match:hover {
        background: rgba(18, 18, 18, 0.8);
        color: #f1f3f5;
        transition: 0.5s ease-out;
    }

    .main-layout {
        display: flex;
        flex-direction: column; /* 세로로 배치 */
        align-items: flex-start;
        padding: 20px;
        width: 100%; /* 전체 화면 너비 차지 */
    }

    #hitmarathon {
        display: flex;
        flex-wrap: wrap; /* 포스터를 여러 줄로 배치 */
        gap: 15px; /* 포스터 간격 */
        justify-content: flex-start;
        margin-top: 20px; /* 셀렉트 박스 아래 */
        width: 100%; /* 포스터 영역 너비 */
    }

    #hit_poster {
        width: 20%; /* 포스터 크기 설정 */
        margin-bottom: 20px;
        background-color: #f9f9f9;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
        border-radius: 10px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 0px;
        text-align: center;
    }

    #poster_img {
        width: 100px;
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 5px;/*동그라미 태두리*/
    }

    #poster_img > img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .poster-info {
        display: flex;
        flex-direction: column;
        align-items: center; /* 텍스트가 이미지 아래 중앙에 위치 */
    }
    .poster-info div {
    margin-top: 5px; /* 텍스트 간의 간격 */
    }
    .poster-content {
        display: flex;
        align-items: center; /* 이미지와 텍스트가 세로로 중앙 정렬되도록 */
        background-color: #f9f9f9; /* 배경색 */
        box-shadow: 0 0 5px rgba(0,0,0,0.1); /* 그림자 추가 */
        border-radius: 100%; /* 둥근 모서리 */
    }

    /* 랭킹 영역 */
    #ranking {
        width: 25%; /* 랭킹 섹션 */
        margin-top: 100px; /* 헤더 아래에 위치 */
        background-color: #f1f1f1;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        max-height: 950px; /* 스크롤이 생길 수 있도록 최대 높이 설정 */
        overflow-y: auto; /* 세로 스크롤 활성화 */
        position: fixed; /* 화면의 오른쪽에 고정 */
        right: 0;
        top: 0;
    }

    #ranking h2 {
        text-align: center;
    }

    #ranking ol {
        list-style: none;
        padding-left: 0;
    }

    #ranking ol li {
        margin-bottom: 15px;
    }

    .rank-item {
        display: flex;
        align-items: center;
        padding: 10px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
    }

    .rank-item img {
        width: 50px;
        height: 50px;
        border-radius: 50%; /* 둥근 프로필 이미지 */
        margin-right: 10px;
        object-fit: cover;
    }

    .rank-info {
        display: flex;
        flex-direction: column;
    }

    .rank-info .nickname {
        font-weight: bold;
        font-size: 16px;
    }

    .rank-info .distance {
        font-size: 14px;
        color: #666;
    }

    #outer1 {
        background-color: #f1f3f5;
    }

    #inner3 {
        background-color: #CCFF47;
        border-radius: 30px 30px 0 0;
        width: 100%;
        height: 80px;
    }

    #inner4 {
        background-color: #CCFF47;
        width: 100%;
        height: 900px;
        text-align: center;
    }

    #inner4 h1 {
        margin: 0;
        padding: 0;
        font-size: 45pt;
    }

    #inner4 p {
        font-size: 20pt;
        padding-bottom: 20px;
    }

    #outer2 {
        background-color: #CCFF47;
    }

    #more2 {
        border-radius: 50px;
        font-size: 15pt;
        font-weight: bold;
        padding: 5px;
        margin-bottom: 80px;
        border: 2px solid #121212;
        line-height: 50px;
        color: #121212;
    }

    #more2:hover {
        background-color: #121212;
        color: #f1f3f5;
        transition: 0.5s ease-out;
    }
</style>

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

<body>
    <div class="section4">
        <div id="inner1"></div> <!-- 상단 빈 공간, 필요하다면 콘텐츠 추가 -->

        <div id="inner2">
            <!-- 메인 레이아웃 컨테이너 -->
            <div class="main-layout">
                <!-- 셀렉트 박스 영역 -->
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
                    <div class="select-box" onclick="toggleDropdown(this)">
                        메이트인원 <span>&nbsp;▼</span>
                        <ul class="dropdown-menu">
                            <li>1명</li>
                            <li>2명</li>
                            <li>3명</li>
                            <li>4명</li>
                            <li>5명</li>
                            <li>6명</li>
                            <li>7명</li>
                            <li>8명</li>
                            <li>9명</li>
                            <li>10명</li>
                            <li>11명</li>
                            <li>12명</li>
                            <li>13명</li>
                            <li>14명</li>
                            <li>15명</li>
                        </ul>
                    </div>
                    <button class="search_match">&nbsp;매칭하기&nbsp;</button>
                </div>

                <div id="hitmarathon">
                    <!-- 포스터 1 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/man.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 2 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/man.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 3 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/woman.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 4 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/man.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 5 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/woman.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 6 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/man.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 7 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/woman.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                    <!-- 포스터 8 -->
                    <div id="hit_poster">
                        <div class="poster-content">
                            <div id="poster_img">
                                <img src="/img/woman.png" alt="포스터 이미지">
                            </div>
                        </div>
                        <div class="poster-info">
                            <div>📍전국 어디서나</div>
                            <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
                        </div>
                    </div>
                </div>
            </div>

             <!-- 랭킹 섹션 -->
             <div id="ranking">
                <h2>랭킹</h2>
                <ol>
                    <li>
                        <div class="rank-item">
                            <img src="/img/profile1.jpg" alt="프로필 이미지">
                            <div class="rank-info">
                                <span class="nickname">사용자 A</span>
                                <span class="distance">15km</span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="rank-item">
                            <img src="/img/profile2.jpg" alt="프로필 이미지">
                            <div class="rank-info">
                                <span class="nickname">사용자 B</span>
                                <span class="distance">13.5km</span>
                            </div>
                        </div>
                    </li>
                    <!-- 10위까지 항목 추가 -->
                </ol>
            </div>
        </div>
    </div>
</body>
