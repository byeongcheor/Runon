<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
                        <h1>수박런</h1>
                        <p>서울 강남구</p>
                        <p>성별무관/ 20대 30대 </p>
                    </div>

                    <div class="profileimage">
                        <div class="imgContainer">
                            <img src="/crewProfile/crewlogo3.png">
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
                        <li>크루관리<li>
                    </ul>
                </div>
                //여기에 비동기
            </section>
            <section class="section2">
                <div class="section_title">크루정보</div>
                <div class="info_body">
                    <div class="crew_infos">
                        <span class="crew_imogi">📍</span>
                        <span class="crew_addr">활동지역</span>
                        <span class="crew_addr2">서울시 성동구</span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🏃‍</span>
                        <span class="crew_addr">️멤버수</span>
                        <span class="crew_addr2">4명</span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">🔍‍</span>
                        <span class="crew_addr">평균나이</span>
                        <span class="crew_addr2">27.2세</span>
                    </div>
                    <div class="crew_infos">
                        <span class="crew_imogi">✨</span>
                        <span class="crew_addr">크루생성일</span>
                        <span class="crew_addr2">2024-10-04</span>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>