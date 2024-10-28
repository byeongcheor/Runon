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

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg" />
    </div>
    <div class="content-body">
        <div class="content-full">
            <div class="join-container">
                <section class="menu-container">
                    <div class="menu-title">
                        <p class="menu-title-name"> 📝 가입 신청 내역</p>
                    </div>
                    <div class="menu-desc">
                        <p>14일 동안 팀에서 확인하지 않으면</p>
                        <p>자동으로 신청서가 취소돼요</p>
                    </div>
                </section>
                <section class="team-container">
              <ul class="team-list" id='team_list'>
                    </ul>
                </section>
            </div>
        </div>
    </div>
</div>
<!-- 모달 창 -->
   <div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true" data-bs-backdrop="static">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="joinModalLabel">내 신청</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p class="modal-subtitle" id='write_date'></p>
            <pre class="text-wrapper" id='content'></pre>
          <div id=cancel_check_box class="rejected_list"></div>
          </div>
          <div class="modal-footer">
            <button type="button" data-bs-dismiss="modal" id=cancel_btn onClick="crew_join_delete();" >신청 취소하기</button>
          </div>
        </div>
      </div>
    </div>
<script>
var Authorization = localStorage.getItem("Authorization");
var create_crew_code;

    function openModal(crew_code, request_code) {
        create_crew_code = crew_code;
        var myModal = new bootstrap.Modal(document.getElementById('joinModal'));
        myModal.show();
        var list = '';
        clog(crew_code);
        clog(request_code);
        $.ajax({
            url: '/crew/crew_wait_detail',
            type: 'post',
            async: false,
            data: {
                Authorization    : Authorization,
                create_crew_code : crew_code,
                request_code     : request_code
            },
            success: function(response) {
                $('#write_date').text(response[0].writedate);
                $('#content').text(response[0].content);
                $('#cancel_check_box').html('');

                var valuesToCheck = response[0].a_s;
                var valuesArray = valuesToCheck.split(',');

                if (response[0].a_n == 0) {
                    $('#cancel_btn').show();
                }
                if (response[0].a_n == 1) {
                    $('#cancel_btn').hide();
                }

                if (response[0].a_n == 9) {
                    $('#cancel_btn').hide();

                    var options = [
                        { id: 'reason1', value: '1', label: '모집이 마감됐어요' },
                        { id: 'reason2', value: '2', label: '성별이 맞지 않아요' },
                        { id: 'reason3', value: '3', label: '나이가 맞지 않아요' },
                        { id: 'reason4', value: '4', label: '소개가 부족해요' },
                        { id: 'reason5', value: '5', label: '소개가 부적절해요 (광고, 도박 등)' }
                    ];
                    list += '<div class="rejected_title">';
                    list += '    <span class="reason-text">거절 이유</span>';
                    list += '</div>';

                    // 값이 존재하는 항목만 출력
                    options.forEach(function(option) {
                        if (valuesArray.includes(option.value)) {
                            list += '<div class="rejected_text">';
                            list += '    <div class="form-reason">';
                            list += '        <li class="reason-text">' + option.label + '</li>';
                            list += '    </div>';
                            list += '</div>';
                        }
                    });

                    $('#cancel_check_box').append(list);
                }
            },
            error: function(e) {
                /*console.error('Error: ', e);*/
            }
        });
    }

    $(document).ready(function() {
        crew_wait_select();
    });

    function crew_wait_select(){
        var list ='';
        $.ajax({
            url: '/crew/crew_wait_select',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization
            },
            success: function(response) {
                for (var i in response) {
                    var font_color = response[i].a_n > 1? "red":"blue";
                    list += '<li class="team-item" style="display: flex; justify-content: space-between; width: 100%;"> ';
                    list += '<a class="team-link" style="flex-grow: 1;"> ';
                    list += '<img src="/crew_upload/'+response[i].logo+'" class="team-emblem" onClick="crew_page_detail(' + response[i].create_crew_code+','+response[i].crew_write_code + ')"> ';
                    list += '<div class="team-content"> ';
                    list += '<div style="display: flex; align-items: center;"> ';
                    list += '<span class="team-name" style="font-size: 18px; font-weight: bold;"onClick="crew_page_detail(' + response[i].create_crew_code+','+response[i].crew_write_code + ')">'+response[i].crew_name+'</span> ';
                    list += '<span class="cancel-notice" style="font-size: 16px; color: '+font_color+'; margin-left: 10px;"onClick="crew_page_detail(' + response[i].create_crew_code+','+response[i].crew_write_code + ')"> ';
                    if (response[i].a_n == 0) list += '승인을 기다리고있어요';
                    if (response[i].a_n == 1) list += '가입을 승인했어요 ';
                    if (response[i].a_n == 9) list += '팀에서 신청을 취소했어요 ';
                    list += '</span> ';
                    list += '</div> ';
                    list += '</div> ';
                    list += '</a> ';
                    list += '<div class="join-check-button" style="display: flex; justify-content: flex-end; align-items: center;"> ';
                    list += '<button type="submit" class="custom-button" onClick="openModal('+response[i].create_crew_code+','+response[i].b_n+')"> ';
                    list += '신청 확인 ';
                    list += '</button> ';
                    list += '</div> ';
                }   list += '</li> ';
                $('#team_list').append(list);
            },
            error: function(e) {
                /*console.error('Error: ', e);*/
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
                /*console.error('Error: ', e);*/
            }
        });
    }
   function crew_page_detail(create_crew_code, crew_write_code) {
         $.ajax({
             url: '/crew/go_crewDetail',  // 서버에 전송할 URL
             type: 'POST',  // POST 방식으로 전송
             data: {
                 Authorization: Authorization,  // 토큰 또는 기타 데이터
                 create_crew_code: create_crew_code  // 전송할 데이터
             },
             success: function(response) {
                if(response=="false"){
                     alert("모집이 마감된 글 입니다.")
                     return false;
                }
                 window.location.href = '/crew/crewDetail'; // 페이지 이동 (URL에 파라미터 노출되지 않음)            } else {
             },
             error: function(error) {
                 /*console.log('에러 발생:', error);*/
             }
         });
         $('#createNewTeamModal').modal('hide');
     }




</script>