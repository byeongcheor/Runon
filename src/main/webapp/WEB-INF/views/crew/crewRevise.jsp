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
<link rel="stylesheet" href="/css/crewRevise.css" type="text/css">

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg" />
    </div>
    <div class="content-body">
        <div class="content-full">
            <div class="join-container">
                <section class="menu-container">
                    <div class="menu-title">
                        <p class="menu-title-name">프로필 수정</p>
                    </div>
                </section>
                <section class="profile-container">
                   <form id="crewCreateForm" enctype="multipart/form-data">
                       <div class="crew_profileimage">
                            <div class="profileBox">
                                <img id="teamPhotoPreview" src="" class="profileImg" onclick="document.getElementById('teamEmblem').click();">
                            </div>
                            <label class="upload-box" for="teamEmblem">프로필 바꾸기
                                <input type="file" id="teamEmblem" name="teamEmblem" onchange="previewImage(event)" />
                            </label>
                       </div>
                       <div class="section">
                           <div class="mb-3">
                               <label for="teamName" class="form-label">크루 이름</label>
                               <input type="text" class="form-control" id="teamName" name="teamName" placeholder="크루 이름" required />
                           </div>
                       </div>
                       <div class="section">
                           <div class="row mb-3">
                               <div class="col">
                                   <label for="city" class="form-label">도시</label>
                                    <select class="form-control text-center" name="city" id="city" onchange="select_box_change3('1');">
                                        <option value="" selected>지역</option> <!-- 기본으로 선택 -->
                                        <option value="" selected>전체</option>
                                        <option value="서울">서울</option>
                                        <option value="경기">경기</option>
                                        <option value="부산">부산</option>
                                        <option value="대구">대구</option>
                                        <option value="인천">인천</option>
                                        <option value="광주">광주</option>
                                        <option value="대전">대전</option>
                                        <option value="울산">울산</option>
                                        <option value="세종">세종</option>
                                        <option value="강원">강원</option>
                                        <option value="충북">충북</option>
                                        <option value="충남">충남</option>
                                        <option value="전북">전북</option>
                                        <option value="전남">전남</option>
                                        <option value="경북">경북</option>
                                        <option value="경남">경남</option>
                                        <option value="제주">제주</option>
                                    </select>
                               </div>
                               <div class="col">
                                   <label for="region" class="form-label">지역</label>
                                   <select class="form-control text-center" name="region" id="region">
                                       <option value="">상세지역</option>
                                   </select>
                               </div>
                           </div>
                       </div>
                       <!-- 나이대, 성별 설정 -->
                       <div class="section">
                            <label class="form-label">주요 나이대</label>
                            <div class="checkbox-group">
                                  <input type="checkbox" id="age10" name="age[]" value="10대" />
                                  <label for="age10">10대</label>
                                  <input type="checkbox" id="age20" name="age[]" value="20대" />
                                  <label for="age20">20대</label>
                                  <input type="checkbox" id="age30" name="age[]" value="30대" />
                                  <label for="age30">30대</label>
                                  <input type="checkbox" id="age40" name="age[]" value="40대" />
                                  <label for="age40">40대</label>
                                  <input type="checkbox" id="age50" name="age[]" value="50대" />
                                  <label for="age50">50대</label>
                                  <input type="checkbox" id="age60" name="age[]" value="60대 이상" />
                                  <label for="age60">60대 이상</label>
                            </div>
                           <label class="form-label mt-3">성별</label>
                           <div class="radio-group">
                               <input type="radio" id="male" name="gender" value="남자" />
                               <label for="male">남자</label>
                               <input type="radio" id="female" name="gender" value="여자" />
                               <label for="female">여자</label>
                               <input type="radio" id="both" name="gender" value="성별무관" />
                               <label for="both">성별무관</label>
                           </div>
                       </div>
                       <div class="section">
                           <label class="form-label mt-3">크루소개</label>
                           <textarea id="teamIntro" name="teamIntro" class="team-intro" placeholder="크루를 소개하세요"></textarea>
                       </div>
                       <div class="revise_button">
                           <button type="button" class="common-btn" onclick="submitCrewInfo()">수정하기</button>
                       </div>
                   </form>
                </section>
            </div>
        </div>
    </div>
</div>

<script>
var Authorization = localStorage.getItem("Authorization");
var create_crew_code;

function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('teamPhotoPreview'); // teamPhotoPreview로 변경
        output.src = reader.result;
        output.style.display = 'block'; // 미리보기 이미지가 보이도록 설정
    };
    reader.readAsDataURL(event.target.files[0]);
}

</script>