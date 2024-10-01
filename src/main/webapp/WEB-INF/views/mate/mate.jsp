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
<link rel="stylesheet" href="/css/mate.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/slick.min.js"></script>
</head>

<body>
    <div id="bannerBox">
        <img src="/img/메이트베너.jpg" id="bannerImg"/>
    </div>
         <c:forEach var="uvo" items="${userselect}"><!--유저 정보 가져오기 아이디값은 무조건 줘야 된다.-->
            <input type='hidden' id=usercode value=${uvo.usercode}>
            <input type='hidden' id=gender value=${uvo.gender}>
            <input type='hidden' id=birthdate value=${uvo.birthdate}>
         </c:forEach>
    <div class="layout">
            <!-- 중앙 메인 콘텐츠 -->
            <div class="main-content">
                <!-- 필터 -->
                <div class="select-section">
                    <div class="select-box-container">
                        <div class="select-box" id="marathonSelect">
                         
                            <p>내 대회 <span style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;width: 80px;">&nbsp;▼</span></p>
                            <ul class="dropdown-menu options-list" id="options_list">
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
                               
                                <li data-value="2">2명</li>
                                <li data-value="3">3명</li>
                                <li data-value="4">4명</li>
                                <li data-value="5">5명</li>
                                <li data-value="6">6명</li>
                                <li data-value="7">7명</li>
                                <li data-value="8">8명</li>
                                <li data-value="9">9명</li>
                                <li data-value="10">10명</li>
                                <li data-value="11">11명</li>
                                <li data-value="12">12명</li>
                                <li data-value="13">13명</li>
                                <li data-value="14">14명</li>
                                <li data-value="15">15명</li>
                                <li data-value="16">16명</li>
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
                                     
                                        <span class="crew-name">${rank.crew_name}</span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="more" id="more" onclick="ranking_more();">더보기</div>
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
var now_personnel, new_personnel, intervalId;
   //매칭룸코드
var more = 0;
var cnt  = 0;
var accept_cnt = 0;
var update_cnt = 0;
var match_yn="${vo.match_yn}";
var usercode=$('#usercode').val();
var gender=$('#gender').val();

$(document).ready(function() {
    marathon_code();//내가 결제한 대회리스트 불러오기
    setTimeout(function() {
        if(match_yn>0){
            match_view(match_yn);
            match_view_start(match_yn);
        }
        else start_view();
    }, 200);

    setTimeout(function() {
        // 드롭다운을 토글하는 함수
        function toggleDropdown(box) {
            $('.select-box').not(box).removeClass('active'); // 다른 드롭다운을 비활성화
            $(box).toggleClass('active'); // 클릭한 드롭다운을 활성화/비활성화
        }

    // 옵션을 선택하는 함수
    function selectOption(li, box) {
        var selectedText = $(li).text(); // li의 텍스트를 가져옴
        $(box).find('span:first').text(': '+selectedText); // 선택된 텍스트로 span 업데이트
        $(box).removeClass('active'); // 드롭다운 닫기
            // 선택된 li에 따라 다른 동작을 수행
            var selectedValue = $(li).data('value'); // data-value 속성 값 가져오기
            $(box).data('selected-value', selectedValue); // 선택된 값을 box의 data 속성에 저장
            $(box).toggleClass('active'); // 클릭한 드롭다운을 활성화/비활성화
            localStorage.setItem(box.attr('id'), selectedValue); // select-box의 ID를 키로 사용하여 값 저장
        }


    $('.select-box').each(function() {
            var box = $(this);
            var storedValue = localStorage.getItem(box.attr('id')); // 로컬 스토리지에서 값 불러오기
            if (storedValue) {
                var selectedOption = box.find("li[data-value='" + storedValue + "']");
                var selectedText = selectedOption.text();
                box.find('span:first').text(': ' + selectedText); // 선택된 텍스트로 span 업데이트
                box.data('selected-value', storedValue); // 선택된 값 설정
            }

            // 드롭다운 메뉴 클릭 시 값 선택 처리
            box.find('.dropdown-menu li').on('click', function() {
                selectOption(this, box); // li 선택 시 텍스트를 업데이트
            });

            // 드롭다운 토글
            box.on('click', function() {
                toggleDropdown(this);
            });
        });
    }, 200);
});

    function match_view_start(match_yn){
           intervalId = setInterval(function() {
            match_view(match_yn);
        }, 2000);
    }

    function match_view(match_yn){//선택한 인원수대로 매칭 자리만들기
        $.ajax({
          url:'/mate/match_view',
          type:'post',
          async: false,
          data:{
           matching_room_code:match_yn //matching_room_code
          },
          success:function(result){
               var length = result[0].buff_n;
               if(accept_cnt != result[0].accept_cnt || update_cnt != result[0].update_cnt){
                   grid_draw(length,result);
                   accept_cnt = result[0].accept_cnt;
                   update_cnt = result[0].update_cnt;
              }

               if(cnt==0){
                   match_view_start(match_yn);
                   cnt++;
               }
          },
          error:function(e){
          }
       });
    }

    function ranking_more(){
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

                    list+='<span class="crew-name">'+result[i].crew_name+'</span>';
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

                 // 팝업에 gender 값을 쿼리 파라미터로 전달
                 var popupUrl = '/mate/profileList?gender=' + encodeURIComponent(gender);

                    // 팝업 창을 화면 중앙에 크기 고정으로 엽니다.
                    window.open(popupUrl, 'ProfileList',
                    'width=' + width + ',height=' + height + ',top=' + screenTop + ',left=' + screenLeft + ',resizable=no,scrollbars=no,menubar=no,status=no,toolbar=no');



        }

    function matching() {
            var marathonValue = $('#marathonSelect').data('selected-value');
            var participationCountValue = $('#participationCountSelect').data('selected-value');
            var mateCountValue = $('#mateCountSelect').data('selected-value');
            clog(marathonValue);
            if(marathonValue===undefined||participationCountValue===undefined||mateCountValue===undefined){
                alert('옵션을 선택해주세요');
                return false;
            }
            $.ajax({
                  url:'/mate/matching',
                  type:'post',
                  async: false,
                  data:{
                      marathonValue:marathonValue,
                      participationCountValue:participationCountValue,
                      mateCountValue:mateCountValue
                   },success:function(result){
                      match_yn=result;
                      match_view(result);
                   },
                     error:function(e){
              }
            });
        }
    function marathon_code(){
          $.ajax({
                url:'/mate/marathon_code',
                type:'post',
                async: false,
                success:function(result){
                    var list = '';
                    for(var i in result){
                        list += '<li class="marathon_code" data-value="' + result[i].marathon_code + '">' + result[i].marathon_name + '</li>';
                    }
                    // 옵션 리스트에 항목 추가
                    $('#marathonSelect .dropdown-menu').empty(); // 기존 옵션 삭제
                    $('#marathonSelect .dropdown-menu').append(list); // 새 옵션 추가
                },
                error:function(e){
                    console.error('Error fetching marathon code:', e);
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
                   localStorage.clear(); // 전체 로컬 스토리지 값 초기화 (또는 특정 값을 초기화)
                   location.reload();  // 페이지 새로고침 추가
              },
              error:function(e){
              }
           });
    }


$(document).ready(function() {
    // 초기 수락 버튼에 대한 이벤트 핸들러 등록
    $(document).on('click', '#accept', function() {
        // 버튼을 비활성화하여 중복 클릭 방지
        $('#accept').prop('disabled', true);

        $.ajax({
            url: '/mate/accept',
            type: 'post',
            async: false,
            data: {
                matching_room_code: match_yn
            },
            success: function(result) {
                console.log("result-->>>", result);
                if (result === 0) {  // result가 0이면 수락 처리 성공
                    // 1.0초 후에 '수락하기' 버튼을 '수락거절'로 변경
                    setTimeout(function() {
                        $('#accept').text('수락거절');
                        $('#accept').attr('id', 'accept_n'); // ID 변경

                        // 버튼을 다시 활성화
                        $('#accept_n').prop('disabled', false);
                    }, 1000);  // 1.0초 지연
                }
            },
            error: function(e) {
                console.error('Error: ', e);
                $('#accept').prop('disabled', false); // 에러 발생 시 버튼 다시 활성화
            }
        });
    });

    // '수락거절' 버튼에 대한 이벤트 위임 처리
    $(document).on('click', '#accept_n', function() {
        console.log('수락거절 버튼이 눌렸습니다');

        // 수락거절 버튼을 비활성화하여 중복 클릭 방지
        $('#accept_n').prop('disabled', true);

        $.ajax({
            url: '/mate/accept_n', // 거절 요청 URL
            type: 'post',
            async: false,
            data: {
                matching_room_code: match_yn // 필요한 데이터 전달
            },
            success: function(response) {
                console.log("response-->>>", response);
                if (response === 1) {  // response가 1이면 수락거절 성공
                    // 1초 후에 '수락거절' 버튼을 '수락하기'로 변경
                    setTimeout(function() {
                        $('#accept_n').text('수락하기');
                        $('#accept_n').attr('id', 'accept'); // ID 변경

                        // 버튼 다시 활성화
                        $('#accept').prop('disabled', false);
                    }, 1000);  // 1.0초 지연
                }
            },
            error: function(e) {
                console.error('Error:', e);
                $('#accept_n').prop('disabled', false); // 에러 발생 시 버튼 다시 활성화
            }
        });
    });
});

    function start_view() {//매칭된 룸이 없으면 기본 빈 8개의 자리 생성
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
;
function grid_draw(length, result) {
    var list = '';

    // 선택한 메이트 인원 + 4의 배수로 맞춘 방 개수 계산
    var total_mates = length;
    var remainder = total_mates % 4;

    // 선택한 메이트 인원 + 4의 배수로 맞추기
    if (remainder !== 0) total_mates += 4 - remainder;
    total_mates = Math.max(8, total_mates); // 최소 8개의 방은 무조건 보여주기

    for (var i = 0; i < result.length; i++) {
        var on = result[i].usercode==usercode? 'onclick="profile_update();"' : '';
        var gender = result[i].gender=="Female"? 'woman':'man' ;
        var no = result[i].b_s=="0"?'0':result[i].b_s;//profile값가저옴
        var img = gender+no;
        //나이 가져오기
        var today = new Date();
        var birthDate = new Date(result[i].birthdate);
        var age = (today.getFullYear() - birthDate.getFullYear())+'';
        age = age[0]+'0대';


        var style = result[i].a_s === 'Y' ? "transform: scale(1.05);border-color: #CCFF47;" : ""; // 수락 여부에 따른 스타일
        list += '<div class="profile-box" '+ on +' style="' + style + '">';
        list += '<div id="profile_img">';
        list += '<img src="/img/' + img + '.png" alt="프로필 1 이미지">';
        list += '</div>';
        list += '<span class="rank-name">' + result[i].nickname + '</span>';
        list += '<span class="age">' + age + '</span>';
        list += '<span class="runkm">' + result[i].tbuf_n + 'Km</span>';
        list += '<span class="crew_name">' + result[i].crew_name + '</span>';
        list += '</div>';
    }

    // 현재 result에 없는, 선택한 메이트 인원에 대해 woman0.png 표시
    for (var i = result.length; i < length; i++) {
        list += '<div class="profile-box" style="">';
        list += '<div id="profile_img">';
        list += '<img src="/img/woman0.png" alt="프로필 1 이미지">';
        list += '</div>';
        list += '<span class="rank-name">&nbsp;</span>';
        list += '<span class="runkm">&nbsp;</span>';
        list += '<span class="crew_name">&nbsp;</span>';
        list += '</div>';
    }

    // 나머지 비활성화된 방은 이미지 없이 처리
    for (var i = length; i < total_mates; i++) {
        list += '<div class="profile-box" style="pointer-events: none;">';
        list += '<div id="profile_img" style="background-color: #1e1e1e">'; // 비활성화된 방 처리
        list += '</div>';
        list += '<span class="rank-name">&nbsp;</span>';
        list += '<span class="runkm">&nbsp;</span>';
        list += '<span class="crew_name">&nbsp;</span>';
        list += '</div>';
    }

    // 프로필 컨테이너에 결과 반영
    $('.profile-container').empty();
    $('.profile-container').append(list);

    // 매칭 버튼을 누르면 select 박스 비활성화
    $('.select-box').each(function() {
        // 드롭다운 클릭 자체를 막아줍니다 (클릭 방지)
        $(this).css('pointer-events', 'none');
    });

    // 매칭 버튼을 숨기고 수락, 나가기 버튼 표시
    $('#matching').hide();
    $('#accept').show();
    $('#out').show();
}




</script>