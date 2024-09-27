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
body {
        margin: 0;
        padding: 0;
        font-family: "Noto Sans KR", sans-serif;
        background-color: #121212;
        color: white;
    }

    #bannerBox{
        width:100%;
        height:400px;
        margin: 0 auto;
    }
    #bannerImg{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    /* 전체 레이아웃 */
    .layout {
        display: flex;
        justify-content: space-between;
        padding-top: 80px; /* 헤더 아래에 충분한 공간 */
        padding-left: 20px; /* 사이드바와의 간격 */
        padding-right: 20px; /* 채팅창과의 간격 */
        box-sizing: border-box;
    }
    /* 왼쪽 사이드바 */
    .sidebar {
        position: sticky;
        top: 100px;
        width: 250px;
        background-color: #1e1e1e;
        color: #fff;
        padding: 10px;
        border-radius: 10px;
        z-index: 1000;
        margin-left: 40px;
        max-height: 600px;
        overflow-y: auto; /* 넘칠 경우 스크롤 표시 */
        flex-direction: column;
        justify-content: space-between;
        z-index: 1000;
        position: -webkit-sticky; /* 사파리 브라우저 대응 */
        position: sticky;
        top: 100px; /* 해더 아래로 100px 고정 */
        z-index: 10;
    }

    .sidebar::-webkit-scrollbar {
        width: 6px; /* 스크롤바 너비 */
    }
    .sidebar::-webkit-scrollbar-thumb {
        background-color: #888; /* 스크롤바 색상 */
        border-radius: 10px;
    }
    .sidebar::-webkit-scrollbar-thumb:hover {
        background-color: #555;
    }
    .sidebar .menu-title {
        font-size: 16px;
        margin-bottom: 15px;
    }

    .sidebar ul {
        list-style: none;
        padding: 0;
    }

    .sidebar ul li {
        padding: 10px 5px;
        cursor: pointer;
        color: white;
        transition: 0.3s;
    }

    .sidebar ul li:hover {
        background-color: #2e2e2e;
        color: #CCFF47;
    }


    .menu-title {
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .rank-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .rank-list li {
        display: flex;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #444;
    }
    .profile-img {
        width: 40px;
        height: 40px;
        border-radius: 50%; /* 이미지를 둥글게 */
        margin-right: 10px;
    }


    .rank-list li:hover .profile-img {
        border-color: #CCFF47; /* 마우스 오버 시 연두색 테두리 */
        box-shadow: 0 0 8px #CCFF47; /* 마우스 오버 시 부각되는 효과 */
    }
    .rank-info {
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .rank-name {
        font-size: 14px;
        font-weight: bold;
    }

    .runkm {
        font-size: 12px;
        color: #ff4d4d;
    }

    .more {
        margin-top: 10px;
        text-align: center;
        font-size: 14px;
        cursor: pointer;
        color: #00bfff;
    }

    /* 중앙 메인 콘텐츠 */
    .main-content {
        width: 60%;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin:0;
    }

    /* 프로필 박스 컨테이너 */
    .profile-container {
        width: 80%;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-gap: 20px;
    }

    /* 개별 프로필 박스 */
    .profile-box {
        background-color: #1e1e1e;
        border: 2px solid #333;
        border-radius: 10px;
        padding: 20px;
        text-align: center;
        transition: transform 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;  /* 중앙 정렬 */
    }


    .profile-box:hover {
        transform: scale(1.05);
        border-color: #CCFF47;
    }

    .profile-box img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
    }

    #profile_img {
        width: 100px;
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 5px;/*동그라미 태두리*/
    }

    #profile_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    }


    .profile-box p {
        margin: 5px 0;
    }

   /* 셀렉트박스 섹션 */
    .select-section {
        display: flex;
        gap: 5px;  /* 셀렉트 박스 간격을 줄임 */
        justify-content: center;  /* 가운데 정렬 */
        align-items: center;
        margin: 35px 0;
        margin-bottom:55px;
    }
   .select-box-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;  /* 간격을 조금 줄임 */
    }

    .select-box {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;  /* 텍스트 중간 정렬 */
        padding: 10px 10px;
        border: 1px solid #fff;  /* 헤더의 메뉴와 같은 테두리 색상 */
        border-radius: 10px;
        background-color: #1e1e1e;
        color: white;  /* 헤더 메뉴 텍스트 색상 */
        font-size: 16px;  /* 헤더 메뉴와 동일한 텍스트 크기 */
        font-weight: 500;  /* 헤더 메뉴와 동일한 굵기 */
        cursor: pointer;
        width: 150px;
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

    /* 오른쪽 채팅창 */
    .chatbox {
         width: 380px;
         background-color: #1e1e1e;
         display: flex;
         flex-direction: column;
         justify-content: space-between;
         padding: 10px;
         border-radius: 10px;
         z-index: 1000;
         margin-right: 20px;
         max-height: 600px; /* 원하는 고정된 높이로 변경 */
         overflow-y: auto; /* 넘칠 경우 스크롤 표시 */
         position: -webkit-sticky; /* 사파리 브라우저 대응 */
         position: sticky;
         top: 100px; /* 해더 아래로 100px 고정 */
         z-index: 10;
    }
    .chatbox::-webkit-scrollbar {
        width: 6px;
    }
    .chatbox::-webkit-scrollbar-thumb {
        background-color: #888;
        border-radius: 10px;
    }
    .chatbox::-webkit-scrollbar-thumb:hover {
        background-color: #555;
    }
    .chat-message {
        display: flex;
        align-items: flex-start; /* 프로필과 텍스트 정렬 */
        margin-bottom: 5px; /* 각 메시지 간의 간격을 줄임 */
    }
    .chatbox .chat-messages {
        flex-grow: 1;
        padding: 10px;
        color: white;
        overflow-y: auto;
    }

    .chat-message p {
        margin: 0;
        padding: 10px;
        background-color: #333;
        border-radius: 10px;
        max-width: 80%;
        word-wrap: break-word;
    }

    .chatbox .chat-input {
        display: flex;
        padding: 10px;
        background-color: #2e2e2e;
    }

    .chatbox .chat-input input {
        flex-grow: 1;
        padding: 10px;
        border: none;
        border-radius: 5px;
        margin-right: 10px;
    }
    .profile-img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
    }

    .message-info {
        display: flex;
        flex-direction: column;
    }

    .nickname {
        font-weight: bold;
        font-size: 14px;
        margin-bottom: 2px;
    }


    .chatbox .chat-input button {
        padding: 10px 20px;
        background-color: #CCFF47;
        border: 2px solid #fff;
        border-radius: 10px;
        color: black;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    .chatbox .chat-input button:hover {
        background-color: black;
        color: white;
    }


    @media screen and (max-width: 768px) {
        .layout {
            flex-direction: column;
            padding: 20px;
        }

        .sidebar {
            width: 100%;
            margin-bottom: 20px;
        }

        .main-content {
            width: 100%;
        }

        .chatbox {
            width: 100%;
        }
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
    <div id="bannerBox">
        <img src="/img/메이트베너.jpg" id="bannerImg"/>
    </div>
   <div class="layout">
           <!-- 왼쪽 사이드바 -->
           <div class="sidebar">
               <div class="menu-title">랭킹</div>
               <ul class="rank-list">
                   <li>
                       <img src="/img/profile1.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="rank-info">
                           <span class="rank-name">아카네</span>
                           <span class="runkm">2,442</span>
                       </div>
                   </li>
                   <li>
                       <img src="/img/profile1.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="rank-info">
                           <span class="rank-name">쿠하</span>
                           <span class="runkm">243</span>
                       </div>
                   </li>
                   <li>
                       <img src="/img/profile1.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="rank-info">
                           <span class="rank-name">하니</span>
                           <span class="runkm">160</span>
                       </div>
                   </li>
                   <li>
                       <img src="/img/profile1.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="rank-info">
                           <span class="rank-name"> Soyeoni</span>
                           <span class="runkm">131</span>
                       </div>
                   </li>
                   <li>
                       <img src="/img/profile1.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="rank-info">
                           <span class="rank-name">진수0</span>
                           <span class="runkm">119</span>
                       </div>
                   </li>
               </ul>
               <div class="more">더보기</div>
           </div>

           <!-- 중앙 메인 콘텐츠 -->
           <div class="main-content">

               <!-- 필터 -->
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
               </div>

               <div class="profile-container">
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 1 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 1 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 1 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 2 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 3 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 1 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 1 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                   <div class="profile-box">
                       <div id="profile_img">
                           <img src="/img/woman.png" alt="프로필 1 이미지">
                       </div>
                       <p>사용자 1</p>
                       <p>뭐라뭐라하노</p>
                   </div>
                    <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 1 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 1 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 1 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 2 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 3 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 1 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 1 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>
                      <div class="profile-box">
                          <div id="profile_img">
                              <img src="/img/woman.png" alt="프로필 1 이미지">
                          </div>
                          <p>사용자 1</p>
                          <p>뭐라뭐라하노</p>
                      </div>

               </div>
           </div>

           <!-- 오른쪽 채팅창 -->
           <div class="chatbox">
               <div class="chat-messages">
                   <div class="chat-message">
                       <img src="/img/profile1.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="message-info">
                           <span class="nickname">아카네</span>
                           <p>안녕하세요</p>
                       </div>
                   </div>
                   <div class="chat-message">
                       <img src="/img/profile2.jpg" alt="프로필 이미지" class="profile-img">
                       <div class="message-info">
                           <span class="nickname">쿠하</span>
                           <p>러닝 메이트 구합니다.</p>
                       </div>
                   </div>
               </div>
               <div class="chat-input">
                   <input type="text" placeholder="채팅을 입력해 주세요">
                   <button>전송</button>
               </div>
           </div>
       </div>
</body>
