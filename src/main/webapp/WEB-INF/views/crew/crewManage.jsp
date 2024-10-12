<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/js/crew.js" type="text/javascript"></script>

<link rel="stylesheet" href="/css/crewManage.css" type="text/css">

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg"/>
    </div>
    <div class="content_body">
        <div class="content_left">
            <section class="section3">
                <div class="profile_container">
                    <div class="names">
                        <h1 id='crew_name'></h1>
                        <p id='addr'></p>
                        <p id='crew_info'></p>
                    </div>

                    <div class="profileimage">
                        <div class="imgContainer">
                            <img id=crew_img>
                        </div>
                    </div>
                </div>
                <div class="editCrew">
                    <button type="button" id="editCrewBtn">크루정보변경</button>
                    <button type="button" id="editCrewBtn" style="font-weight: bold; font-size: 24px;">&#8943;</button>
                </div>
                <div class="statis">
                    <p style="font-weight: 700;">팀원변화</p>
                </div>
            </section>
        </div>
        <div class="content_right">
            <section class="section1">
              <div class="section_nav">
                <ul>
                  <li id=member name=crew_select onClick="crew_manage_select(this)">멤버</li>
                  <li id=notice name=crew_select onClick="crew_manage_select(this)">공지</li>
                  <li id=manage name=crew_select onClick="crew_manage_select(this)">크루관리</li>
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
                        <span class="crew_imogi">📍</span>
                        <span class="crew_addr">활동지역</span>
                        <span class="crew_addr2" id="addr2"></span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🏃‍</span>
                        <span class="crew_addr">️멤버수</span>
                        <span class="crew_addr2" id=member_cnt></span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🔍‍</span>
                        <span class="crew_addr">평균나이</span>
                        <span class="crew_addr2" id=member_age_avg></span>
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
      <span class="custom-modal-title">장재성</span>
      <span class="custom-close" onclick="closeCustomModal()">&times;</span>
    </div>
    <div class="custom-modal-body">
      <button class="custom-modal-option">친구 신청</button>
      <button class="custom-modal-option">운영진으로 추가</button>
      <button class="custom-modal-option">연락처 복사</button>
      <button class="custom-modal-danger">강제 퇴장</button>
    </div>
  </div>
</div>
<script>
var Authorization = localStorage.getItem("Authorization");
const urlParams = new URLSearchParams(window.location.search);
const create_crew_code = urlParams.get('create_crew_code');
const user_code = urlParams.get('user_code');
var position;
    $(document).ready(function() {
        $('#member').css('color', 'black');
        crew_deatil_select();
        crew_manage_select('');
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
    function crew_manage_select(element){
         var id = element.id===undefined?'member': element.id;
         $('[name="crew_select"]').css('color', 'gray');
         $('#'+id).css('color', 'black');
    $.ajax({
        url: '/crew/crew_manage_select',
        type: 'post',
        async: false,
        data: {
            Authorization    : Authorization,
            create_crew_code : create_crew_code,
            id               : id
        },
        success: function(response) {
            clog(response[0]);
            if (id=='member')crew_manage_select_member(response);
        },
        error: function(e) {
            console.error('Error: ', e);
        }
    });
    }

    function crew_manage_select_member(response){
        $('#crew_manage_list').html('');
        var list ='';
        for(var i in response){
            list += '<li class="member-item"> ';
            list += '<div class="item-flex"> ';
            list += '   <img src="/resources/uploadfile/'+response[i].a_s+'" class="profile-img"> ';
            list += '   <div class="profile-info"> ';
            list += '     <div class="info-wrapper"> ';
            list += '      <p class="name">'+response[i].b_s+'</p> ';
            list += '      <div class="label-operator">'+response[i].a_n>1?"":"운영진"+'</div> ';
            list += '     </div> ';
            list += '   </div> ';
            list += '  <div class="menu"> ';
            list += '   <div class="dropdown"> ';
            list += '     <div class="more-icon" onclick="openCustomModal()"> &#8943;</div> ';
            list += '   </div> ';
            list += '  </div> ';
            list += '</div> ';
            list += '</li> ';
        }


        $('#crew_manage_list').append(list);
    }
    function openCustomModal() {
      document.getElementById('customModal').style.display = 'block';
    }

    function closeCustomModal() {
      document.getElementById('customModal').style.display = 'none';
    }
</script>