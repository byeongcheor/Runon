<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="${pageContext.request.contextPath}/js/crew.js" type="text/javascript"></script>
<link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
      crossorigin="anonymous"
    />
<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
      crossorigin="anonymous"
    ></script>
<link rel="stylesheet" href="/css/crewApp.css" type="text/css">
<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg" />
    </div>
    <div class="content-body">
        <div class="content-full">
            <div class="join-container">
                <section class="menu-container">
                    <span class="left_img" onclick="go_crew_manage()">
                        <img src="/img/left.png" style="width: 25px; height: 25px; ">
                    </span>
                    <div class="menu-title">
                        <div class="crew_profileimage">
                            <div class="profileBox">
                                <img src="" class="profileImg" id=crew_logo>
                            </div>
                        </div>
                        <p class="menu-title-name" id=crew_name></p>
                    </div>
                </section>
                <section class="team-container">
                   <ul class="team-list" id='app_list'>
                   </ul>
                </section>
            </div>
        </div>
    </div>
</div>
<!-- 가입신청 모달 -->
<div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
   <div class="modal-dialog modal-lg modal-dialog-centered">
     <div class="modal-content" style="height: 400px;">
       <div class="modal-header">
         <h5 class="modal-title" id="joinModalLabel">가입 신청</h5>
         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
       </div>
       <div class="modal-body">
         <textarea class="custom-textarea" id="join_content"></textarea>
       </div>
       <div class="modal-footer" style="display: flex; justify-content: space-between;">
         <input type=hidden id=usercode>
         <input type=hidden id=request_code>
         <button type="button" class="custom-button" style="width: 48%; background-color: #ccff00; color:black;" data-bs-dismiss="modal" id="yes" onClick="app(this);">가입 승인</button>
         <button type="button" class="btn modal-action-button" style="width: 48%;" data-bs-dismiss="modal" id=no onClick="crew_reject()">거절 하기</button>
       </div>
     </div>
   </div>
 </div>
<!-- 거절 사유 선택 모달 -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
   <div class="modal-dialog modal-dialog-centered">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title" id="rejectModalLabel">거절 사유를 선택해주세요</h5>
         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
       </div>
       <div class="modal-body">
         <div class="form-check">
           <input class="form-check-input" type="checkbox" name=reason id="reason1"  value='1'>
           <label class="form-check-label" for="reason1">모집이 마감됐어요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" name=reason id="reason2" value='2'>
           <label class="form-check-label" for="reason2">성별이 맞지 않아요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" name=reason id="reason3" value='3'>
           <label class="form-check-label" for="reason3">나이가 맞지 않아요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" name=reason id="reason4" value='4'>
           <label class="form-check-label" for="reason4">소개가 부족해요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" name=reason id="reason5" value='5'>
           <label class="form-check-label" for="reason5">소개가 부적절해요 (광고, 도박 등)</label>
         </div>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
         <button type="button" class="btn btn-primary" onClick="app(this);">확인</button>
       </div>
     </div>
   </div>
</div><script>
var Authorization = localStorage.getItem("Authorization");
const crew_code = ${create_crew_code};
const position = ${position};

clog('crew_code : '+crew_code);
clog('position : '+position);


if(position!=1){
$('#yes').hide();
$('#no').hide();
}
    function openModal(usercode, request_code) {
        var myModal = new bootstrap.Modal(document.getElementById('joinModal'));
        myModal.show();
        $('#usercode').val(usercode);
        $('#request_code').val(request_code);
        $.ajax({
           url: '/crew/crew_wait_detail',
           type: 'post',
           async: false,
           data: {
               Authorization    : Authorization,
               create_crew_code : crew_code,
               usercode         : usercode,
               request_code     : request_code
           },
           success: function(response) {
               $('#join_content').text(response[0].content);
               $('#join_content').prop('disabled', true);
               clog(response[0].content);
               if(response[0].a_n==0){
                    $('#yes').show();
                    $('#no').show();
               }
               else{
                  $('#yes').hide();
                  $('#no').hide();
               }

           },
           error: function(e) {
               console.error('Error: ', e);
           }
        });
      }
    $(document).ready(function() {
        crew_wait_select();
    });


    function crew_wait_select(usercode){
        var list ='';
        $.ajax({

            url: '/crew/crew_app_select',
            type: 'post',
            async: false,
            data: {

                Authorization    : Authorization,
                create_crew_code : crew_code
            },
            success: function(response) {
                console.log("response--->>",response)
             $('#crew_logo').attr('src', '/crew_upload/' + response[0].logo);
             $('#crew_name').text(response[0].crew_name+'/멤버관리');
                for (var i in response) {
                    var font_color = response[i].b_n > 1? "red":"#0d6efd";
                    list += '<li class="team-item" style="display: flex; justify-content: space-between; width: 100%;"> ';
                    list += '	<a class="team-link" style="flex-grow: 1;"> ';
                    list += '	  <div class="team-emblem-wrapper"> ';
                    list += '		<img src="/resources/uploadfile/'+response[i].profile_img+ '"class="team-emblem"> ';
                    list += '	  </div> ';
                    list += '	  <div class="team-content"> ';
                    list += '		<div class="info-name-wrapper"> ';
                    list += '		  <span class="info-name">'+response[i].nickname+'</span> ';
                    list += '		  <span class="info-time">'+response[i].a_s+'</span> ';
                    list += '		</div> ';
                    list += '		<div class="info-desc"> ';
                    var arr=response[i].addr.split(' ');
                    list += '		  <span>'+response[i].gender+" · "+arr[0]+" " +arr[1]+" · "+response[i].a_n+'세</span> ';
                    list += '		</div> ';
                    list += '	  </div> ';
                    list += '	  <div class="team_status"> ';
                    list += '		  <span class="team__request" style="color:'+font_color+'">';
                    if (response[i].b_n == 0) list += '승인을 기다리고있어요';
                    if (response[i].b_n == 1) list += '가입을 승인했어요 ';
                    if (response[i].b_n == 9) list += '신청을 거절했어요 ';
                    if (response[i].d_n == 1) list += '<br><span class="team__request" style="color:red">'+response[i].c_s + '에 강퇴된 유저입니다.</span>';
                    if (response[i].d_n == 2) list += '<br><span class="team__request" style="color:red">'+response[i].c_s + '에 탈퇴한 유저입니다.</span>';
                    list+='           </span> ';
                    list += '	  </div> ';
                    list += '	</a> ';
                    list += '	 <div class="join-check-button" style="display: flex; justify-content: flex-end; align-items: center;"> ';
                    if(position==1){
                        list += '		<button type="submit" class="custom-button" onclick="openModal('+response[i].usercode+','+response[i].c_n+')">신청확인</button> ';
                    }
                    list += '	 </div> ';
                    list += '  </li> ';
                }
                $('#app_list').append(list);
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }
    function app(element){
        var id = element.id===undefined?'member': element.id;
        var checkedValues = [];
        var reason='';
        var status = id=='yes'?1:9;
        if(status==9){
            $('input[name="reason"]:checked').each(function() {
                checkedValues.push($(this).val());
            });
            reason=checkedValues.join(',');
        }
        $.ajax({
            url: '/crew/app',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : crew_code,
                status           : status,
                usercode         : $('#usercode').val(),
                reason           : reason,
                request_code     : $('#request_code').val()

            },
            success: function(response) {

                if(status==1){
                    if(response==9) {
                        alert('이미 같은 크루입니다.');
                        return false;
                    }
                    alert('크루신청을 수락했습니다.');
                    location.reload(true);
                }
                if(status==9){
                    alert('크루신청을 거절했습니다.');
                    $('#rejectModal').hide();
                    location.reload(true);
                }

            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }
function crew_reject() {
    // 첫 번째 모달을 숨기고 거절 사유 모달을 보여줌
    $('#joinModal').modal('hide');
    $('#rejectModal').modal('show');
}

function confirmRejection() {
    // 거절 확인 로직 (선택된 사유 확인 등)
    alert('거절 사유가 선택되었습니다.');
}

function go_crew_manage() {
        $.ajax({
            url: '/crew/go_crewManage',  // 서버에 전송할 URL
            type: 'POST',  // POST 방식으로 전송
            data: {
                Authorization: Authorization,  // 토큰 또는 기타 데이터
                create_crew_code: crew_code,  // 전송할 데이터
                flag: 1  // 전송할 데이터
            },
            success: function(response) {
                window.location.href = '/crew/crewManage'; // 페이지 이동 (URL에 파라미터 노출되지 않음)            } else {
            },
            error: function(error) {
                console.log('에러 발생:', error);
            }
        });
        $('#createNewTeamModal').modal('hide');
    }


</script>