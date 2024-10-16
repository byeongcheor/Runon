<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/js/crew.js" type="text/javascript"></script>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="/css/crewManage.css" type="text/css">

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg"/>
    </div>
    <input type=hidden id=usercode />
    <input type=hidden id=vote_num />
    <div class="content_body">
        <div class="content_left">
            <section class="section3">
                <div class="profile_container">
                    <div class="names">
                        <h4 id='crew_name' ></h4>
                        <span id='addr'style="display: block;"></span>
                        <span id='crew_info' style="display: block;"></span>
                    </div>

                    <div class="profileimage">
                        <div class="imgContainer">
                            <img id=crew_img>
                        </div>
                    </div>
                </div>
                <div class="editCrew">
                    <button type="button" class="editCrewBtn" id="editCrewBtn">크루정보변경</button>
                    <button type="button" class="editCrewBtn" id="resignCrew" onclick="openResignModal()">
                      <img src="/img/more.png" style="width: 14px; height: 14px;">
                    </button>
                </div>
                <div class="statis">

                </div>
            </section>
        </div>
        <div class="content_right">
            <section class="section1">
              <div class="section_nav">
                <ul>

                  <li id="overview" name=crew_select onClick="crew_manage_select(this)">오버뷰</li>
                  <li id="notice" name=crew_select onClick="crew_manage_select(this)">공지</li>
                  <li id="member" name=crew_select onClick="crew_manage_select(this)">멤버</li>
                </ul>
              </div>
                  <div class="member">
                    <ul class="member-list" id=crew_manage_list>
                    </ul>
                </div>
            </section>
            <section class="section2">
                <div class="section_title">크루정보</div>
                <div class="info_body">
                    <div class="crew_infos">
                        <span class="crew_imogi">🔥‍</span>
                        <span class="crew_addr">️크루랭킹</span>
                        <span class="crew_addr2" id="crew_ranking"></span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">📍</span>
                        <span class="crew_addr">활동지역</span>
                        <span class="crew_addr2" id="addr2"></span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🏃‍</span>
                        <span class="crew_addr">️멤버수</span>
                        <span class="crew_addr2" id="member_cnt"></span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🔍‍</span>
                        <span class="crew_addr">평균나이</span>
                        <span class="crew_addr2" id="member_age_avg"></span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">✨</span>
                        <span class="crew_addr">크루생성일</span>
                        <span class="crew_addr2" id=create_date></span>
                    </div>
               </div>
            </section>
        </div>
    </div>
</div>
<!-- 커스텀 모달 창 -->
<div id="customModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <span class="custom-modal-title" id=member_name></span>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
      <button class="custom-modal-option" id="manage2" onClick="member_manage(this)">운영진으로 추가</button>
      <button class="custom-modal-option" id="manage3" onClick="member_manage(this)">일반크루로 변경</button>
      <button class="custom-modal-danger" onClick="openRejectModal();">신고하기</button>
      <button class="custom-modal-danger" id="out" onClick="member_manage(this)">강제 퇴장</button>
    </div>
  </div>
</div>
<!-- 신고 사유 선택 모달-->
<div id="rejectModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h3 class="modal-title">신고 사유를 선택해주세요</h3>
      <span class="custom-close" onclick="closeRejectModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name=report_reason id="reason1" value="1">
        <label class="form-check-label" for="reason1">무단으로 불참했어요 </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name=report_reason id="reason2" value="2">
        <label class="form-check-label" for="reason2">시간 약속을 지키지 않아요 </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name=report_reason id="reason3" value="3">
        <label class="form-check-label" for="reason3">크루 참여를 위해 속였어요</label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name=report_reason id="reason4" value="4">
        <label class="form-check-label" for="reason4">매너가 없어요</label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" name=report_reason id="reason5" value="5">
        <label class="form-check-label" for="reason5">광고성 메세지를 보내요</label>
      </div>
    </div>
    <div class="mt-3">
        <textarea id="report_content" name="report" class="report" placeholder="신고 사유를 추가로 작성하실 수 있습니다."></textarea>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="report"  onClick="member_manage(this)">확인</button>
        <button type="button" class="btn btn-light" onclick="closeRejectModal()">취소</button>
    </div>
  </div>
</div>
<div id="informationModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <div class="team-info">
        <img id="teamImage" src="/crew_upload/맹고기.jpeg" alt="크루 이미지" />
        <h2 id="teamNameDisplay">크루 이름</h2>
      </div>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
     <button class="custom-modal-option" id="update" onclick="crewRevise()">프로필 수정</button>
      <button class="custom-modal-option" id="handoverCrewBtn">팀소유자 위임</button>
      <button class="custom-modal-danger" onclick="deleteTeam()" id="crew_delete" >팀 삭제하기</button>
    </div>
  </div>
</div>
<!-- 팀 소유자 위임 모달 -->
<div id="handoverModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h3>위임할 멤버를 선택하세요</h3>
      <span class="custom-close" onclick="closeHandoverModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
      <!-- 팀 멤버 선택 -->
      <label class="team-member">
        <input type="radio"  name="teamOwner" value="jang">
        <img src="/crew_upload/맹고기.jpeg"  class="team-profile">

        <span class="team-name">소시민</span>
      </label>
      <label class="team-member">
        <input type="radio"  name="teamOwner" value="jang">
        <img src="/crew_upload/맹고기.jpeg"  class="team-profile">

        <span class="team-name">소시민</span>
      </label>
    </div>
    <div class="custom-modal-footer">
      <button class="handover-btn" onclick="handoverOwnership()">위임하기</button>
    </div>
  </div>
</div>

<!-- 가로 점점점 모달 -->
<div id="resignModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h4 class="modal-title">어떤 걸 하시겠어요?</h4>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
      <button class="custom-modal-option" id="noticeMake" onclick="openNoticeModal()">공지 올리기</button>
      <button class="custom-modal-option" id="voteMake" onclick="openVoteModal()">투표 올리기</button>
      <button class="custom-modal-danger" onclick="resignTeam()" id="teamResign">팀 탈퇴하기</button>
    </div>
  </div>
</div>
<!-- 공지사항 모달 -->
  <form id="updateNoticeForm" enctype="multipart/form-data">
    <div id="noticeCreateModal" class="custom-modal" style="display: none;">
        <div class="custom-modal-content2">
            <div class="custom-modal-header">
                <h5 class="custom-modal-title2" id="noticeCreateModalLabel">공지사항 작성</h5>
                <span class="custom-close" onclick="closeNoticeModal()">&times;</span>
            </div>
            <div class="custom-modal-body">
                <div class="mb-3">
                    <label for="noticeTitle" class="form-label2">제목을 작성해 주세요</label>
                    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" style="margin-top:10px;" placeholder="제목 입력" required />
                </div>
                <div class="mb-3">
                    <label for="noticeImage" class="form-label2">이미지를 올려주세요</label>
                    <label class="upload-box" for="noticeImage" style="margin-top:10px;">
                         사진 업로드
                         <input type="file" id="noticeImage" name="noticeImage" onchange="previewImages(event)" multiple />
                    </label>
                    <div id="previewContainer" style="position: relative; display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px;">
                        <!-- 이미지 미리보기가 이곳에 추가됩니다 -->
                    </div>
                </div>
                <div class="mt-3">
                    <label class="form-label2">공지 내용</label>
                    <textarea id="noticeContent" name="noticeContent" class="form-control notice-content" placeholder="여기를 누르고 공지를 등록하세요"></textarea>
                </div>
            </div>
            <div class="custom-modal-footer">
                <button type="button" class="custom-btn2" onclick="submitNotice()">등록하기</button>
            </div>
        </div>
    </div>
</form>
<!-- 투표 만들기 모달 -->
<div id="voteModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h3 class="modal-title">투표 만들기</h3>
      <span class="custom-close" onclick="closeVoteModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
      <input type="text" id="voteTitle" name=vote_opt  class="input-field" placeholder="투표 제목">
      <!-- 항목 입력란이 추가될 공간 -->
      <div id="voteItems">
        <div class="vote-item">
          <input type="text" class="input-field" name=vote_opt id=vote1 placeholder="항목 입력">
        </div>
        <div class="vote-item">
          <input type="text" class="input-field" name=vote_opt id=vote2 placeholder="항목 입력">
        </div>
        <div class="vote-item">
          <input type="text" class="input-field" name=vote_opt id=vote3 placeholder="항목 입력">
        </div>
      </div>
      <!-- 항목 추가 버튼 -->
      <button class="add-item-button" id=addVoteBtn onclick="addVoteItem()">+ 항목 추가</button>
      <!-- 마감일 및 시간 입력 -->
       <div class="vote-deadline">
             <label style=" margin:5px;">
               <input type="radio" id="enableDeadline" name="deadlineOption" value="enable" checked>
               <span class="deadline-label">마감시간 설정</span>
             </label>
          <input type="datetime-local" id="voteDeadline" class="input-field">
       </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-primary" style="font-size:14px;"onclick="submitVote()" >투표 올리기</button>
      <button type="button" class="btn btn-light" style="font-size:14px;" onclick="closeVoteModal()">취소</button>
    </div>
  </div>
</div>

<!-- 투표하기 모달 -->
<div id="voteNowModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h4 class="modal-title">투표 하기 </h4>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body2" id=vote_list>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-primary" style="font-size:14px;" onclick="submitVoteNow()">투표하기</button>
      <button type="button" class="btn btn-light" style="font-size:14px;" onclick="closeCustomModal()">취소</button>
    </div>
  </div>
</div>
 <!-- 투표 현황 -->
<div id="voteResultModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h4 class="modal-title">투표 현황</h4>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body3" id=vote_results>
    </div>
    <div class="custom-modal-footer">
      <button class="handover-btn" onclick="closeCustomModal()">닫기</button>
    </div>
  </div>
</div>
<!-- 닉네임 리스트 모달 -->
<div id="nicknameModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h4 class="modal-title">투표자 명단</h4>
      <span class="custom-close" onclick="closeNicknameModal()">&times;</span>
    </div>
    <div class="custom-modal-body" id="nickname_list"></div>
    <div class="custom-modal-footer">
      <button class="handover-btn" onclick="closeNicknameModal()">닫기</button>
    </div>
  </div>
</div>

<script>
var Authorization = localStorage.getItem("Authorization");
const urlParams = new URLSearchParams(window.location.search);
const create_crew_code = urlParams.get('create_crew_code');
const user_code = urlParams.get('user_code');
const position = urlParams.get('position');
var votenum=4;
if(position >1){
    $('#editCrewBtn').hide();
}
if(position>2){
    $('#noticeMake').hide();
    $('#voteMake').hide();
}
clog('My position : '+ position);
clog('My user_code : '+ user_code);


    $(document).ready(function() {
        $('#member').css('color', 'black');
        crew_deatil_select();
        crew_manage_select('');
        if(position !=1){
            $('#wait_cnt').hide();
        }
    });

    function crew_deatil_select(){
        $.ajax({
            url: '/crew/crew_deatil_select',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : create_crew_code
            },
            success: function(response) {

                $('#crew_img').attr('src', '/crew_upload/'+response[0].logo);
                $('#crew_name').text(response[0].crew_name);
                $('#addr').text(response[0].addr);
                $('#addr2').text(response[0].addr);
                $('#crew_info').text(response[0].a_s);
                $('#member_cnt').text(response[0].d_n+'명');
                $('#create_date').text(response[0].c_s);
                $('#member_age_avg').text(response[0].e_n+'세');
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }
    function crew_manage_select(element) {
        var id = element.id === undefined ? 'overview' : element.id;
        $('[name="crew_select"]').css('color', 'gray');
        $('#' + id).css('color', 'black');
          console.log("Selected id: ", id);  // 선택한 id 출력
        $.ajax({
            url: '/crew/crew_manage_select',
            type: 'post',
            async: false,
            data: {
                Authorization: Authorization,
                create_crew_code: create_crew_code,
                id: id
            },
            success: function(response) {
                $('#crew_manage_list').html('');  // 이전 리스트 초기화
                if (id == 'member') {
                    crew_manage_select_member(response);
                    // 'member'일 때만 section2 숨기기
                    document.querySelector('.section2').style.display = 'none';
                }
                else if (id == 'overview') {
                    crew_overview(response);
                    // 'overview'일 때는 section2를 다시 보이게
                    document.querySelector('.section2').style.display = 'block';
                }
                else if (id == 'notice') {
                    crew_notice(response);
                    // 'member'일 때만 section2 숨기기
                    document.querySelector('.section2').style.display = 'none';
                }
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }


    function crew_manage_select_member(response) {
        var list = '';
        if (response[0].f_n > 0 && response[0].a_n == 1) {
            list += '<div class="join_info" onClick="go_request_wait()" style="display: flex; justify-content: space-between; align-items: center; cursor: pointer;">';
            list += '   <span id="wait_cnt">';
            list +=         response[0].f_n + ' 명이 승인을 기다리고있어요.';
            list += '   </span>';

            list += '   <img src="/img/way.png" style="width: 20px; height: 20px; padding:0; margin-right:40px; margin-top:3px;">';
            list += '</div>';
        }

        for (var i in response) {
            list += '<li class="member-item"> ';
            list += '<div class="item-flex"> ';

            list += '   <img src="/resources/uploadfile/' + response[i].a_s + '" class="profile-img" onClick="go_mypage(' + response[i].usercode + ')"> ';
            list += '   <div class="profile-info" onClick="go_mypage(' + response[i].usercode + ')"> ';
            list += '     <div class="info-wrapper"> ';

            list += '      <p class="name">' + response[i].b_s + '</p> ';
            if (response[i].a_n < 3) {
                list += '      <div class="label-operator">운영진</div> ';
            }
            list += '     </div> ';
            list += '   </div> ';
            list += '  <div class="menu"> ';
            list += '   <div class="dropdown"> ';

            if (user_code != response[i].usercode && response[i].b_n > 0) {
                list += '     <div class="more-icon" onclick="openCustomModal(' + response[i].usercode + ', \'' + response[i].nickname + '\', \'' + response[i].a_n + '\')"> <img src="/img/dots.png" alt="dots icon" style="width: 20px; height: 20px;"></div> ';
            }
            list += '   </div> ';
            list += '  </div> ';
            list += '</div> ';
            list += '</li> ';
        }
            console.log("Generated list: ", list);  // 생성된 list 출력
        $('#crew_manage_list').append(list);
    }

    function crew_overview(response) {
      var list = '';
          list += '<div class="join_info" onClick="crew_manage_select(member)" style="display: flex; justify-content: space-between; align-items: center; cursor: pointer;">';
          list += '<div class="overview_title">주요 멤버</div>'
          list += '<div class="member_more">전체 보기</div>'
          list += '</div>';
          for (var i = 0; i<response[0].c_n;i++) {
              list += '<li class="member-item"> ';
              list += '<div class="item-flex"> ';
              list += '   <img src="/resources/uploadfile/' + response[i].subject + '" class="profile-img"> ';
              list += '   <div class="profile-info"> ';
              list += '     <div class="info-wrapper"> ';
              list += '      <p class="name">' + response[i].writedate + '</p> ';
              list += '     </div> ';
              list += '   </div> ';
              list += '  <div class="menu"> ';
              list += '   <div class="dropdown"> ';
              list += '   </div> ';
              list += '  </div> ';
              list += '</div> ';
              list += '</li> ';
          }
          list += '<div class="join_info" onClick="crew_manage_select(notice)" style="display: flex; justify-content: space-between; margin-top:10px;align-items: center; cursor: pointer;">';
          list += '<div class="overview_title">최신 공지</div>'
          list += '<div class="member_more">전체 보기</div>'
          list += '</div>';

      for (var i = response[0].c_n; i<response.length;i++) {
          list += '<li class="member-item"> ';
          list +=    '<div class="item-container"> ';
          list +=       '<div class="icon-container"> ';
          if(response[i].a_n==1){
            list +=       '   <img src="/img/vote.png"> ';
          }
          if(response[i].a_n==2){
            list +=       '   <img src="/img/notice.png"> ';
          }
          list +=       '</div>';
          list +=       '<div class="text-container"> ';
          if(response[i].b_n==1){
              list +=          '<span class="main-text" onClick="voteNow('+response[i].c_n+')">'+response[i].subject+'</span> ';
              list +=          '<span class="sub-text">투표 진행중</span>';
          }
         if(response[i].b_n==9){
               list +=          '<span class="main-text" onClick="vote_select('+response[i].c_n+')">'+response[i].subject+'</span> ';
               list +=          '<span class="sub-text" style=" background-color: black; color: white;">투표 마감</span>';
          }
          list +=       '</div> ';
          list +=    '</div> ';
          list += '</li> ';
      }

      $('#crew_manage_list').append(list);
    }
    function crew_notice(response) {
        var list = '';
        for (var i in response) {
            list += '<li class="member-item"> ';
            list +=    '<div class="item-container"> ';
            list +=       '<div class="icon-container"> ';
            if(response[i].a_n==1||response[i].a_n==3){
              list +=       '<img src="/img/vote.png"> ';
              list +=       '</div>';
              list +=       '<div class="text-container" onClick="voteNow('+response[i].c_n+')"> ';
              if(response[i].b_n==1){
                  list +=   '<span class="sub-text">투표 진행중</span>';
                  list +=   '<span class="main-text">'+response[i].subject+'</span> ';
                  var aa =   response[i].e_n == 1? "참여":"미참여"
                  list +=   '<div>'+response[i].e_n+"명 참여, "+aa+'<div>'
                  list +=   '<div>'+response[i].enddate+" 까지 마감"+'<div>'
              }
             if(response[i].b_n==9){
                  list +=   '<span class="sub-text">투표 마감</span>';
                  list +=   '<span class="main-text">'+response[i].subject+'</span> ';
                  list +=   '<div>'+response[i].e_n+"명 참여, "+aa+'<div>'
                  list +=   '<div>'+response[i].enddate+" 까지 마감"+'<div>'
              }
            }
            if(response[i].a_n==2){
              list +=       '   <img src="/img/notice.png"> ';
            }
            list +=       '</div>';
            list +=       '<div class="text-container"> ';

            list +=       '</div> ';
            list +=    '</div> ';
            list += '</li> ';
        }
        $('#crew_manage_list').append(list);
    }

      function openCustomModal(usercode,nickname,user_pisition) {
      $('#usercode').val(usercode);
      $('#member_name').text(nickname);
      if(position==1){
        $('#manage2').show();
        $('#manage3').show();
        $('#out').show();
      }
      else{
        $('#manage2').hide();
        $('#manage3').hide();
        $('#out').hide();
      }
      clog(user_pisition);
      if(user_pisition==2)$('#manage2').hide();
      if(user_pisition==3)$('#manage3').hide();

      document.getElementById('customModal').style.display = 'block';
    }
    function go_request_wait(){
        window.location.href = '/crew/crewApp?create_crew_code=' + create_crew_code + '&position=' + position;
    }
    function crewRevise() {
        // user_code와 create_crew_code 값을 URL에 추가하여 넘기기
        window.location.href = '/crew/crewRevise?user_code=' + user_code + '&create_crew_code=' + create_crew_code;
    }

    function member_manage(element){
        var id = element.id;
        var reason='';
        var checkedValues = [];
        if(id=='report'){
            $('input[name="report_reason"]:checked').each(function() {
                checkedValues.push($(this).val());
            });
            reason = checkedValues.join(',');
        }
        $.ajax({
            url: '/crew/member_manage',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : create_crew_code,
                id               : id,
                usercode         : $('#usercode').val(),
                reason           : reason,
                reason_text      : $('#report_content').val()
            },
            success: function(response) {
                if(response==1) alert('운영진으로 추가되었습니다.');
                if(response==4) alert('일반크루로 변경되었습니다.');
                if(response==2) alert('신고접수가 되었습니다.');
                if(response==3) alert('유저가 강퇴되었습니다.');
                location.reload(true);

            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }

//신고 사유 선택 모달 열기
  function openRejectModal() {
    document.getElementById("rejectModal").style.display = "block";
  }

  //신고 사유 선택 모달 열기
    function openRejectModal() {
      document.getElementById("rejectModal").style.display = "block";
    }

    // 신고 사유 선택 모달 닫기
    function closeRejectModal() {
      document.getElementById("rejectModal").style.display = "none";
    }
    // 신고 사유 확인 처리
    function confirmRejection() {
      alert("신고 사유가 제출되었습니다.");
      closeRejectModal();
    }

      // 크루정보변경 버튼 클릭 시 모달 열기
      document.getElementById("editCrewBtn").addEventListener("click", function() {
        document.getElementById("informationModal").style.display = "block";
      });

      // 팀 소유자 위임 모달 열기 (informationModal 닫고 handoverModal 열기)
      document.getElementById("handoverCrewBtn").addEventListener("click", function() {
        document.getElementById("informationModal").style.display = "none"; // 정보 변경 모달 닫기
        document.getElementById("handoverModal").style.display = "block"; // 팀 소유자 위임 모달 열기
      });

      // handoverModal의 닫기 버튼을 눌렀을 때 handoverModal을 닫고, 다시 informationModal 열기
      function closeHandoverModal() {
        document.getElementById("handoverModal").style.display = "none"; // handoverModal 닫기
        document.getElementById("informationModal").style.display = "block"; // informationModal 다시 열기
      }

      // 위임하기 버튼 클릭 시 handoverModal 닫고 다시 informationModal 열기
      function handoverOwnership() {
        // 위임 로직 추가 (예: 서버 요청)
        alert("팀 소유자가 위임되었습니다.");
        closeHandoverModal(); // handoverModal을 닫고, informationModal 다시 열기
      }

      // 기존 모달 닫기 함수
      function closeCustomModal() {
        document.getElementById("customModal").style.display = "none";
        document.getElementById("informationModal").style.display = "none";
        document.getElementById("customModal").style.display = "none";
        document.getElementById("resignModal").style.display = "none";
        document.getElementById('resignModal').style.display = 'none';
        document.getElementById('voteNowModal').style.display = 'none';
        document.getElementById('voteNowModal').style.display = 'none';
        document.getElementById('voteResultModal').style.display = 'none';
      }
      // 투표현황 모달 닫기
      function closeNicknameModal() {
          document.getElementById('nicknameModal').style.display = 'none';
      }

      // 팀 탈퇴 모달 열기
      function openResignModal() {
        document.getElementById("resignModal").style.display = "block";
      }
      // 팀 탈퇴 처리 함수 (필요에 따라 서버 요청 등 추가 가능)
      function resignTeam() {
        alert("팀에서 탈퇴되었습니다.");
        closeCustomModal();
      }

      // 투표 모달 열기
      function openVoteModal() {
        document.getElementById('voteModal').style.display = 'block';
      }

    // 투표항목추가
    function addVoteItem() {
      const voteItems = document.getElementById('voteItems');
      const newItem = document.createElement('div');
      newItem.classList.add('vote-item');

      newItem.innerHTML =
           '<input type="text" class="input-field" name=vote_opt id="vote' + votenum + '" placeholder="항목 입력">' +
           '<button class="remove-item-button" onclick="removeVoteItem(this)">&times;</button>';
      voteItems.appendChild(newItem);
      votenum++
      if(votenum>5)$('#addVoteBtn').hide();
    }
    // 항목 삭제하는 함수
    function removeVoteItem(button) {
      const voteItem = button.parentElement; // 삭제 버튼의 부모 요소 (항목 div)를 가져옴
      voteItem.remove(); // 해당 항목을 삭제
      votenum--;
      if(votenum<6)$('#addVoteBtn').show();
    }

    // 투표자 명단 모달 열기
    function showVoterList(voters) {
        document.getElementById('nicknameModal').style.display = 'block';
        $('#nickname_list').html('<li>' + voters + '</li>');
    }

    function openVoteModal() {
      // resignModal을 닫고 voteModal을 염
      closeCustomModal();
      document.getElementById('voteModal').style.display = 'block';
    }

    function closeVoteModal() {
      // voteModal을 닫고 resignModal을 염
      document.getElementById('voteModal').style.display = 'none';
      openResignModal();
    }

    // 투표 만들기 함수
    function submitVote() {
        const title = document.getElementById('voteTitle').value;
        const deadline = document.getElementById('voteDeadline').value;

        if (!deadline) {
            alert('마감시간을 설정해주세요.');
            return;
        }

        const currentTime = new Date();
        const voteDeadlineTime = new Date(deadline);
        const fiveMinutesInMillis = 10 * 60 * 1000;
        if (voteDeadlineTime - currentTime < fiveMinutesInMillis) {
            alert('마감시간은 현재 시간 기준으로 최소 10분 이후여야 합니다. 다시 설정해주세요.');
            return;
        }
        $.ajax({
            url: '/crew/vote_create',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : create_crew_code,
                title            : title,
                opt1             : $('#vote1').val(),
                opt2             : $('#vote2').val(),
                opt3             : $('#vote3').val(),
                opt4             : $('#vote4').val(),
                opt5             : $('#vote5').val(),
                endDate          : deadline
            },
            success: function(response) {
                alert('투표가 제출되었습니다.');
                location.reload(true);
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });

        closeVoteModal();
    }

    // 투표하기 모달 열기
    function voteNow(vote_num) {
        $('#vote_num').val(vote_num);
        $.ajax({
            url: '/crew/vote_select',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : create_crew_code,
                vote_num         : vote_num
            },
            success: function(response) {
                $('#vote_list').html('');
                $('#vote_results').html('');
                var list = '';
                var list2 = '';
                list += '<span class="modal-subtitle">' + response[0].subject + '</span>';
                list += '<p class="modal-deadline">' + response[0].enddate + ' 종료</p>';
                list += '<div class="vote-options">';

                for (var i = 1; i < 6; i++) {
                    var key = 'opt' + i;
                    if (response[0][key] == '') break;

                    var checked = (response[0][key] == response[0].f_s) ? "checked" : "";

                    list += '<label class="vote-option">';
                    list += '    <input type="radio" name="voteOption" value="' + response[0][key] + '" ' + checked + '>';
                    list += '    <span>' + response[0][key] + '</span>';
                    list += '</label>';
                }
                list += '</div>';
                $('#vote_list').html(list);

                list2 += '<span class="modal-subtitle">' + response[0].subject + '</span>';
                list2 += '<p class="modal-deadline">' + response[0].enddate + ' 종료</p>';
                list2 += '<div class="vote-results">';

                for (var i = 1; i < 6; i++) {
                    var arr = ['a', 'b', 'c', 'd', 'e'];  // arr 배열은 여전히 0부터 시작
                    var key = 'opt' + i;
                    var key2 = arr[i - 1] + '_s';  // i가 1부터 시작하므로 i-1로 접근

                    if (response[0][key] == '') break;  // 옵션이 없는 경우 반복 종료
                    var arr_length = response[0][key2] ? response[0][key2].split(',').length : 0;
                    var voters = response[0][key2] ? response[0][key2] : '';

                    list2 += '<div class="result-row" onclick="showVoterList(\'' + voters + '\')">';
                    list2 += '    <span>' + response[0][key] + '</span>';
                    list2 += '    <span>' + arr_length + '명</span>';
                    list2 += '</div>';
                    list2 += '<div class="progress-bar">';
                    list2 += '    <div id="progress-vote' + i + '" class="progress" style="width: 0%;"></div>';
                    list2 += '</div>';
                }
                list2 += '</div>';
                $('#vote_results').html(list2);
                if(response[0].f_s=='' && response[0].a_n==1)document.getElementById('voteNowModal').style.display = 'block'
                else document.getElementById('voteResultModal').style.display = 'block';
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }

    /*function vote_select(vote_num) {
        document.getElementById('voteNowModal').style.display = 'block';
        $('#vote_num').val(vote_num);
        $.ajax({
            url: '/crew/vote_select',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : create_crew_code,
                vote_num         : vote_num
            },
            success: function(response) {
                $('#vote_results').html('');
                var list2 = '';
                list += '<span class="modal-subtitle">' + response[0].subject + '</span>';
                list += '<p class="modal-deadline">' + response[0].enddate + ' 종료</p>';
                list += '<div class="vote-options">';
                for (var i = 1; i < 6; i++) {
                    var key = 'opt' + i;
                    if (response[0][key] == '') break;

                    var checked = (response[0][key] == response[0].f_s) ? "checked" : "";

                    list += '<label class="vote-option">';
                    list += '    <input type="radio" name="voteOption" value="' + response[0][key] + '" ' + checked + '>';
                    list += '    <span>' + response[0][key] + '</span>';
                    list += '</label>';
                }
                list += '</div>';
                $('#vote_list').html(list);
                list2 += '<span class="modal-subtitle">' + response[0].subject + '</span>';
                list2 += '<p class="modal-deadline">' + response[0].enddate + ' 종료</p>';
                list2 += '<div class="vote-results">';
                for (var i = 1; i < 6; i++) {
                    var arr = ['a', 'a', 'b', 'c', 'd', 'e'];
                    var key = 'opt' + i;
                    var key2 = arr[i] + '_s';
                    if (response[0][key] == '') break;
                    if(response[0][key2]!==null){
                        var arr_length = response[0][key2].split(',').length;
                    }
                    else var arr_length=0;
                    response[0][key2] = response[0][key2]===null?'':response[0][key2];
                    list2 += '      <div class="result-row">';
                    list2 += '          <span>' + response[0][key] + '</span>';
                    list2 += '          <span>' + response[0][key2] + '</span>';
                    list2 += '          <span id="count-vote' + i + '" class="vote-count">' + arr_length + '명</span>';
                    list2 += '      </div>';
                    list2 += '      <div class="progress-bar">';
                    list2 += '          <div id="progress-vote' + i + '" class="progress" style="width: 0%;"></div>';
                    list2 += '      </div>';
                }
                list2 += '</div>';
                $('#vote_results').html(list2);
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }*/

   // 투표 제출 함수
    function submitVoteNow() {
      var selectedOption = $('input[name="voteOption"]:checked').val();
      $.ajax({
          url: '/crew/vote_insert',
          type: 'post',
          async: false,
          data: {
              Authorization    : Authorization,
              selectedOption   : selectedOption,
              vote_num         : $('#vote_num').val()
          },
          success: function(response) {
              if(response==0){
                alert('이미 투표하셨습니다.');
                return false;
              }
              else{
                alert('투표가 제출되었습니다.');
              }
          },
          error: function(e) {
              console.error('Error: ', e);
          }
      });
      // 투표하기 모달을 숨기고
      document.getElementById('voteNowModal').style.display = 'none';
      // 투표 현황 모달을 보여줍니다.
      document.getElementById('voteResultModal').style.display = 'block';
    }


    function updateVoteResults(votes) {
      // 총 투표 수 계산
      let totalVotes = votes.reduce(function (acc, vote) {
        return acc + vote.count;
      }, 0);

      // 각 항목의 프로그레스 바와 투표 명수를 업데이트
      $.each(votes, function (index, vote) {
        // 퍼센트 계산
        let percentage = (vote.count / totalVotes) * 100;

        // 해당 항목의 progress-bar 너비와 색상 업데이트
        $(`#progress-${vote.id}`).css({
          width: percentage + '%',
          backgroundColor: 'orange'
        });

        // 해당 항목의 투표 명수 업데이트
        $(`#count-${vote.id}`).text(vote.count + '명');
      });
    }

    // 예시 데이터 (DB에서 가져온 데이터 형식)
    let votes = [
      { id: 'vote1', count: 1 },
      { id: 'vote2', count: 3 },
      { id: 'vote3', count: 0 },
      { id: 'vote4', count: 0 }
    ];



    // 페이지 로드 시 투표 결과 업데이트
    $(document).ready(function() {
      updateVoteResults(votes);
    });

    // 공지사항 모달 열기
    function openNoticeModal() {
         closeCustomModal(); // 다른 모달을 닫음
         document.getElementById('noticeCreateModal').style.display = 'block'; // 공지사항 모달 열기
    }

    // 공지사항 모달 닫기
    function closeNoticeModal() {
       document.getElementById('noticeCreateModal').style.display = 'none'; // 공지사항 모달 닫기
       document.getElementById('resignModal').style.display = 'block'; // 다시 resignModal 열기
    }

    // 미리보기 이미지 삭제
    function deletePreview() {
        document.getElementById('previewContainer').style.display = 'none'; // 미리보기 컨테이너 숨김
        document.getElementById('imagePreview').src = ''; // 이미지 미리보기 제거
    }


function previewImages(event) {
    const previewContainer = document.getElementById('previewContainer');

    // 선택된 파일들을 배열로 변환
    const files = Array.from(event.target.files);

    files.forEach(file => {
        const reader = new FileReader();

        reader.onload = function(e) {
            // 이미지 미리보기 요소 생성
            const imageContainer = document.createElement('div');
            imageContainer.style.position = 'relative';

            const img = document.createElement('img');
            img.src = e.target.result;
            imageContainer.appendChild(img);

            const deleteButton = document.createElement('button');
            deleteButton.textContent = '지우기';
            deleteButton.classList.add('delete-btn');
            deleteButton.onclick = function() {
                imageContainer.remove(); // 이미지 미리보기 제거
            };

            imageContainer.appendChild(deleteButton);
            previewContainer.appendChild(imageContainer);
        };

        reader.readAsDataURL(file); // 파일을 읽어 데이터 URL을 생성
    });
}

function submitNotice() {
    alert("공지사항이 등록되었습니다!");
    closeNoticeModal(); // 모달 닫기
}


</script>