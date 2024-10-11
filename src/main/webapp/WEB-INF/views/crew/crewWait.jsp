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
    <div class="content_body">
        <div class="content_full">
            <div class="join_container">
                <section class="team-menu__container" style="margin-bottom: 0px;">
                    <div class="team-menu__title">
                        <p class="team-menu__title--name">가입 신청 내역</p>
                    </div>
                    <div class="team-menu__desc">
                        <p>14일 동안 팀에서 확인하지 않으면</p>
                        <p>자동으로 신청서가 취소돼요</p>
                    </div>
                </section>
                <section class="team-container" style="padding: 0px 20px;">
                    <ul class="team-list" id='team_list'>
                        <li class="team-item">
                            <a class="team-link">
                               <img src="/crew_upload/team.png" class="teamemblem">
                               <div class="team-list__content">
                                 <div style="font-size: 12px;">
                                     <span style="color: rgb(255, 77, 55);">팀에서 신청을 취소했어요</span>
                                 </div>
                                 <div style="display: flex; align-items: center;">
                                     <span class="team-name">선풍기</span>
                                 </div>
                             </div>
                            </a>
                         </li>
                     </ul>
                </section>
            </div>
        </div>
    </div>
 </div>
<script>


</script>