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

                       <!-- 크루 이름 -->
                       <div class="section">
                           <div class="mb-3">
                               <label for="teamName" class="form-label">크루 이름</label>
                               <input type="text" class="form-control" id="teamName" name="teamName" placeholder="크루 이름" required />
                           </div>
                       </div>

                    <!-- 도시 및 지역 선택 -->
                        <div class="section">
                            <div class="row mb-3">
                                <div class="col">
                                    <label for="city" class="form-label">도시</label>
                                    <select class="form-control text-center" name="city" id="city" onchange="selectCity()">
                                        <!-- 도시 옵션은 JS에서 동적으로 추가됨 -->
                                    </select>
                                </div>
                                <div class="col">
                                    <label for="region" class="form-label">지역</label>
                                    <select class="form-control text-center" name="region" id="region">
                                        <!-- 지역 옵션은 JS에서 동적으로 추가됨 -->
                                    </select>
                                </div>
                            </div>
                        </div>

                       <!-- 나이대 선택 -->
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
                       </div>

                       <!-- 성별 선택 -->
                       <div class="section">
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

                       <!-- 크루 소개 -->
                       <div class="section">
                           <label class="form-label mt-3">크루소개</label>
                           <textarea id="teamIntro" name="teamIntro" class="team-intro" placeholder="크루를 소개하세요"></textarea>
                       </div>
                       <!-- 수정 버튼 -->
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
// URL 파라미터에서 값 가져오기
var Authorization = localStorage.getItem("Authorization");
const user_code = ${user_code};
const create_crew_code = ${create_crew_code};

// 받은 값을 콘솔로 출력하여 확인
console.log('user_code: ' + user_code);
console.log('create_crew_code: ' + create_crew_code);

// 페이지 로드 시 도시 리스트를 불러오는 함수
$(document).ready(function() {
    // 도시 리스트 추가
    addr_select_draw('city');

    // 크루 정보 불러오기
    loadCrewInfo();
});

function selectCity() {
    // 도시 선택 시, 해당 도시에 따른 지역을 동적으로 불러오기
    var selectedCity = $('#city').val();
    addr_gu_select_draw('region', selectedCity, '');  // 초기에는 선택된 지역 없음
}

function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('teamPhotoPreview'); // teamPhotoPreview로 변경
        output.src = reader.result;
        output.style.display = 'block'; // 미리보기 이미지가 보이도록 설정
    };
    reader.readAsDataURL(event.target.files[0]);
}

// 서버에서 기존 크루 정보를 불러와서 입력 필드에 미리 채우기
function loadCrewInfo() {
    $.ajax({
        url: '/crew/getCrewInfo',  // 서버에서 크루 정보를 가져오는 API
        type: 'POST',
        async: false,
        data: {
            Authorization: localStorage.getItem('Authorization'),
            create_crew_code: create_crew_code  // 전역변수 사용
        },
        success: function(response) {
            // response는 배열이므로 response[0]으로 첫 번째 객체에 접근
            var crewInfo = response[0];

            // 서버에서 받아온 값을 입력 필드에 미리 채움
            $('#teamName').val(crewInfo.crew_name);

            // 도시와 지역 설정
            $('#city').val(crewInfo.addr);
            addr_gu_select_draw('region', crewInfo.addr, crewInfo.addr_gu);  // 선택된 지역까지 설정

            // 나이대 설정 (콤마로 구분된 값을 배열로 처리)
            let ageArray = crewInfo.age.split(',');
            ageArray.forEach(function(age) {
                $('input[name="age[]"][value="' + age + '"]').prop('checked', true);
            });

            // 성별 설정
            $('input[name="gender"][value="' + crewInfo.gender + '"]').prop('checked', true);

            // 크루 소개
            $('#teamIntro').val(crewInfo.content);

            // 팀 사진 미리보기 설정 (logo 필드 사용)
            if (crewInfo.logo) {
                $('#teamPhotoPreview').attr('src', '/crew_upload/' + crewInfo.logo).show();
            } else {
                $('#teamPhotoPreview').hide();  // 사진이 없으면 미리보기 숨기기
            }
        },
        error: function(error) {
            console.log(error);
            alert('크루 정보를 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function submitCrewInfo() {
    var form = $('#crewCreateForm')[0];
    var formData = new FormData(form);

    // URL에서 가져온 create_crew_code 값을 FormData에 추가
    formData.append('create_crew_code', create_crew_code);

    // 성별과 나이 선택 여부 확인
    var ageChecked = $('input[name="age[]"]:checked').length > 0;
    var genderChecked = $('input[name="gender"]:checked').length > 0;

    // 크루명, 도시, 지역 값 가져오기
    var teamName = $('#teamName').val().trim();
    var city = $('#city').val().trim();
    var region = $('#region').val().trim();

    // 유효성 검사: 크루명, 도시, 지역, 나이대, 성별
    if (teamName === '') {
        alert('크루명을 입력해주세요.');
        return false;
    }
    if (city === '') {
        alert('도시를 선택해주세요.');
        return false;
    }
    if (region === '') {
        alert('지역을 선택해주세요.');
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

    // AJAX로 서버에 수정된 정보 전송
    $.ajax({
        url: '/crew/updateCrewInfo',
        type: 'POST',
        headers: {
            Authorization: localStorage.getItem('Authorization')  // 헤더로 Authorization 전송
        },
        data: formData,
        processData: false,  // FormData 사용 시 false로 설정
        contentType: false,  // FormData 사용 시 false로 설정
        success: function(response) {
         console.log("responseresponse->>", response)
        if (response === 1) {
            alert('이미 사용중인 크루가 있습니다. 다른 이름을 선택하세요.');
            } else if (response === 0) {
                alert('크루 정보가 성공적으로 수정되었습니다.');
            } else {
                alert('크루 정보 수정 중 오류가 발생했습니다.');
            }
        },
        error: function(error) {
            console.log(error);
            alert('크루 정보 수정 중 오류가 발생했습니다.');
        }
    });
}

</script>