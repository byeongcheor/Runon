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
        padding-top: 50px; /* 헤더 아래에 충분한 공간 */
        padding-left: 30px; /* 사이드바와의 간격 */
        box-sizing: border-box;
    }

    /* 중앙 메인 콘텐츠 */
    .main-content {
        width: 70%;
        display: flex;
        align-items: center;
        flex-direction: column;
        margin-left:40px;
    }

    /* 프로필 박스 컨테이너 */
    .profile-container {
        margin: 30px 0;
        width: 75%;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-gap: 40px;
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

    #profile_img {
        width: 100px;
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 10px;/*동그라미 태두리*/
        padding: 12px;
        background-color: #333;
        border-radius: 50%;
    }

    #profile_img img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
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
        margin: 30px 0;
        margin-bottom:50px;
    }
.select-box-container {
        margin-top: 10px;
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
        width: 140px;
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

    /* 랭킹 */
    .ranking-container {
        position: -webkit-sticky; /* 사파리 브라우저 대응 */
        position: sticky;
        top: 100px; /* 헤더 아래로 100px 고정 */
        z-index: 20; /* chatbox보다 높은 z-index로 설정 */
        margin-right: 10px; /* chatbox와의 간격 유지 */
    }
    .ranking {
        top: 100px;
        width: 300px;
        background-color: #1e1e1e;
        color: #fff;
        margin: 15px 0;
        margin-right:230px;
        padding: 10px 20px;
        border-radius: 10px;
        max-height: 210px;
        overflow-y: auto; /* 넘칠 경우 스크롤 표시 */
    }

    .ranking::-webkit-scrollbar {
        width: 8px;
        margin-top: 10px;
    }

    .ranking::-webkit-scrollbar-thumb {
        background-color: #899cb5;
        border-radius: 10px;
    }

    .ranking::-webkit-scrollbar-thumb:hover {
        background-color: #555;
    }
    .ranking .menu-title {
        position: sticky; /* 스크롤에 따라 고정되게 설정 */
        top: 0; /* 상단에 고정 */
        background-color: #1e1e1e; /* 배경색 고정 */
        z-index: 100; /* 다른 요소보다 위에 있도록 설정 */
        padding: 10px 10px; /* select-box와 동일한 패딩 */
        margin-bottom: 5px;
        margin-top: 15px;
        font-size: 16px; /* select-box와 동일한 텍스트 크기 */
        font-weight: 500; /* select-box와 동일한 텍스트 굵기 */
        text-align: center;
        color: white; /* select-box와 동일한 텍스트 색상 */
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.5);
        border: 1px solid #fff; /* select-box와 동일한 테두리 */
        border-radius: 10px; /* select-box와 동일한 둥근 모서리 */
    }
    .ranking ul {
        list-style: none;
        padding: 0;
    }

    .ranking ul li {
        padding: 5px 5px;
        cursor: pointer;
        color: white;
        transition: 0.3s;
        margin-left: 15px;
    }

    .ranking ul li:hover {
        background-color: #2e2e2e;
        color: #CCFF47;
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
    }
    .profile-img {
        width: 40px;
        height: 40px;
        border-radius: 50%; /* 이미지를 둥글게 */


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

    .rank-details {
        display: flex;
        align-items: center; /* 세로 정렬을 맞추기 위해 사용 */
    }

    .runkm {
        font-size: 12px;
        color: #ff4d4d;
    }

    .crew-name {
        font-size: 12px;
        color: #CCFF47;
        margin-left: 10px; /* .runkm 옆에 배치 */
    }
    .more {
        margin-top: 10px;
        text-align: center;
        font-size: 14px;
        cursor: pointer;
        color: #00bfff;
    }


    /* 오른쪽 채팅창 */
    .chatbox {
        width: 380px;
        height: 600px;
        background-color: #1e1e1e;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 10px;
        border-radius: 10px;
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
        margin-bottom: 10px; /* 하단에 10px 간격 추가 */
    }
    .chatbox::-webkit-scrollbar-thumb {
        background-color: #fcf6f6; /* 스크롤바 색상 */
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
        margin: 0 15px;
        margin-left:20px;
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

        .ranking {
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
<body>
    <div id="bannerBox">
        <img src="/img/메이트베너.jpg" id="bannerImg"/>
    </div>
    <div class="layout">
            <!-- 중앙 메인 콘텐츠 -->
            <div class="main-content">
                <!-- 필터 -->
                <div class="select-section">
                    <div class="select-box-container">
                        <div class="select-box" id="marathonSelect">
                            <span>내 대회 <span style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;width: 80px;">&nbsp;▼</span>
                            <ul class="dropdown-menu options-list">
                            </ul>
                        </div>
                        <div class="select-box" id="ageSelect">
                            나이 <span>&nbsp;▼</span>
                            <ul class="dropdown-menu options-list">
                                <li data-value="10">10대</li>
                                <li data-value="20">20대</li>
                                <li data-value="30">30대</li>
                                <li data-value="40">40대 이상</li>
                                <li data-value="All">모든 나이</li>
                            </ul>
                        </div>
                        <div class="select-box" id="genderSelect">
                            성별 <span>&nbsp;▼</span>
                            <ul class="dropdown-menu options-list">
                                <li data-value="M">남성</li>
                                <li data-value="F">여성</li>
                                <li data-value="All">모두</li>
                            </ul>
                        </div>
                        <div class="select-box" id="participationCountSelect">
                           참가횟수 <span>&nbsp;▼</span>
                           <ul class="dropdown-menu options-list">
                               <li data-value="1">1~5</li>
                               <li data-value="6">6~10</li>
                               <li data-value="11">11~15</li>
                               <li data-value="16">15회 이상</li>
                           </ul>
                        </div>
                        <div class="select-box" id="mateCountSelect">
                            메이트인원 <span>&nbsp;▼</span>
                            <ul class="dropdown-menu options-list">
                                <li data-value="2">1명</li>
                                <li data-value="3">2명</li>
                                <li data-value="4">3명</li>
                                <li data-value="5">4명</li>
                                <li data-value="6">5명</li>
                                <li data-value="7">6명</li>
                                <li data-value="8">7명</li>
                                <li data-value="9">8명</li>
                                <li data-value="10">9명</li>
                                <li data-value="11">10명</li>
                                <li data-value="12">11명</li>
                                <li data-value="13">12명</li>
                                <li data-value="14">13명</li>
                                <li data-value="15">14명</li>
                                <li data-value="16">15명</li>
                                <li data-value="17">16명</li>
                            </ul>
                        </div>
                        <button class="search_match" id="matching" onclick="matching();">&nbsp;매칭하기&nbsp;</button>
                        <button class="search_match" id="accept" onclick="accept();">&nbsp;수락하기&nbsp;</button>
                        <button class="search_match" id="out" onclick="match_out();">&nbsp;나가기&nbsp;</button>
                    </div>
                </div>
                <div class="profile-container"></div>
            </div>        <!-- 랭킹 -->
            <div class="ranking-container">
            <div class="ranking">
                <div style="margin-top: 5px;">
                <div class="menu-title">랭킹</div>
                <ul class="rank-list">
                    <c:forEach var="rank" items="${ranking}">
                        <li>
                            <span class="grade" id="grade">${rank.ranking}등</span>
                            <img src="/img/${rank.profile_img}" alt="프로필 이미지" class="profile-img">
                            <div class="rank-info">
                                <span class="rank-name">${rank.nickname}</span>
                                <div class="rank-details">
                                        <span class="runkm">${rank.point_code}</span>
                                        <span class="crew_name">${rank.crew_name}</span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="more" id="more" onclick="add();">더보기</div>
            </div>
            </div>
            <!-- 오른쪽 채팅창 -->
            <div class="chatbox">
                <div class="chat-messages">
                    <div class="chat-message">
                        <img src="/img/man0.png" alt="프로필 이미지" class="profile-img">
                        <div class="message-info">
                            <span class="nickname">아카네</span>
                            <p>안녕하세요</p>
                        </div>
                    </div>
                    <div class="chat-message">
                        <img src="/img/woman0.png" alt="프로필 이미지" class="profile-img">
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
    </div>
</body>
<script>
var clog = console.log;
var match_yn, now_personnel, new_personnel;
var more =0;


$(document).ready(function() {
    match_yn();//매칭여부
    marathon_code();//내가 결제한 대회리스트 불러오기
    setTimeout(function() {
        if(match_yn>0)match_view(match_yn)
        else start_view();
    }, 100);
    var intervalId = setInterval(function() {
        match_view(match_yn);
    }, 2000);

    // 드롭다운을 토글하는 함수
    function toggleDropdown(box) {
        $('.select-box').not(box).removeClass('active'); // 다른 드롭다운을 비활성화
        $(box).toggleClass('active'); // 클릭한 드롭다운을 활성화/비활성화
    }

    // 옵션을 선택하는 함수
    function selectOption(li, box) {
        var selectedText = $(li).text(); // li의 텍스트를 가져옴
        $(box).find('span').text(' : '+selectedText); // 선택된 텍스트로 span 업데이트
        $(box).removeClass('active'); // 드롭다운 닫기

        // 선택된 li에 따라 다른 동작을 수행
        var selectedValue = $(li).data('value'); // data-value 속성 값 가져오기
        $(box).data('selected-value', selectedValue); // 선택된 값을 box의 data 속성에 저장
        $(box).toggleClass('active'); // 클릭한 드롭다운을 활성화/비활성화
    }

    // 페이지가 로드되었을 때 실행
    $('.select-box').each(function() {
        var box = $(this);
        box.find('.dropdown-menu li').on('click', function() {
            selectOption(this, box); // li 선택 시 텍스트를 업데이트
        });

        // 드롭다운 토글
        box.on('click', function() {
            toggleDropdown(this);
        });
    });
});
    function match_yn(){
        $.ajax({
          url:'/mate/match_yn',
          type:'post',
          async: false,
          success:function(result){
            match_yn=result;
          },
          error:function(e){
          }
       });
    }

    function match_view(matching_room_code){
        $.ajax({
          url:'/mate/match_view',
          type:'post',
          async: false,
          data:{
           matching_room_code:matching_room_code
          },
          success:function(result){
               var list = '';
               var length = result[0].buff_n;
               var remainder = length % 4;
               if (remainder !== 0) {
                   length += 4 - remainder;
                   length = length<8? 8:length;
               }
               length=length-result.length;
               for (var i in result) {
                   if(result[i].a_s!=='Y') var style =""
                   else var style ="transform: scale(1.05);border-color: #CCFF47;";
                   list+='<div class="profile-box" onclick="profile_update();" style="'+style+'">';
                   list+='<div id="profile_img">';
                   list+='<img src="/img/woman0.png" alt="프로필 1 이미지">';
                   list+='</div>';
                   list+='<span class="rank-name">'+result[i].nickname+'</span>';
                   list+='<span class="runkm">'+result[i].tbuf_n+'Km</span>';
                   list+='<span class="crew_name">'+result[i].crew_name+'</span>';
                   list+='</div>';
               }
               for (var i=0; i<length; i++) {
                   list+='<div class="profile-box">';
                   list+='<div id="profile_img">';
                   list+='<img src="/img/woman0.png" alt="프로필 1 이미지">';
                   list+='</div>';
                   list+='<span class="rank-name">&nbsp; </span>';
                   list+='<span class="runkm">&nbsp;</span>';
                   list+='<span class="crew_name">&nbsp;</span>';
                   list+='</div>';
               }
               $('.profile-container').empty();
               $('.profile-container').append(list);
               $('#matching').hide();
               $('#accept').show();
               $('#out').show();
          },
          error:function(e){
          }
       });
    }

    function add(){
           more +=5;
           $.ajax({
              url:'/mate/more',
              type:'post',
              async: false,
              data:{
                 more:more
              },success:function(result){
                var list='';
                for (var i in result) {
                    list+='<li>';
                    list+='<span class="grade" id="grade">'+result[i].ranking+'등</span>';
                    list+='<img src="/img/'+result[i].profile_img+'" alt="프로필 이미지" class="profile-img">';
                    list+='<div class="rank-info">';
                    list+='<span class="rank-name">'+result[i].nickname+'</span>';
                    list+='<span class="runkm">'+result[i].point_code+'</span>';
                    list+='<span class="crew_name">'+result[i].crew_name+'</span>';
                    list+='</div>';
                    list+='</li>';
                }
                $('.rank-list').append(list);
              },
              error:function(e){

              }
           });
    }
    function profile_update() {
                // 팝업 창의 너비와 높이 설정
                var width = 920;
                var height = 850;

                // 현재 화면의 중앙에 팝업을 배치하기 위한 계산
                var screenLeft = (window.screen.width - width) / 2;   // 가로 중앙
                var screenTop = (window.screen.height - height) / 2;  // 세로 중앙

                // 팝업 창을 화면 중앙에 크기 고정으로 엽니다.
                window.open('/mate/profileList', 'ProfileList',
                'width=' + width + ',height=' + height + ',top=' + screenTop + ',left=' + screenLeft + ',resizable=no,scrollbars=no,menubar=no,status=no,toolbar=no');

    }

    function matching() {
            var marathonValue = $('#marathonSelect').data('selected-value');
            var ageValue = $('#ageSelect').data('selected-value');
            var genderValue = $('#genderSelect').data('selected-value');
            var participationCountValue = $('#participationCountSelect').data('selected-value');
            var mateCountValue = $('#mateCountSelect').data('selected-value');
            $.ajax({
                  url:'/mate/matching',
                  type:'post',
                  async: false,
                  data:{
                      marathonValue:marathonValue,
                      ageValue:ageValue,
                      genderValue:genderValue,
                      participationCountValue:participationCountValue,
                      mateCountValue:mateCountValue
                   },success:function(result){
                       var list = '';
                       var length = result[0].buff_n;
                       var remainder = length % 4;
                       if (remainder !== 0) {
                           length += 4 - remainder;
                           length = length<8? 8:length;
                       }
                       length=length-result.length;
                       for (var i in result) {
                           list+='<div class="profile-box">';
                           list+='<div id="profile_img">';
                           list+='<img src="/img/woman0.png" alt="프로필 1 이미지">';
                           list+='</div>';
                           list+='<span class="rank-name">'+result[i].nickname+'</span>';
                           list+='<span class="runkm">'+result[i].tbuf_n+'Km</span>';
                           list+='<span class="crew_name">'+result[i].crew_name+'</span>';
                           list+='</div>';
                       }
                       for (var i=0; i<length; i++) {
                           list+='<div class="profile-box">';
                           list+='<div id="profile_img">';
                           list+='<img src="/img/woman0.png" alt="프로필 1 이미지">';
                           list+='</div>';
                           list+='<span class="rank-name">&nbsp; </span>';
                           list+='<span class="runkm">&nbsp;</span>';
                           list+='<span class="crew_name">&nbsp;</span>';
                           list+='</div>';
                       }
                       $('.profile-container').empty();
                       $('.profile-container').append(list);
                       $('#matching').hide();
                       $('#accept').show();
                       $('#out').show();

                   },
                     error:function(e){
              }
            });
        }
    function start_view() {
        var list = '';
       $('.profile-container').empty();
        $('#matching').show();
        $('#accept').hide();
        $('#out').hide();
        for (var i=0; i<8; i++) {
            list+='<div class="profile-box">';
            list+='<div id="profile_img">';
            list+='<img src="/img/woman0.png" alt="프로필 1 이미지">';
            list+='</div>';
            list+='<span class="rank-name">&nbsp; </span>';
            list+='<span class="runkm">&nbsp;</span>';
            list+='<span class="crew_name">&nbsp;</span>';
            list+='</div>';
        }
        $('.profile-container').append(list);
    }
    function marathon_code(){
            $.ajax({
              url:'/mate/marathon_code',
              type:'post',
              async: false,
              success:function(result){
                  var list='';
                  for(var i in result){
                      list+='<li class="marathon_code" data-value='+result[i].marathon_code+'>'+result[i].marathon_name+'</li>';
                  }
                  $('.options-list').append(list);
              },
              error:function(e){
              }
           });
    }



function match_out(){
        $.ajax({
          url:'/mate/match_out',
          type:'post',
          async: false,
          data:{
           matching_room_code:match_yn
          },
          success:function(result){
               match_yn=0;
               start_view();
          },
          error:function(e){
          }
       });
}

function accept(){
        $.ajax({
          url:'/mate/accept',
          type:'post',
          async: false,
          data:{
           matching_room_code:match_yn
          },
          success:function(result){
          },
          error:function(e){
          }
       });
}
</script>