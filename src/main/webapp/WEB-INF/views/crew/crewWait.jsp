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
                    <ul class="team-list" id='team-list'>
                        <li class="team-item" style="display: flex; justify-content: space-between; width: 100%;">
                            <a class="team-link" style="flex-grow: 1;">
                               <img src="/crew_upload/team.png" class="team-emblem">
                               <div class="team-content">
                                   <div style="display: flex; align-items: center;">
                                        <span class="team-name" style="font-size: 18px; font-weight: bold;">선풍기</span>
                                        <span class="cancel-notice" style="font-size: 16px; color: rgb(255, 77, 55); margin-left: 10px;">
                                            팀에서 신청을 취소했어요
                                        </span>
                                   </div>
                               </div>
                            </a>
                            <div class="join-check-button" style="display: flex; justify-content: flex-end; align-items: center;">
                                <button type="button" class="custom-button" onClick="openModal()">
                                    신청 확인
                                </button>
                            </div>
                         </li>
                         <li class="team-item" style="display: flex; justify-content: space-between; width: 100%;">
                             <a class="team-link" style="flex-grow: 1;">
                                <img src="/crew_upload/team.png" class="team-emblem">
                                <div class="team-content">
                                    <div style="display: flex; align-items: center;">
                                         <span class="team-name" style="font-size: 18px; font-weight: bold;">선풍기</span>
                                         <span class="cancel-notice">
                                             팀에서 신청을 취소했어요
                                         </span>
                                    </div>
                                </div>
                             </a>
                             <div class="join-check-button">
                                <button type="button" class="custom-button" onClick="openModal()">
                                    신청 확인
                                </button>
                             </div>
                      </li>
                     </ul>
                </section>
            </div>
        </div>
    </div>
</div>
<!-- 모달 창 -->
    <div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="joinModalLabel">내 신청</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p>10월 12일 신청</p>
            <p>가입신청합니다</p>
          </div>
          <div class="modal-footer">
            <button type="button" data-bs-dismiss="modal">신청 취소하기</button>
          </div>
        </div>
      </div>
    </div>


<script>
 function openModal() {
        // Bootstrap의 모달을 표시하는 함수 호출
        var myModal = new bootstrap.Modal(document.getElementById('joinModal'));
        myModal.show();
      }

</script>