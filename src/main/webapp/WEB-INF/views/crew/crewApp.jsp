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
<link rel="stylesheet" href="/css/crewWait.css" type="text/css">
<link rel="stylesheet" href="/css/crewApp.css" type="text/css">
<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg" />
    </div>
    <div class="content-body">
        <div class="content-full">
            <div class="join-container">
                <section class="menu-container">
                    <div class="menu-title">
                        <div class="crew_profileimage">
                            <div class="profileBox">
                                <img src="/crew_upload/crewlog43.png" class="profileImg">
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
         <button type="button" class="custom-button" style="width: 48%; background-color: #ccff00; color:black;" data-bs-dismiss="modal" id="yes" onClick="app(this);">가입 승인</button>
         <button type="button" class="btn modal-action-button" style="width: 48%;" data-bs-dismiss="modal" onClick="crew_reject()">거절 하기</button>
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
           <input class="form-check-input" type="checkbox" id="reason1">
           <label class="form-check-label" for="reason1">모집이 마감됐어요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" id="reason2">
           <label class="form-check-label" for="reason2">성별이 맞지 않아요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" id="reason3">
           <label class="form-check-label" for="reason3">나이가 맞지 않아요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" id="reason4">
           <label class="form-check-label" for="reason4">소개가 부족해요</label>
         </div>
         <div class="form-check">
           <input class="form-check-input" type="checkbox" id="reason5">
           <label class="form-check-label" for="reason5">소개가 부적절해요 (광고, 도박 등)</label>
         </div>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
         <button type="button" class="btn btn-primary" onClick="confirmRejection();">확인</button>
       </div>
     </div>
   </div>
</div>
<script>
var Authorization = localStorage.getItem("Authorization");
const urlParams = new URLSearchParams(window.location.search);
const crew_code = urlParams.get('create_crew_code');
    function openModal(usercode) {
        var myModal = new bootstrap.Modal(document.getElementById('joinModal'));
        myModal.show();
        $('#usercode').val(usercode);
        $.ajax({
           url: '/crew/crew_wait_detail',
           type: 'post',
           async: false,
           data: {
               Authorization    : Authorization,
               create_crew_code : crew_code,
               usercode         : usercode
           },
           success: function(response) {
               $('#join_content').text(response[0].content);
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
            $('#crew_name').text(response[0].crew_name+'/멤버관리');
                for (var i in response) {
                    var font_color = response[i].b_n > 1? "red":"blue";
                    list += '<li class="team-item" style="display: flex; justify-content: space-between; width: 100%;"> ';
                    list += '	<a class="team-link" style="flex-grow: 1;"> ';
                    list += '	  <div class="team-emblem-wrapper"> ';
                    list += '		<img src="/crew_upload/51b0be7d-0bfa-47d0-897a-40740b212cf6_a8.png" class="team-emblem" onclick="crew_page_detail(36,32)"> ';
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
                    list += '		  <span class="team__request">';
                    if (response[i].b_n == 0) list += '승인을 기다리고있어요';
                    if (response[i].b_n == 1) list += '가입을 승인했어요 ';
                    if (response[i].b_n == 9) list += '신청을 취소했어요 ';
                    list+='           </span> ';
                    list += '	  </div> ';
                    list += '	</a> ';
                    list += '	 <div class="join-check-button" style="display: flex; justify-content: flex-end; align-items: center;"> ';
                    list += '		<button type="submit" class="custom-button" onclick="openModal('+response[i].usercode+')">신청확인</button> ';
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
    function crew_join_delete(){
        $.ajax({
            url: '/crew/join_delete',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization,
                create_crew_code : create_crew_code
            },
            success: function(result) {
                $('#crew_request_delete').hide();
                $('#crew_request_btn').show();
                alert('가입신청이 취소되었습니다.');
                window.location.reload();
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }
    function crew_page_detail(create_crew_code, crew_write_code) {
        window.location.href = '/crew/crewManage?create_crew_code=' + create_crew_code;
    }
    function app(element){
        var id = element.id===undefined?'member': element.id;
       clog(id);
        /*$.ajax({
                url: '/crew/app',
                type: 'post',
                async: false,
                data: {
                    Authorization    : Authorization,
                    create_crew_code : create_crew_code,
                    id               : id,
                    usercode         : $('#usercode').val()
                },
                success: function(response) {
                    if (id=='member')crew_manage_select_member(response);
                },
                error: function(e) {
                    console.error('Error: ', e);
                }
        });*/

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

</script>