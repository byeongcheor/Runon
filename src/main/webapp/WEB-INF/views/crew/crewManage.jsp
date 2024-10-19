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
    <input type=hidden id=vote_user_code />
    <div class="content_body">
        <div class="content_left">
            <section class="section3">
                <div class="profile_container">
                    <div class="names">
                        <h4 id='crew_name' ></h4>
                        <span id='addr'style="display: block; margin-bottom:5px;"></span>
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
                <div>
                    <button type="button" class="editCrewBtn" id="go_join" onclick="go_crew_detail()">회원가입 신청하기</button>
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
<!-- 크루정보변경 버튼 -->
<div id="informationModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <div class="team-info">
        <img id="teamImage" src="" alt="크루 이미지" />
        <h2 id="teamNameDisplay"></h2>
      </div>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
     <button class="custom-modal-option" id="update" onclick="crewRevise()">프로필 수정</button>
      <button class="custom-modal-option" id="handoverCrewBtn" onclick="crew_manage_handover(this)">팀소유자 위임</button>
      <button class="custom-modal-danger" id="crew_delete" onclick="deleteTeam()">팀 삭제하기</button>
    </div>
  </div>
</div>

<!-- 팀 소유자 위임 모달 -->
<div id="handoverModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h4>위임할 멤버를 선택하세요</h4>
      <span class="custom-close" onclick="closeHandoverModal()">&times;</span>
    </div>
    <div class="custom-modal-body" id=crew_handover_list>
      <!-- 팀 멤버 리스트 append -->
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
      <button type="button" class="btn btn-primary" id=vote_insert_btn style="font-size:14px;"onclick="submitVote()" >투표 올리기</button>
      <button type="button" class="btn btn-primary" id=vote_update_btn  style="font-size:14px;"onclick="vote_rud('U')" >투표 수정하기</button>
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
      <button class="btn btn-primary" style="font-size:14px;" id=vote_update onclick="vote_rud('R')">수정</button>
      <button class="btn btn-primary" style="font-size:14px;" id=vote_delete onclick="vote_rud('D')">삭제하기</button>
      <button class="btn btn-primary" style="font-size:14px;" onclick="submitVoteNow()">투표하기</button>
      <button class="btn btn-light" style="font-size:14px;" onclick="closeCustomModal()">취소</button>
    </div>
  </div>
</div>
 <!-- 투표 현황 -->
<div id="voteResultModal" class="custom-modal">
  <div class="custom-modal-content">
    <div class="custom-modal-header">
      <h4 class="modal-title" id=vote_live></h4>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body3" id=vote_results>
    </div>
    <div class="custom-modal-footer">
      <button class="handover-btn" id=vote_update2 onclick="vote_rud('R')">수정</button>
      <button class="handover-btn" id=vote_delete2 onclick="vote_rud('D')">삭제</button>
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
const Authorization = localStorage.getItem("Authorization");
const create_crew_code = ${create_crew_code};
const user_code = ${user_code};
const position = ${position};
var votenum = 4;

if (position != 1) {
  $('#editCrewBtn').hide();
  $('#vote_delete').hide();
  $('#vote_delete2').hide();
}
if (position > 2) {
  $('#voteMake').hide();
  $('#noticeMake').hide();
  $('#vote_update').hide();
  $('#vote_update2').hide();
}

   clog('My position : ' + position);
   clog('My user_code : ' + user_code);

   $(document).ready(function() {
      $('#go_join').hide();
      $('#member').css('color', 'black');
      crew_deatil_select();
      crew_manage_select('');
      if (position != 1) {
         $('#wait_cnt').hide();
      }
     if(position==0){
         $('#go_join').show();
         $('#editCrewBtn').hide();
         $('#resignCrew').hide();
         $('#notice').css('pointer-events', 'none');
         $('#member').css('pointer-events', 'none');
         $('.join_info').css('pointer-events', 'none');
         $('#chatButton').hide();
     }

   });

  function crew_deatil_select() {
       $.ajax({
          url: '/crew/crew_deatil_select',
          type: 'post',
          async: false,
          data: {
             Authorization: Authorization,
             create_crew_code: create_crew_code
          },
          success: function(response) {
              $('#crew_img').attr('src', '/crew_upload/' + response[0].logo);
              $('#crew_name').text(response[0].crew_name);
              $('#teamNameDisplay').text(response[0].crew_name);
              $('#crew_ranking').text(response[0].rank + '위  ( ' + response[0].total_score + 'Km )');
              $('#addr').text(response[0].addr);
              $('#addr2').text(response[0].addr);
              $('#crew_info').text(response[0].a_s);
              $('#member_cnt').text(response[0].d_n + '명');
              $('#create_date').text(response[0].c_s);
              $('#member_age_avg').text(response[0].e_n + '세');
              $('#teamImage').attr('src', '/crew_upload/' + response[0].logo);
          },
          error: function(e) {
             console.error('Error: ', e);
          }
       });
    }

   function vote_rud(flag) {
      $.ajax({
         url: '/crew/vote_rud',
         type: 'post',
         async: false,
         data: {
            Authorization   : Authorization,
            create_crew_code: create_crew_code,
            flag            : flag,
            vote_num        : $('#vote_num').val(),
            title           : $('#voteTitle').val(),
            opt1            : $('#vote1').val(),
            opt2            : $('#vote2').val(),
            opt3            : $('#vote3').val(),
            opt4            : $('#vote4').val(),
            opt5            : $('#vote5').val(),
            endDate         : $('#voteDeadline').val()
         },
         success: function(response) {
            if(flag=='R'){
                clog(response[0].a_n);
                if(response[0].a_n>0){
                    alert('투표한 인원이 있어서 수정이 불가능합니다.');
                    return false;
                }
                $('#voteTitle').val(response[0].subject);
                $('#voteDeadline').val(response[0].enddate);
                $('#vote1').val(response[0].opt1);
                $('#vote2').val(response[0].opt2);
                $('#vote3').val(response[0].opt3);
                if(response[0].opt4!='' && votenum<5){
                    addVoteItem();
                    $('#vote4').val(response[0].opt4);
                }
                if(response[0].opt5!=''&& votenum<6){
                    addVoteItem();
                    $('#vote5').val(response[0].opt5);
                }
                openVoteModal(flag);
            }
            if(flag=='U'){
                alert('수정되었습니다.');
                closeVoteModal();
                closeCustomModal();
                $('#notice').click();
            }
            if(flag=='D'){
                closeCustomModal()
                alert('투표가 삭제되었습니다.');
                $('#notice').click();
            }
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
      console.log("Selected id: ", id);
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
            $('#crew_manage_list').html('');
            if (id == 'member') {
               crew_manage_select_member(response);
               document.querySelector('.section2').style.display = 'none';
            } else if (id == 'overview') {
               crew_overview(response);
               document.querySelector('.section2').style.display = 'block';
            } else if (id == 'notice') {
               crew_notice(response);
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
         list += response[0].f_n + ' 명이 승인을 기다리고있어요.';
         list += '   </span>';
         list += '   <img src="/img/way.png" style="width: 26px; height: 26px; padding:5px; margin-right:65px; margin-top:3px;">';
         list += '</div>';
      }
      for (var i in response) {
         var imgSrc = response[i].a_s ? response[i].a_s.trim() : 'basicimg.png';
         list += '<li class="member-item"> ';
         list += '<div class="item-flex"> ';
         list += '   <img src="/resources/uploadfile/' + imgSrc + '" class="profile-img">';
         list += '   <div class="profile-info"> ';
         list += '     <div class="info-wrapper"> ';
         list += '      <p class="name">' + response[i].b_s + '</p> ';
         if (response[i].a_n == 1) {
            list += '      <div class="label-operator" style="background-color: #e8f7ff; color: #1570ff;  font-weight: 800;">크루장</div> ';
         }
         if (response[i].a_n == 2) {
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
      console.log("Generated list: ", list);
      $('#crew_manage_list').append(list);
   }

function crew_overview(response) {
    var list = '';

    // 주요 멤버 출력
    list += '<div class="join_info" onClick="crew_manage_select(member)" style="display: flex; justify-content: space-between; align-items: center; cursor: pointer;">';
    list += '<div class="overview_title">주요 멤버</div>';
    list += '<div class="member_more">전체 보기</div>';
    list += '</div>';

    var memberCount = 0;
    for (var i = 0; i < response.length; i++) {
        if (response[i].a_n === 0) {  // a_n이 0인 경우는 주요 멤버
            if (memberCount >= 4) break;  // 멤버 5명까지만 출력
            var imgSrc = response[i].subject ? response[i].subject.trim() : 'basicimg.png';
            list += '<li class="member-item">';
            list += '<div class="item-flex">';
            list += '   <img src="/resources/uploadfile/' + imgSrc + '" class="profile-img">';
            list += '   <div class="profile-info">';
            list += '     <div class="info-wrapper">';
            list += '      <p class="name">' + response[i].writedate + '</p>';
            list += '     </div>';
            list += '   </div>';
            list += '  <div class="menu">';
            list += '   <div class="dropdown"></div>';
            list += '  </div>';
            list += '</div>';
            list += '</li>';
            memberCount++;
        }
    }
    // 최신 공지 및 투표 정보 출력
    list += '<div class="join_info" onClick="crew_manage_select(notice)" style="display: flex; justify-content: space-between; margin-top:10px;align-items: center; cursor: pointer;">';
    list += '<div class="overview_title">최신 공지</div>';
    list += '<div class="member_more">전체 보기</div>';
    list += '</div>';
    // 최신 투표 1개 출력
    var voteCount = 0;
    for (var i = 0; i < response.length; i++) {
        if (response[i].a_n == 1) {  // a_n이 1인 경우는 투표
            if (voteCount >= 1) break;  // 투표 1개까지만 출력
            list += '<li class="member-item"> ';
            list += '   <div class="item-container"> ';
            list += '      <div class="icon-container"> ';
            list += '   <img src="/img/vote.png"> ';
            list += '      </div>';
            list += '      <div class="text-container"> ';
            list += '<span class="main-text">' + response[i].subject + '</span>';
            if (response[i].b_n == 1) {
                list += '<span class="sub-text">투표 진행중</span>';
                list += '<span class="sub-text" >New</span>';
            } else if (response[i].b_n == 9) {
                list += '<span class="sub-text" style="background-color:black; color:white;">투표 마감</span>';
            }
            list += '      </div>';
            list += '   </div>';
            list += '</li>';
            voteCount++;
        }
    }
    // 최신 공지 3개 출력
    var noticeCount = 0;
    for (var i = 0; i < response.length; i++) {
        if (response[i].a_n == 2) {  // a_n이 2인 경우는 공지
            if (noticeCount >= 3) break;  // 공지 3개까지만 출력
            list += '<li class="member-item"> ';
            list += '   <div class="item-container"> ';
            list += '      <div class="icon-container"> ';
            list += '   <img src="/img/notice.png"> ';
            list += '      </div>';
            list += '      <div class="text-container"> ';
            list += '<span class="main-text">' + response[i].subject + '</span>';
            list += '<span class="sub-text" style="background-color:white; color:grey; font-size:10px;">' +  response[i].writedate + '</span>';
            list += '      </div>';
            list += '   </div>';
            list += '</li>';
            noticeCount++;
        }
    }
    $('#crew_manage_list').append(list);
}
function crew_notice(response) {
    var list = '';
    var voteClosedCount = 0; // 투표 마감된 항목의 개수를 셀 변수
 for (var i in response) {
      list += '<li class="member-item"> ';
      list += '   <div class="item-container"> ';
      list += '      <div class="icon-container"> ';

      // 진행 중인 투표
      if (response[i].a_n == 1) {
          list += '   <img src="/img/vote.png" style="margin-bottom:20px;"> ';
          list += '      </div>';
          if (response[i].b_n == 1) {
              var aa;
              if (response[i].e_n == 1) {
                  aa = "참여";
                  list += '      <div class="text-container" onClick="voteNow(' + response[i].c_n + ',1,' + response[i].usercode + ')"> ';
              } else {
                  aa = "미참여";
                  list += '<div class="text-container" onClick="voteNow(' + response[i].c_n + ',0,' + response[i].usercode + ')"> ';
              }
              list += '<div class="text-row">';
              list += '<span class="main-text">' + response[i].subject + '</span> ';
              list += '<span class="sub-text">투표 진행중</span>';
              list += '</div>';
              list += '<div class="info-row">';
              list += '<div>' + response[i].d_n + "명 참여, " + aa + '</div>';
              list += '</div>';
              list += '<div class="info-row">';
              list += '<div>' + response[i].enddate + " 까지 마감" + '</div>';
              list += '</div>';
          }
      }

      // 마감된 투표, 최대 3개까지 출력
      if (response[i].a_n == 3 && voteClosedCount < 3) {
          voteClosedCount++;  // 마감된 투표 개수를 증가시킴
          list += '   <img src="/img/vote.png" style="margin-bottom:20px;"> ';
          list += '      </div>';
          var aa;
          if (response[i].e_n == 1) {
              aa = "참여";
              list += '<div class="text-container" onClick="voteNow(' + response[i].c_n + ',9,' + response[i].usercode + ')"> ';
          } else {
              aa = "미참여";
              list += '      <div class="text-container" onClick="voteNow(' + response[i].c_n + ',9,' + response[i].usercode + ')"> ';
          }
          list += '<div class="text-row">';
          list += '<span class="main-text">' + response[i].subject + '</span> ';
          list += '<span class="sub-text" style="background-color:black; color:white;">투표 마감</span>';
          list += '</div>';
          list += '<div class="info-row">';
          list += '<div>' + response[i].d_n + "명 참여, " + aa + '</div>';
          list += '</div>';
           list += '<div class="info-row">';
          list += '<div>' + response[i].enddate + " 까지 마감" + '</div>';
          list += '</div>';
      }

       if (response[i].a_n == 2) {
          list += '     <img src="/img/notice.png" style="margin-bottom:20px;"> ';
          list += '  </div>';
          list += '  <div class="text-container" onClick="noticeDetail(' + response[i].c_n + ')"> ';
          list += '     <div class="text-row">';
          list += '         <span class="main-text">' + response[i].subject + '</span> ';
          list += '     </div>';
          list += '     <div class="info-row">';
          list += '         <div style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width:480px">' + response[i].content + '<div>';
          list += '         <div>' + "업데이트 : "+  response[i].enddate +'<div>';
          list += '     <div>';
       }
       list += '      </div>';
       list += '      <div class="text-container"> ';
       list += '      </div> ';
       list += '   </div> ';
       list += '</li> ';
    }
    $('#crew_manage_list').append(list);
 }



   function openCustomModal(usercode, nickname, user_position) {
      $('#usercode').val(usercode);
      $('#member_name').text(nickname);
      if (position == 1) {
         $('#manage2').show();
         $('#manage3').show();
         $('#out').show();
      } else {
         $('#manage2').hide();
         $('#manage3').hide();
         $('#out').hide();
      }
      if (user_position == 2) $('#manage2').hide();
      if (user_position == 3) $('#manage3').hide();

      document.getElementById('customModal').style.display = 'block';
   }

   function go_request_wait() {
       $.ajax({
           url: '/crew/go_crewApp',  // 서버에 전송할 URL
           type: 'POST',  // POST 방식으로 전송
           data: {
               Authorization     : Authorization,
               create_crew_code  : create_crew_code,
               position          : position
           },
           success: function(response) {
               window.location.href = '/crew/crewApp'; // 페이지 이동 (URL에 파라미터 노출되지 않음)            } else {
           },
           error: function(error) {
               console.log('에러 발생:', error);
           }
       });

   }

   function crewRevise() {
        $.ajax({
            url: '/crew/go_crewRevise',
            type: 'POST',  // POST 방식으로 전송
            data: {
                Authorization    : Authorization,
                create_crew_code : create_crew_code,
                user_code        : user_code,
            },
            success: function(response) {
                window.location.href = '/crew/crewRevise';
            },
            error: function(error) {
                console.log('에러 발생:', error);
            }
        });
   }

   function member_manage(element, flag) {
      var id = element.id;
      if(id===undefined)id=flag;
      var reason = '';
      var checkedValues = [];
      if (id == 'report') {
         $('input[name="report_reason"]:checked').each(function() {
            checkedValues.push($(this).val());
         });
         reason = checkedValues.join(',');
      }
      if (id == 'out') {
          var confirmation = confirm('정말 이 유저를 강퇴하시겠습니까?');
          if (!confirmation) {
              return; // 사용자가 취소하면 함수 종료
          }
      }
      $.ajax({
         url: '/crew/member_manage',
         type: 'post',
         async: false,
         data: {
            Authorization: Authorization,
            create_crew_code: create_crew_code,
            id: id,
            usercode: $('#usercode').val(),
            reason: reason,
            reason_text: $('#report_content').val()
         },
         success: function(response) {
            if (response == 1) alert('운영진으로 추가되었습니다.');
            if (response == 4) alert('일반크루로 변경되었습니다.');
            if (response == 2) alert('신고접수가 되었습니다.');
            if (response == 3) alert('유저가 강퇴되었습니다.');
            closeCustomModal();
            closeRejectModal();
            $('#member').click();
         },
         error: function(e) {
            console.error('Error: ', e);
         }
      });
   }

   function openRejectModal() {
      document.getElementById("rejectModal").style.display = "block";
   }

   function closeRejectModal() {
      document.getElementById("rejectModal").style.display = "none";
   }

   function confirmRejection() {
      alert("신고 사유가 제출되었습니다.");
      closeRejectModal();
   }

   document.getElementById("editCrewBtn").addEventListener("click", function() {
      document.getElementById("informationModal").style.display = "block";
   });

   document.getElementById("handoverCrewBtn").addEventListener("click", function() {
      document.getElementById("informationModal").style.display = "none";
      document.getElementById("handoverModal").style.display = "block";
   });

   function closeHandoverModal() {
      document.getElementById("handoverModal").style.display = "none";
      document.getElementById("informationModal").style.display = "block";
   }

   function handoverOwnership() {
      alert("팀 소유자가 위임되었습니다.");
      closeHandoverModal();
   }

   function closeCustomModal() {
      document.getElementById("customModal").style.display = "none";
      document.getElementById("informationModal").style.display = "none";
      document.getElementById("resignModal").style.display = "none";
      document.getElementById("voteNowModal").style.display = "none";
      document.getElementById("voteResultModal").style.display = "none";
   }

   function closeNicknameModal() {
      document.getElementById('nicknameModal').style.display = 'none';
   }

   function openResignModal(flag) {
      if(flag!=='U')document.getElementById("resignModal").style.display = "block";
   }

   function resignTeam() {
       // 탈퇴 확인 메시지
       var confirmation = confirm("정말 팀에서 탈퇴하시겠습니까?");

       // 사용자가 확인을 누른 경우에만 탈퇴 처리
       if (confirmation) {
           $.ajax({
               url: '/crew/resign_team',
               type: 'POST',
               async: false,
               data: {
                   Authorization: Authorization,
                   create_crew_code: create_crew_code,
                   position: position
               },
               success: function(response) {
                   if (response == 0) {
                       alert("크루원이 있어서 탈퇴가 불가능합니다.");
                       return false;
                   } else {
                       alert("팀에서 탈퇴되었습니다.");
                       window.location.href = '/crew/crewList';
                   }
               },
               error: function(e) {
                   console.error('Error: ', e);
               }
           });
           closeCustomModal();
       }
   }

   function addVoteItem() {
      const voteItems = document.getElementById('voteItems');
      const newItem = document.createElement('div');
      newItem.classList.add('vote-item');

      newItem.innerHTML =
         '<input type="text" class="input-field" name=vote_opt id="vote' + votenum + '" placeholder="항목 입력">' +
         '<button class="remove-item-button" onclick="removeVoteItem(this)">&times;</button>';
      voteItems.appendChild(newItem);
      votenum++;
      if (votenum > 5) $('#addVoteBtn').hide();
   }

   function removeVoteItem(button) {
      const voteItem = button.parentElement;
     clog(button);
      voteItem.remove();
      votenum--;
      if (votenum < 6) $('#addVoteBtn').show();
   }

   function showVoterList(voters) {
      document.getElementById('nicknameModal').style.display = 'block';
      $('#nickname_list').html('<li>' + voters + '</li>');
   }

   function openVoteModal(flag) {
      closeCustomModal();

        if(flag=='R'){
          $('#vote_insert_btn').hide();
          $('#vote_update_btn').show();
        }
        else{
          votenum = 4;
          $('.remove-item-button').remove();//추가된 칸 지우기
          $('#vote4').remove();//추가된 칸 지우기
          $('#vote5').remove();//추가된 칸 지우기
          $('#vote_insert_btn').show();
          $('#addVoteBtn').show();
          $('#vote_update_btn').hide();
          $('#voteDeadline').val('');
          $('#voteTitle').val('');
          $('#vote1').val('');
          $('#vote2').val('');
          $('#vote3').val('');
        }
      document.getElementById('voteModal').style.display = 'block';
   }

   function closeVoteModal() {
      document.getElementById('voteModal').style.display = 'none';
      openResignModal('U');
   }

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
            Authorization: Authorization,
            create_crew_code: create_crew_code,
            title: title,
            opt1: $('#vote1').val(),
            opt2: $('#vote2').val(),
            opt3: $('#vote3').val(),
            opt4: $('#vote4').val(),
            opt5: $('#vote5').val(),
            endDate: deadline
         },
         success: function(response) {
            alert('투표가 제출되었습니다.');
            $('#notice').click();
         },
         error: function(e) {
            console.error('Error: ', e);
         }
      });
      closeVoteModal();
   }

   function voteNow(vote_num, flag, vote_user_code) {
      $('#vote_num').val(vote_num);
      $('#vote_user_code').val(vote_user_code);
      if(vote_user_code == user_code){
          if(position>2){
              $('#vote_update').hide();
              $('#vote_update2').hide();
          }
          else{
              $('#vote_update').show();
              $('#vote_update2').show();
          }
      }
      else {
          if(position==1){
              $('#vote_update').show();
              $('#vote_update2').show();
          }
          else {
               $('#vote_update').hide();
               $('#vote_update2').hide();
          }
      }
      $.ajax({
         url: '/crew/vote_select',
         type: 'post',
         async: false,
         data: {
            Authorization: Authorization,
            create_crew_code: create_crew_code,
            vote_num: vote_num
         },
         success: function(response) {
            $('#vote_list').html('');
            $('#vote_results').html('');
            if(user_code != response[0].usercode && position!=1)$('#editCrewBtn').hide();
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
               var arr = ['a', 'b', 'c', 'd', 'e'];
               var key = 'opt' + i;
               var key2 = arr[i - 1] + '_s';

               if (response[0][key] == '') break;
               var arr_length = response[0][key2] ? response[0][key2].split(',').length : 0;
               var voters = response[0][key2] ? response[0][key2] : '';

               // 클릭 가능 여부 결정
               if (arr_length > 0) {
                   list2 += '<div class="result-row" style="cursor: pointer;" onclick="showVoterList(\'' + voters + '\')">';
               } else {
                   list2 += '<div class="result-row">';
               }
               list2 += '    <span>' + response[0][key] + '</span>';
               list2 += '    <span>' + arr_length + '명</span>';
               list2 += '</div>';
               list2 += '<div class="progress-bar">';
               list2 += '    <div id="progress-vote' + i + '" class="progress" style="width: 0%;"></div>';
               list2 += '</div>';
            }
            list2 += '</div>';
            $('#vote_results').html(list2);
            if (response[0].f_s ===null&&flag==0) {
               document.getElementById('voteNowModal').style.display = 'block';
            }
            if(flag==9){
                $('#vote_update2').hide();
                $('#vote_live').html('')
                $('#vote_live').html('<strong>투표 결과</strong>');
            }
            else {
                $('#vote_live').html('')
                $('#vote_live').html('<strong>투표 현황</strong>');
            }
            if(flag==9||flag==1){
               document.getElementById('voteResultModal').style.display = 'block';
            }

         },
         error: function(e) {
            console.error('Error: ', e);
         }
      });
   }

   function submitVoteNow() {
      var selectedOption = $('input[name="voteOption"]:checked').val();
      $.ajax({
         url: '/crew/vote_insert',
         type: 'post',
         async: false,
         data: {
            Authorization: Authorization,
            selectedOption: selectedOption,
            vote_num: $('#vote_num').val()
         },
         success: function(response) {
            if (response == 0) {
               alert('이미 투표하셨습니다.');
               return false;
            } else {
               alert('투표가 제출되었습니다.');
               voteNow($('#vote_num').val(), 1);
               $('#notice').click();
            }
         },
         error: function(e) {
            console.error('Error: ', e);
         }
      });
      document.getElementById('voteNowModal').style.display = 'none';
      document.getElementById('voteResultModal').style.display = 'block';
   }

<!-- 공지사항 등록 -->

function submitNotice() {
    var form = $('#updateNoticeForm')[0]; // 폼 데이터 가져오기
    var formData = new FormData(form); // FormData 객체 생성

    // URL에서 가져온 create_crew_code와 user_code 값을 FormData에 추가
    formData.append('create_crew_code', create_crew_code);
    formData.append('user_code', user_code);

    // 유효성 검사: 제목과 내용을 확인
    var title = $('#noticeTitle').val().trim();
    var content = $('#noticeContent').val().trim();

    if (title === '') {
        alert('제목을 입력해주세요.');
        return false;
    }

    if (content === '') {
        alert('공지 내용을 입력해주세요.');
        return false;
    }

    // 다중 파일 처리: 각각의 파일을 FormData에 추가 (이미지 파일이 있을 때만 추가)
    var files = $('#noticeImage')[0].files;
    if (files.length > 0) { // 파일이 있을 때만 추가
        for (var i = 0; i < files.length; i++) {
            formData.append('noticeImages[]', files[i]); // 파일을 FormData에 추가
        }
    }

    // AJAX로 서버에 데이터 전송
    $.ajax({
        url: '/crew/createNotice', // 서버의 Controller URL
        type: 'POST',
        headers: {
            Authorization: localStorage.getItem('Authorization')  // 헤더로 Authorization 전송
        },
        data: formData,
        processData: false, // FormData 사용 시 false로 설정
        contentType: false, // FormData 사용 시 false로 설정
        success: function(response) {
            console.log("서버 응답:", response);
            if (response === 1) {
                alert('공지사항이 성공적으로 등록되었습니다.');
                closeNoticeModal(); // 모달 닫기
                resetNoticeForm();  // 폼 리셋
            } else {
                alert('공지사항 등록 중 오류가 발생했습니다.');
            }
        },
        error: function(error) {
            console.error("오류 발생:", error);
            alert('공지사항 등록 중 오류가 발생했습니다.');
        }
    });
}


function closeNoticeModal() {
    $('#noticeCreateModal').hide(); // 모달 닫기 (display: none)
}

function resetNoticeForm() {
    // 폼 필드 초기화
    $('#noticeTitle').val('');
    $('#noticeContent').val('');
    $('#noticeImage').val('');
    $('#previewContainer').html(''); // 미리보기 이미지 리셋
}

   function updateVoteResults(votes) {
      let totalVotes = votes.reduce(function(acc, vote) {
         return acc + vote.count;
      }, 0);

      $.each(votes, function(index, vote) {
         let percentage = (vote.count / totalVotes) * 100;

         $(`#progress-${vote.id}`).css({
            width: percentage + '%',
            backgroundColor: 'orange'
         });

         $(`#count-${vote.id}`).text(vote.count + '명');
      });
   }

   let votes = [
      { id: 'vote1', count: 1 },
      { id: 'vote2', count: 3 },
      { id: 'vote3', count: 0 },
      { id: 'vote4', count: 0 }
   ];

   $(document).ready(function() {
      updateVoteResults(votes);
   });

   function openNoticeModal() {
      closeCustomModal();
      document.getElementById('noticeCreateModal').style.display = 'block';
   }

   function closeNoticeModal() {
      document.getElementById('noticeCreateModal').style.display = 'none';
      document.getElementById('resignModal').style.display = 'block';
   }

   function deletePreview() {
      document.getElementById('previewContainer').style.display = 'none';
      document.getElementById('imagePreview').src = '';
   }

   function previewImages(event) {
      const previewContainer = document.getElementById('previewContainer');
      const files = Array.from(event.target.files);

      files.forEach(file => {
         const reader = new FileReader();
         reader.onload = function(e) {
            const imageContainer = document.createElement('div');
            imageContainer.style.position = 'relative';

            const img = document.createElement('img');
            img.src = e.target.result;
            imageContainer.appendChild(img);

            const deleteButton = document.createElement('button');
            deleteButton.textContent = '지우기';
            deleteButton.classList.add('delete-btn');
            deleteButton.onclick = function() {
               imageContainer.remove();
            };

            imageContainer.appendChild(deleteButton);
            previewContainer.appendChild(imageContainer);
         };
         reader.readAsDataURL(file);
      });
   }
// 크루 위임 맴버 불러오기
function crew_manage_handover(element) {
    var id = element.id;
    const user_code = urlParams.get('user_code').trim();  // 공백 제거 후 전역변수에서 가져오기
    console.log("Selected id: ", id);
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
            $('#crew_handover_list').html(''); // 기존 내용을 비움
            var list = '';

            if (id == 'handoverCrewBtn') {
                // user_code와 동일한 user를 제외하고 position이 2인 사용자만 필터링
                var filteredResponse = response.filter(function(item) {
                    return String(item.usercode).trim() !== String(user_code).trim() && item.a_n == 2; // usercode 다르고 position이 2인 경우만
                });

                // 필터링된 결과가 없을 경우 처리
                if (filteredResponse.length === 0) {
                    list = '<p>위임할 멤버가 없습니다</p>';  // 멤버가 없을 때 표시할 메시지
                } else {
                    // 필터링된 멤버가 있을 경우 리스트 생성
                    for (var i in filteredResponse) {
                      var imgSrc = filteredResponse[i].a_s ? filteredResponse[i].a_s.trim() : 'basicimg.png';
                        list += '<label class="team-member"> ';
                        list += '<input type="radio" name="teamOwner" value="' + filteredResponse[i].usercode + '"> ';
                        list += '   <img src="/resources/uploadfile/' + imgSrc + '" class="team-profile"> ';
                        list += '   <span class="team-name"> ' + filteredResponse[i].b_s + '</span> ';
                        if (filteredResponse[i].a_n < 3) {
                            list += '      <div class="label-operator" style="margin-bottom:4px;">운영진</div> ';
                        }
                        list += '</label>';
                    }
                }
                console.log("Generated list: ", list);
                $('#crew_handover_list').append(list); // 리스트 또는 메시지 추가
            }
        },
        error: function(e) {
            console.error('Error: ', e);
        }
    });
}

function go_crew_detail() {
    $.ajax({
        url: '/crew/go_crewDetail',  // 서버에 전송할 URL
        type: 'POST',  // POST 방식으로 전송
        data: {
            Authorization: Authorization,  // 토큰 또는 기타 데이터
            create_crew_code: create_crew_code  // 전송할 데이터
        },
        success: function(response) {
            window.location.href = '/crew/crewDetail'; // 페이지 이동 (URL에 파라미터 노출되지 않음)            } else {
        },
        error: function(error) {
            console.log('에러 발생:', error);
        }
    });
}

</script>
