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
                  <li>멤버</li>
                  <li>공지</li>
                  <li>크루관리</li>
                </ul>
              </div>
                  <div class="member">
                    <ul class="member-list">
                      <li class="member-item">
                        <div class="item-flex">
                          <!-- 프로필 정보 -->
                          <a href="#" class="profile">
                            <img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/img_profile_default.png" class="profile-img">
                            <div class="profile-info">
                              <div class="info-wrapper">
                                <p class="name">장재성</p>
                                <div class="label-operator">운영진</div>
                              </div>
                            </div>
                          </a>
                          <!-- more-icon 클릭 시 모달 띄우기 -->
                          <div class="menu">
                            <div class="dropdown">
                              <div class="more-icon" onclick="openModal()"> &#8943;</div>
                            </div>
                          </div>
                        </div>
                      </li>
                      <li class="member-item">
                      <div class="item-flex">
                        <!-- 프로필 정보 -->
                        <a href="#" class="profile">
                          <img src="https://d31wz4d3hgve8q.cloudfront.net/static/img/img_profile_default.png" class="profile-img">
                          <div class="profile-info">
                            <div class="info-wrapper">
                              <p class="name">장재성</p>
                              <div class="label-operator">운영진</div>
                            </div>
                          </div>
                        </a>
                        <!-- more-icon 클릭 시 모달 띄우기 -->
                        <div class="menu">
                          <div class="dropdown">
                            <div class="more-icon" onclick="openModal()"> &#8943;</div>
                          </div>
                        </div>
                      </div>
                      </li>
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

<script>
var Authorization = localStorage.getItem("Authorization");
const urlParams = new URLSearchParams(window.location.search);
const create_crew_code = urlParams.get('create_crew_code');
    $(document).ready(function() {
        crew_deatil_select();
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


</script>