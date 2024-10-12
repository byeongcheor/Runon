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

<link rel="stylesheet" href="/css/crewList.css" type="text/css">
<link rel="stylesheet" href="/css/crewCreate.css" type="text/css">

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg"/>
    </div>

    <div id="crew_body">
        <div id="crew_nav">
            <ul>
                <li><a href="/crew/crewList">크루모집</a></li>
                <li><a href="#" data-bs-toggle="modal" data-bs-target="#crewCreateModal" onclick="resetForm()">크루생성</a></li>
                <li><a href="#" data-bs-toggle="modal" data-bs-target="#myCrewModal" onClick="crew_page(2)">나의 크루</a></li>
            </ul>
        </div>
    </div>
    <div class="crew_search">
        <div class="searchForm">
            <div class="search-left">
                <select class="form-select" name="search" id="orderby">
                    <option value="b.writedate">최신순</option>
                    <option value="b.hits"}>조회순</option>
                </select>
                <select class="form-select" name="search" id="gender">
                    <option value="">성별</option>
                    <option value="남자"}>남자</option>
                    <option value="여자"}>여자</option>
                    <option value="성별무관"}>성별무관</option>
                </select>
                <select class="form-select" name="search" id="age">
                    <option value="">나이</option>
                    <option value="10대"}>10대</option>
                    <option value="20대"}>20대</option>
                    <option value="30대"}>30대</option>
                    <option value="40대"}>40대</option>
                    <option value="50대"}>50대</option>
                    <option value="60대"}>60대 이상</option>
                    <option value=""}>ALL</option>
                </select>
                <select class="form-select" name="search" id="addr" onchange="select_box_change2();">
                    <option value="">지역</option>
                    <option value="">전체</option>
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
                <select class="form-select" name="search" id="addr_gu"></select>
                <input type="text" name="searchWord" id="searchWord" />
                <button type="submit" class="btn btn-outline-secondary" onClick="crew_list_select()">Search</button>
            </div>
            <button class="add-btn" onClick="crew_page(1)"data-bs-toggle="modal" data-bs-target="#createNewTeamModal">➕</button>
        </div>
    </div>

    <div class="crew_list" id="crew_list" >
        <div class="list_wrapper">
            <ul id="crew_list">
                <c:forEach var="cvo" items="${list}">
                    <li class="list_item" onClick="crew_page_detail(${cvo.create_crew_code},${cvo.crew_write_code})">
                        <div class="crew_profileimage">
                            <div class="profileBox">
                                <img src="/crew_upload/${cvo.logo}" class="profileImg">
                            </div>
                        </div>
                        <div class="crew_content">
                            <div class="crew_title">
                                <span class="crewname"style=" font-weight: bold; font-size:16px;"><b>${cvo.crew_name}</b></span>
                                <span class="count">🏃‍♀️${cvo.num}<span>
                                <span class="count2">멤버모집<span>
                            </div>
                            <div style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;width: 100%;">
                                <span class="crewaddr">${cvo.addr}</span>&nbsp;&nbsp;&nbsp;
                                <span class="crewIntro">${cvo.content}</span>
                            </div>
                            <div style="margin-top:3px;>
                                <span class="crewhit">${cvo.gender}</span>&nbsp;&nbsp;&nbsp;
                                <span class="crewhit">${cvo.age}</span>
                            </div>
                            <div style="margin-top:12px;">
                                <span class="crewhit">조회수 ${cvo.hits}</span>&nbsp;&nbsp;&nbsp;
                                <span class="crewhit">신청 ${cvo.a_n}</span>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- 페이징 -->
    <ul class="pagination justify-content-center" style="margin:100px;" id="paging">
        <!-- 이전페이지 -->
        <!-- 첫번째 페이지 -->
        <c:if test="${pvo.nowPage==1}">
            <li class="page-item"><a class="page-link" href="javascript:void(0);"><</a></li>
        </c:if>

        <!-- 첫번째 페이지가 아니면 -->
        <c:if test="${pvo.nowPage>1}">
            <li class="page-item"><a class="page-link" href="javascript:crew_list_select(${pvo.nowPage-1});">Previous</a></li>
        </c:if>

        <c:forEach var="p" begin="${pvo.startPageNum}" end="${pvo.startPageNum+pvo.onePageNum-1}">
            <c:if test="${p<=pvo.totalPage}">
                <li class='page-item <c:if test="${p==pvo.nowPage}">active</c:if>'>
                    <a class="page-link" href="javascript:crew_list_select(${p});">${p}</a>
                </li>
            </c:if>
        </c:forEach>

        <!-- 다음페이지 -->
        <c:if test="${pvo.nowPage==pvo.totalPage}">
            <li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>
        </c:if>
        <c:if test="${pvo.nowPage<pvo.totalPage}">
            <li class="page-item"><a class="page-link" href="javascript:crew_list_select(${pvo.nowPage+1});">></a></li>
        </c:if>
    </ul>

    <!-- 첫 번째 모달 -->
    <form id="crewCreateForm" enctype="multipart/form-data">
        <div class="modal fade" id="crewCreateModal" tabindex="-1" aria-labelledby="crewCreateModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="crewCreateModalLabel">크루 만들기</h5>
                        <button type="button" class="btn-close" onclick="confirmClose('crewCreateModal')" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="teamName" class="form-label">크루 이름을 작성해주세요</label>
                            <input type="text" class="form-control" id="teamName" name="teamName" placeholder="크루 이름" required />
                        </div>
                        <div class="mb-3">
                            <label for="teamEmblem" class="form-label">엠블럼을 선택해주세요</label>
                            <p class="subtext">엠블럼이 없다면 기본 이미지가 제공됩니다!</p>
                            <label class="upload-box" for="teamEmblem">
                                사진 업로드
                                <input type="file" id="teamEmblem" name="teamEmblem" onchange="previewImage(event)" />
                            </label>
                            <div id="previewContainer" style="position: relative; display:none;">
                                <img id="imagePreview" style="width: 100%; height: 200px;" />
                                <button type="button" class="delete-btn" onclick="deletePreview()" style="position: absolute; top: 10px; right: 10px; background-color: rgba(255, 255, 255, 0.7); border: none;">지우기</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="custom-btn" onclick="openLocationModal()">다음</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 두 번째 모달 -->
        <div class="modal fade" id="locationModal" tabindex="-1" aria-labelledby="locationModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="team-info">
                            <img id="teamImage" src="" alt="크루 이미지" />
                            <h2 id="teamNameDisplay">크루 이름</h2>
                        </div>
                        <button type="button" class="btn-close" onclick="confirmClose('locationModal')" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="form-label">활동하는 지역을 알려주세요</p>
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
                        <h5 class="form-label">어떤 사람들이 모여있나요?</h5>
                        <div>
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
                        </div>
                        <div class="mt-3">
                            <label class="form-label">성별</label>
                            <div class="radio-group">
                                <input type="radio" id="male" name="gender" value="남자" />
                                <label for="male">남자</label>
                                <input type="radio" id="female" name="gender" value="여자" />
                                <label for="female">여자</label>
                                <input type="radio" id="both" name="gender" value="성별무관" />
                                <label for="both">성별무관</label>
                            </div>
                        </div>
                        <div class="mt-3">
                            <label class="form-label">크루 소개</label>
                            <textarea id="teamIntro" name="teamIntro" class="team-intro" placeholder="여기를 누르고 크루을 소개하세요"></textarea>
                        </div>
                        <div class="btn-group">
                            <button type="button" class="common-btn" onclick="$('#locationModal').modal('hide'); $('#crewCreateModal').modal('show');">뒤로</button>
                            <button type="button" class="common-btn" onclick="submitCrewInfo()">등록하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- 플러스 버튼을 클릭하면 나오는 첫번째 모달 -->
    <div class="modal fade" id="createNewTeamModal" tabindex="-1" aria-labelledby="createNewTeamModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createNewTeamModalLabel">어떤 걸 하시겠어요?</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="crew_page">
                </div>
            </div>
        </div>
    </div>

    <!-- 플러스 버튼을 클릭하면 나오는 두번째 모달 -->
    <div class="modal fade" id="crewInfoModal" tabindex="-1" aria-labelledby="crewInfoModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="crewInfoModalLabel2"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="form-label">활동하는 지역</p>
                    <div class="row mb-3">
                        <div class="col">
                            <label for="city" class="form-label">도시</label>
                            <select class="form-control text-center" id="city2" name="city" onchange="select_box_change3('2');">
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
                            <select class="form-control text-center" id="region2" name="region">
                            </select>
                        </div>
                    </div>
                    <h5 class="form-label">주요 나이대</h5>
                    <div class="checkbox-group">
                        <input type="checkbox" id="age10_2" name="age[]2" value="10대" />
                        <label for="age10">10대</label>
                        <input type="checkbox" id="age20_2" name="age[]2" value="20대" />
                        <label for="age20">20대</label>
                        <input type="checkbox" id="age30_2" name="age[]2" value="30대" />
                        <label for="age30">30대</label>
                        <input type="checkbox" id="age40_2" name="age[]2" value="40대" />
                        <label for="age40">40대</label>
                        <input type="checkbox" id="age50_2" name="age[]2" value="50대" />
                        <label for="age50">50대</label>
                        <input type="checkbox" id="age60_2" name="age[]2" value="60대 이상" />
                        <label for="age60">60대 이상</label>
                    </div>
                    <h5 class="form-label">성별</h5>
                    <div class="radio-group">
                        <input type="radio" id="male2" name="gender2" value="남자" />
                        <label for="male">남자</label>
                        <input type="radio" id="female2" name="gender2" value="여자" />
                        <label for="female">여자</label>
                        <input type="radio" id="both2" name="gender2" value="성별무관" />
                        <label for="both">성별무관</label>
                    </div>
                    <button type="button" class="custom-btn" id="nextBtn">다음</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 3번째 모달 -->
    <form id="crew_write_add" enctype="multipart/form-data">
        <input type=hidden id='third_crew_code' name='third_crew_code'>
        <div class="modal fade" id="thirdModal" tabindex="-1" aria-labelledby="thirdModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="thirdModalLabel">어떤 사람을 영입할까요?</h5>
                        <button type="button" class="btn-close" onclick="confirmClose('thirdModal')"data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h5 class="form-label">성별</h5>
                        <div class="radio-group">
                            <input type="radio" id="male3" name="gender3" value="남자" />
                            <label for="male3">남자</label>
                            <input type="radio" id="female3" name="gender3" value="여자" />
                            <label for="female3">여자</label>
                            <input type="radio" id="both3" name="gender3" value="성별무관" />
                            <label for="both3">성별무관</label>
                        </div>

                        <h5 class="form-label">나이 (중복 가능)</h5>
                        <div class="checkbox-group">
                            <input type="checkbox" id="age10_3" name="age[]3" value="10대" />
                            <label for="age10_3">10대</label>
                            <input type="checkbox" id="age20_3" name="age[]3" value="20대" />
                            <label for="age20_3">20대</label>
                            <input type="checkbox" id="age30_3" name="age[]3" value="30대" />
                            <label for="age30_3">30대</label>
                            <input type="checkbox" id="age40_3" name="age[]3" value="40대" />
                            <label for="age40_3">40대</label>
                            <input type="checkbox" id="age50_3" name="age[]3" value="50대" />
                            <label for="age50_3">50대</label>
                            <input type="checkbox" id="age60_3" name="age[]3" value="60대 이상" />
                            <label for="age60_3">60대 이상</label>
                        </div>

                        <div class="btn-group mt-3">
                            <button type="button" class="common-btn" id="prevBtnInThirdModal">뒤로</button>
                            <button type="button" class="common-btn" id="nextBtnInThirdModal">다음</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 네 번째 모달 -->
        <div class="modal fade" id="uploadTeamPhotoModal" tabindex="-1" aria-labelledby="uploadTeamPhotoModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="uploadTeamPhotoModalLabel">멤버 모집</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="confirmClose('uploadTeamPhotoModal')"aria-label="닫기"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="teamPhotoInput" class="form-label upload-box" id="photoUploadLabel" style="display:block; text-align: center; padding: 10px; border: 1px solid #ccc; border-radius: 5px; cursor: pointer;">
                                팀 단체 사진 추가하기
                                <input type="file" class="form-control" id="teamPhotoInput" name="teamPhotoInput" accept="image/*" onchange="previewTeamPhoto(event)" style="display: none;">
                            </label>
                        </div>

                        <div id="photoPreviewSection" style="display: none; position: relative;">
                            <img id="teamPhotoPreview" src="" alt="팀 사진 미리보기" style="width: 80%; height: auto; border-radius: 5px; position: relative; z-index: 1;">
                            <button type="button" class="btn delete-btn" id="deletePhotoBtn" onclick="deletePhoto()" style="position: absolute; top: 10px; left: 10px; z-index: 2; background-color: rgba(255, 255, 255, 0.7); border: none;">지우기</button>
                        </div>

                        <div class="mt-3">
                            <label class="form-label">크루 소개</label>
                            <textarea id="teamIntro3" name='teamIntro3' class="form-control" placeholder="여기를 눌러 크루를 소개하세요" style="height: 300px;"></textarea>
                        </div>

                        <div class="btn-group mt-3">
                            <button type="button" class="common-btn" id="prevBtnInCreateModal">뒤로</button>
                            <button type="button" class="common-btn" id="submitCreateCrewBtn" onClick='crew_write_add()'>등록하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
<!-- 내크루 모달 -->
    <div class="modal fade" id="myCrewModal" tabindex="-1" aria-labelledby="myCrewModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-dialog-centered custom-modal-width">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="myCrewModalLabel">내 팀</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <ul class="team-list" id='team_list'>
            </ul>
          </div>
        </div>
      </div>
    </div>

<script>
//setTimeout(function(){
//                 alert(username1);
// }, 1500);
//setTimeout(function(){
//            alert(usercode1);
//}, 2000);


    var Authorization = localStorage.getItem("Authorization");
    var clog=console.log;
    var seoulDistricts = [
        "강남구", "강동구", "강북구", "강서구", "관악구", "광진구",
        "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구",
        "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구",
        "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"
    ];

    var gyeonggiCities = [
        "가평군", "고양시", "과천시", "광명시", "광주시", "구리시",
        "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시",
        "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시",
        "양평군", "여주시", "연천군", "오산시", "용인시", "의왕시",
        "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"
    ];

    var busanDistricts = [
        "강서구", "금정구", "기장군", "남구", "동구", "동래구",
        "부산진구", "북구", "사상구", "사하구", "서구", "수영구",
        "연제구", "영도구", "중구", "해운대구"
    ];
    var daeguDistricts = [
        "남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구"
    ];
    var incheonDistricts = [
        "강화군", "계양구", "미추홀구", "남동구", "동구", "부평구", "서구",
        "연수구", "옹진군", "중구"
    ];
    var gwangjuDistricts = [
        "광산구", "남구", "동구", "북구", "서구"
    ];
    var daejeonDistricts = [
        "대덕구", "동구", "서구", "유성구", "중구"
    ];
    var ulsanDistricts = [
        "남구", "동구", "북구", "울주군", "중구"
    ];
    var sejongDistricts = [
        "조치원읍", "반곡동", "연기면", "연동면", "연서면", "장군면", "전의면", "전동면", "소정면"
    ];
    var gangwonCities = [
        "강릉시", "고성군", "동해시", "삼척시", "속초시", "양구군",
        "양양군", "영월군", "원주시", "인제군", "정선군", "철원군",
        "춘천시", "태백시", "평창군", "홍천군", "화천군", "횡성군"
    ];
    var chungbukCities = [
        "괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군",
         "제천시", "증평군", "진천군", "청주시", "충주시"
    ];
    var chungnamCities = [
        "계룡시", "공주시", "금산군", "논산시", "당진시", "보령시",
        "부여군", "서산시", "서천군", "아산시", "연기군", "예산군",
        "천안시", "청양군", "태안군", "홍성군"
    ];
    var jeonbukCities = [
        "고창군", "군산시", "김제시", "남원시", "무주군", "부안군",
        "순창군", "완주군", "익산시", "임실군", "장수군", "전주시",
        "정읍시", "진안군"
    ];
    var jeonnamCities = [
        "강진군", "고흥군", "곡성군", "광양시", "구례군", "나주시",
        "담양군", "목포시", "무안군", "보성군", "순천시", "신안군",
        "여수시", "영광군", "영암군", "완도군", "장성군", "장흥군",
        "진도군", "함평군", "해남군", "화순군"
    ];
    var gyeongbukCities = [
        "경산시", "경주시", "고령군", "구미시", "군위군", "김천시",
        "문경시", "봉화군", "상주시", "성주군", "안동시", "영덕군",
        "영양군", "영주시", "영천시", "예천군", "울릉군", "울진군",
        "의성군", "청도군", "청송군", "칠곡군", "포항시"
    ];
    var gyeongnamCities = [
        "거제시", "거창군", "고성군", "김해시", "남해군", "밀양시",
        "사천시", "산청군", "양산시", "의령군", "진주시", "창녕군",
        "창원시", "통영시", "하동군", "함안군", "함양군", "합천군"
    ];
    var jejuDistricts = [
        "서귀포시", "제주시"
    ];



    function select_box_change3(flag) {

        $('select[name="region"]').html(''); // 기존 내용을 초기화
        var list = '<option value="">상세지역</option>'; // 기본 선택 옵션
        var selectedCity = flag=='1'?$('#city').val():$('#city2').val();
        // 각 지역에 맞는 상세 지역 리스트 추가
        if (selectedCity === '서울') {
            seoulDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '경기') {
            gyeonggiCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '부산') {
            busanDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '대구') {
            daeguDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '인천') {
            incheonDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '광주') {
            gwangjuDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '대전') {
            daejeonDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '울산') {
            ulsanDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '세종') {
            sejongDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        } else if (selectedCity === '강원') {
            gangwonCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '충북') {
            chungbukCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '충남') {
            chungnamCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '전북') {
            jeonbukCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '전남') {
            jeonnamCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '경북') {
            gyeongbukCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '경남') {
            gyeongnamCities.forEach(function(city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if (selectedCity === '제주') {
            jejuDistricts.forEach(function(region) {
                list += '<option value="' + region + '">' + region + '</option>';
            });
        }

        $('select[name="region"]').append(list); // 추가된 옵션을 반영
    }

    function select_box_change2() {
        if ($('#addr').val() !== '') {
            $('#addr_gu').show();
        } else {
            $('#addr_gu').hide();
        }

        $('#addr_gu').html('');
        var list = '<option value="">전체</option>';

        if ($('#addr').val() == '서울') {
            seoulDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '경기') {
            gyeonggiCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '부산') {
            busanDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '대구') {
            daeguDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '인천') {
            incheonDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '광주') {
            gwangjuDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '대전') {
            daejeonDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '울산') {
            ulsanDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '세종') {
            sejongDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        } else if ($('#addr').val() == '강원') {
            gangwonCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '충북') {
            chungbukCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '충남') {
            chungnamCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '전북') {
            jeonbukCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '전남') {
            jeonnamCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '경북') {
            gyeongbukCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '경남') {
            gyeongnamCities.forEach(function (city) {
                list += '<option value="' + city + '">' + city + '</option>';
            });
        } else if ($('#addr').val() == '제주') {
            jejuDistricts.forEach(function (district) {
                list += '<option value="' + district + '">' + district + '</option>';
            });
        }

        $('#addr_gu').append(list);
    }
    $('select[name="search"]').on('change', function() {
        crew_list_select(0);
    });
    $('#searchWord').on('click', function() {
        $('#gender').val('');
        $('#age').val('');
        $('#addr').val('');
        $('#addr_gu').val('');
        crew_list_select(0);
    });

    $(document).ready(function() {
        $('#addr_gu').hide();

        crew_page(1);
    });
    // 모달 닫기 확인
    function confirmClose(modalId) {
        if (confirm("닫으시면 선택한 정보가 사라집니다. 닫으시겠습니까?")) {
            $('#' + modalId).modal('hide');
        }
    }
    // Enter 키 입력 방지
    $(document).on('keydown', '#teamName', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
        }
    });

    function crew_list_select(panging){
        var list = '';
        var page = panging===undefined?0:panging*10;

        $.ajax({
            url: '/crew/search_crewList',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization,
                page          : page,
                orderby       : $('#orderby').val(),
                gender        : $('#gender').val(),
                age           : $('#age').val(),
                addr          : $('#addr').val(),
                addr_gu       : $('#addr_gu').val(),
                searchWord    : $('#searchWord').val()
            },
            success: function(result) {
                for(var i in result){
  list += '<div class="list_wrapper">';
                    list += ' <ul id="crew_list">';
                    list += '  <li class="list_item" onClick="crew_page_detail(' + result[i].create_crew_code + '&crewWriteCode=' + result[i].crewWriteCode +')">';
                    list += '   <div class="crew_profileimage">';
                    list += '       <div class="profileBox">';
                    list += '           <img src="/crew_upload/'+result[i].logo+'" class="profileImg">';
                    list += '       </div>';
                    list += '   </div>';
                    list += '   <div class="crew_content">';
                    list += '       <div class="crew_title">';
                    list += '           <span class="crewname" style=" font-weight: bold; font-size:16px;"><b>'+result[i].crew_name+'</b></span>';
                    list += '           <span class="count">🏃‍♀️'+result[i].num+'<span>';
                    list += '           <span class="count2">멤버모집<span>';
                    list += '       </div>';
                    list += '       <div style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;width: 100%;">';
                    list += '          <span class="crewaddr">'+result[i].addr+'</span>&nbsp;&nbsp;&nbsp';
                    list += '          <span class="crewIntro">'+result[i].content+'</span>';
                    list += '       </div>';
                    list += '       <div style="margin-top:3px; >';
                    list += '          <span class="crewhit">'+result[i].gender+'</span>&nbsp;&nbsp;&nbsp';
                    list += '          <span class="crewhit">'+result[i].age+'</span>';
                    list += '       </div>';
                    list += '       <div style="margin-top:12px;">';
                    list += '           <span class="crewhit">조회수'+result[i].hits+'</span>&nbsp;&nbsp;&nbsp';
                    list += '         <span class="crewhit">신청'+ result[i].a_n+'</span>';
                    list += '       </div>';
                    list += '     </div>';
                    list += '   </li>';
                    list += '  </ul>';
                    list += '</div>';
                }

                $('#crew_list').html('');
                $('#crew_list').append(list);
                var num = (Math.ceil(result.length / 10));
                var page_list='';

                if(paging==0){
                    page_list+='<li class="page-item"><a class="page-link" href="javascript:void(0);"><</a></li>';
                }

                if(i>1) page_list+= '<li class="page-item"><a class="page-link" href="javascript:crew_list_select('+(paging-1)+');">Previous</a></li>';

                for(var i=0; i<num;i++){
                    page_list+='<li class="page-item"><a class="page-link" href="javascript:crew_list_select('+i+');">'+(i+1)+'</a></li>';
                }

                if(paging==num) page_list+='<li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>';

                if(paging<num) page_list+= '<li class="page-item"><a class="page-link" href="javascript:crew_list_select('+(paging+1)+');">></a></li>';
                $('#paging').html('');
                $('#paging').append(page_list);
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }

    function previewImage(event) {
        var reader = new FileReader();
        reader.onload = function(){
            var output = document.getElementById('imagePreview');
            output.src = reader.result;
            document.getElementById('previewContainer').style.display = 'block'; // 미리보기 컨테이너를 표시
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    function deletePreview() {

        document.getElementById('previewContainer').style.display = 'none'; // 미리보기 컨테이너 숨김
        document.getElementById('imagePreview').src = ''; // 이미지 미리보기 제거
    }
    function previewTeamPhoto(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const output = document.getElementById('teamPhotoPreview');
            output.src = reader.result;
            document.getElementById('photoPreviewSection').style.display = 'block';
            document.getElementById('photoUploadLabel').style.display = 'none';
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    function deletePhoto() {
        document.getElementById('teamPhotoInput').value = '';
        document.getElementById('photoPreviewSection').style.display = 'none';
        document.getElementById('teamPhotoPreview').src = '';
        document.getElementById('photoUploadLabel').style.display = 'block';
    }

    function openLocationModal() {

        const teamName = document.getElementById('teamName').value;
        if (!teamName) {
            alert('크루 이름을 입력하세요.');
            return;
        }
        const teamImageFile = document.getElementById('teamEmblem').files[0];
        const teamImageURL = teamImageFile ? URL.createObjectURL(teamImageFile) : "/img/man1.png";

        document.getElementById('teamNameDisplay').textContent = teamName;
        document.getElementById('teamImage').src = teamImageURL;

        $('#crewCreateModal').modal('hide');
        $('#locationModal').modal('show');
    }

function submitCrewInfo() {
    var form = $('#crewCreateForm')[0];
    var formData = new FormData(form);

    // 이미지 파일이 있는지 확인
    var teamImageFile = $('#teamEmblem').val();

    // 이미지 파일이 없는 경우 기본 이미지 경로를 설정
    if (!teamImageFile) {
        // 기본 이미지 경로를 추가
        formData.append('teamEmblem', 'man1.png');
    } else if (teamImageFile.indexOf('png') == -1 && teamImageFile.indexOf('jpg') == -1 && teamImageFile.indexOf('jpeg') == -1) {
        alert('이미지파일만 업로드가 가능합니다.');
        return false;
    }

    // 활동 지역, 주요 나이대, 성별 선택 여부 확인
    var city = $('#city').val();
    var ageChecked = $('input[name="age[]"]:checked').length > 0;
    var genderChecked = $('input[name="gender"]:checked').length > 0;

    if (!city) {
        alert('활동하는 지역을 선택해주세요.');
        return false;
    }

    if (!ageChecked) {
        alert('주요 나이대를 선택해주세요.');
        return false;
    }

    if (!genderChecked) {
        alert('성별을 선택해주세요.');
        return false;
    }

    // 모든 필수 필드가 선택된 경우 AJAX 요청 보내기
    $.ajax({
        url: '/crew/crew_add',
        type: 'POST',
        headers: {
            Authorization: localStorage.getItem('Authorization')
        },
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
         if(response==1) alert('이미 존재하는 크루명입니다.');
         else {
            alert('크루가 성공적으로 생성되었습니다!');
            $('#locationModal').modal('hide');
         }
        },
        error: function(error) {
            console.log(error);
            alert('크루 생성 중 오류가 발생했습니다.');
        }
    });
}

    function resetForm() {
        document.getElementById('crewCreateForm').reset();
        deletePreview(); // 지우기 함수 호출
        document.getElementById('city').value = "";
        document.getElementById('region').value = "";
        document.querySelectorAll('input[name="age[]"]:checked').forEach(checkbox => checkbox.checked = false);
        document.querySelectorAll('input[name="gender"]:checked').forEach(radio => radio.checked = false);
        document.querySelectorAll('input[name="age[]2"]:checked').forEach(checkbox => checkbox.checked = false);
        document.querySelectorAll('input[name="gender2"]:checked').forEach(radio => radio.checked = false);
        document.querySelectorAll('input[name="age[]3"]:checked').forEach(checkbox => checkbox.checked = false);
        document.querySelectorAll('input[name="gender3"]:checked').forEach(radio => radio.checked = false);
        document.getElementById('teamIntro').value = '';
        document.getElementById('teamImage').src = '';
        document.getElementById('teamNameDisplay').textContent = '크루 이름';
    }

    $(document).ready(function() {
        // 크루 생성 모달을 열 때도 폼을 리셋
        $('#crewCreateModal').on('shown.bs.modal', function () {
           // resetForm();
        });
    });

    $(document).ready(function() {
        $('#createNewTeamModal').on('shown.bs.modal', function () {
            console.log('첫 번째 모달이 열렸습니다.');
        });
        $('#nextBtn').on('click', function() {
            $('#crewInfoModal').modal('hide');
            $('#thirdModal').modal('show');
        });

        $('#prevBtnInThirdModal').on('click', function() {
            $('#thirdModal').modal('hide');
            $('#crewInfoModal').modal('show');
        });

        $('#nextBtnInThirdModal').on('click', function() {
            $('#thirdModal').modal('hide');
            $('#uploadTeamPhotoModal').modal('show');
        });

        $('#prevBtnInCreateModal').on('click', function() {
            $('#uploadTeamPhotoModal').modal('hide');
            $('#thirdModal').modal('show');
        });

    });
    function crew_page(flag) {
        var list = '';
        $('#crew_page').html('');
        $('#team_list').html('');
        $.ajax({
            url: '/crew/crew_page',
            type: 'POST',
            headers: {
                Authorization: localStorage.getItem('Authorization')
            },
            processData: false,
            contentType: false,
            success: function(response) {
                if(flag==1){
                    for (var i in response) {
                        if (response[i].a_n == 0) {
                            list += '<button type="button" class="option-btn" onClick="crew_page_write(' + response[i].create_crew_code + ')" id="write' + response[i].create_crew_code + '">' + response[i].crew_name + ' 멤버 모집 시작하기</button>';
                        } else if (response[i].a_n > 0) {
                            list += '<button type="button" class="option-btn" onClick="crew_page_detail(' + response[i].create_crew_code+','+response[i].a_n + ')" id="write' + response[i].create_crew_code + '">' + response[i].crew_name + ' 모집글 확인하기</button>';
                        }
                    }
                    list += '<button type="button" class="option-btn" onClick="crew_add_popup();"id="createNewTeamBtn">새로운 팀 만들기</button>';
                    $('#crew_page').append(list);
                }
                if(flag==2){
                    for (var i in response) {
                         list += '<li class="team-item">';
                         list += '<a class="team-link">';
                         list += '<img src="/crew_upload/'+response[i].logo+'" class="teamemblem">';
                         list += '<div class="team-name" onClick="go_my_crew(' + response[i].create_crew_code + ')" id="write' + response[i].create_crew_code + '">' + response[i].crew_name + '</div>';
                         list +='</a>';
                         list+='</li>';
                    }
                     list += '<li class="team-item">';
                     list += '<a class="team-link">';
                     list += '<img src="/crew_upload/team.png" class="teamemblem">';
                     list += '<div class="team-name" onClick="join_wait()" id="write">가입 신청 내역</div>';
                     list +='</a>';
                     list+='</li>';
                    $('#team_list').append(list);
                }
            },
            error: function(error) {
                console.log(error);
            }
        });
    }
    function crew_page_write(create_crew_code){
        resetForm();
        $('#third_crew_code').val(create_crew_code);
        $('#createNewTeamModal').modal('hide');
        $('#crewInfoModal').modal('show');
        var crew_code = create_crew_code|0;
        $.ajax({
            url:'/crew/crew_page_write_detail',
            type:'post',
            async: false,
            headers: {
              Authorization: localStorage.getItem('Authorization')
            },
            data: {
              create_crew_code:crew_code
            },
            success:function(result){
               $('#city2').val(result[0].addr);
               select_box_change3('2');
               $('#region2').val(result[0].addr_gu);
               var age_arr = result[0].age.split(',');
               $('input[type="checkbox"][name="age[]2"]').prop('checked', false);//체크박스 초기화
               for(var i in age_arr){
                   $('input[name="age[]2"][value="'+age_arr[i]+'"]').prop('checked', true);
               }
               $('input[type="radio"][name="gender2"][value="'+result[0].gender+'"]').prop('checked', true);
               $('#crewInfoModalLabel2').text(result[0].crew_name+'의 정보를 확인하세요')
               $('#city2').prop('disabled', true);
               $('#region2').prop('disabled', true);

            },
            error:function(e){
            }
        });

    }

    function crew_page_detail(create_crew_code, crew_write_code) {
        $('#createNewTeamModal').modal('hide');
        window.location.href = '/crew/crewDetail?create_crew_code=' + create_crew_code + '&crew_write_code=' + crew_write_code;
    }
    function go_my_crew(create_crew_code,user_code) {
        $('#myCrewModal').modal('hide');
        window.location.href = '/crew/crewManage?create_crew_code=' + create_crew_code;
    }

    function join_wait() {
        $('#myCrewModal').modal('hide');
        window.location.href = '/crew/crewWait';
    }

    function crew_add_popup(){
        resetForm(); // 폼 리셋
        $('#createNewTeamModal').modal('hide');
        $('#crewCreateModal').modal('show');
    }

function crew_write_add() {

       var form = $('#crew_write_add')[0];
       var formData = new FormData(form);
        clog(form);
        var ageChecked = $('input[name="age[]3"]:checked').length > 0;
        var genderChecked = $('input[name="gender3"]:checked').length > 0;
        var teamIntro = $('#teamIntro3').val().trim();
       if (!ageChecked) {
           alert('주요 나이대를 선택해주세요.');
           return false;
       }
       if (!genderChecked) {
           alert('성별을 선택해주세요.');
           return false;
       }
       if (teamIntro === "") {
           alert('크루 소개글을 작성해주세요.');
           return false;
       }
       // 모든 필수 필드가 선택된 경우 AJAX 요청 보내기
       $.ajax({
           url: '/crew/crew_write_add',
           type: 'POST',
           headers: {
               Authorization: localStorage.getItem('Authorization')
           },
           data: formData,
           processData: false,
           contentType: false,
           success: function(response) {
               alert('크루 모집이 성공적으로 생성되었습니다!');
               $('#uploadTeamPhotoModal').modal('hide');

               crew_list_select(0);
           },
           error: function(error) {
               console.log(error);
               alert('크루 모집 중 오류가 발생했습니다.');
           }
       });
   }

</script>

