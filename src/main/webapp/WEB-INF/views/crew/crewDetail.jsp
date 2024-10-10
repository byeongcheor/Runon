<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link rel="stylesheet" href="/css/crewDetail.css" type="text/css">

<div>
     <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg"/>
     </div>
     <div id="crew_body">
        <div id="crew_nav">
            <ul>
                <li><a href="/crew/crewList">크루모집</a></li>
                <li><a href="#" data-bs-toggle="modal" data-bs-target="#crewCreateModal" onclick="resetForm()">크루생성</a></li>
                <li><a href="/crew/crewManage">나의크루</a></li>
                <li><a href="/crew/crewDetail">모집디테일 만들자</a></li>
            </ul>
        </div>
     </div>
     <div class="content_body">
             <div class="content_left">
                 <section class="section3">
                     <div class="profile_container">
                         <div class="team-header">
                             <a class="team-link">
                                 <div class="team-emblem">
                                     <div class="emblem-wrapper">
                                         <div class="emblem-background">
                                             <img src="/img/man1.png" class="emblem-image">
                                         </div>
                                     </div>
                                 </div>
                                 <div class="team-content">
                                     <div><span class="team-name">dd</span></div>
                                     <span class="team-info">여자 · 축구 · 10대 · 비기너3</span>
                                 </div>
                             </a>
                         </div>
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

<script>
    $(document).ready(function() {
        var createCrewCode = "${create_crew_code}";
        console.log("Crew Code:", createCrewCode);  // JavaScript로 값 확인
    });

</script>