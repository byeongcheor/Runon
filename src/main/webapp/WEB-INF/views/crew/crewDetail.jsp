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
<link rel="stylesheet" href="/css/crewDetail.css" type="text/css">
<link rel="stylesheet" href="/css/crewCreate.css" type="text/css">

<div>
        <div id="bannerBox">
            <img src="/img/러닝고화질.jpg" id="bannerImg" />
        </div>
        <div class="content_body">
            <div class="content_left">
                <section class="section3">
                    <div class="profile_container">
                        <div class="team-header" onClick="go_crew_manage();">
                            <div class="team-emblem">
                                <div class="emblem-wrapper">
                                    <div class="emblem-background">
                                        <img id="crew_img" src="/img/man1.png" class="emblem-image" />
                                    </div>
                                </div>
                            </div>
                            <div class="team-content">
                                <div><span class="team-name" id='team_name'></span></div>
                                <span class="team-info" id='addr'></span>
                                <span class="team-info" id='team_info' ></span>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- 멤버 모집 조건 박스 -->
                <div class="recruitment-box">
                    <h3>👩‍👩‍👧‍👧 멤버 모집 조건</h3>
                    <div class="team-body">
                        <div class="feature-list">
                            <div class="feature-item">
                                <span class="icon-emoji">⭐</span>
                                <span class="feature-text" id='gender'></span>
                            </div>
                            <div class="feature-item">
                                <span class="icon-emoji">⭐</span>
                                <span class="feature-text" id='age'></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="button-container">
                    <div class="top-buttons">
                        <button class="action-button" id='update_btn' data-bs-toggle="modal" data-bs-target="#crewInfoModal" onclick="crew_write_page_update_detail();">수정하기</button>
                        <button class="action-button" id='delete_btn' onclick="crew_write_delete()">모집 중단하기</button>
                    </div>
                    <div class="bottom-button">
                        <button class="action-button wide" id="crew_request_btn" onClick="user_check();">가입 신청하기</button>
                        <button class="action-button wide" data-bs-dismiss="modal" id="crew_request_delete" onClick="crew_join_delete();">가입 취소하기</button>
                    </div>
                </div>
            </div>
            <div class="content_right">
                <section class="section1">
                    <div class="image-text-container">
                        <div class="image-wrapper">
                            <img id= 'content_img'
                                src="/img/러닝고화질.jpg"
                                class="responsive-image"
                            />
                        </div>
                        <pre class="text-wrapper" id='content'>
                        </pre>
                        <div class="extra-info">
                            <span id='hits'>조회 8</span> · <span id='crew_request'>신청 0</span>
                            <span style="float: right;" id='write_date'>업데이트 39분 전</span>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <!-- 가입신청 모달 -->
    <div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="joinModalLabel">가입 신청</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <textarea class="custom-textarea" id='join_content' placeholder="크루 가입 신청합니다."></textarea>
            <div class="info-box">
              <strong>이런 내용이 포함되면 좋아요 😊</strong>
              <ul>
                <li>살고 있는 지역</li>
                <li>나이</li>
                <li>실력 및 경력</li>
              </ul>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn modal-action-button" data-bs-dismiss="modal" id="join_write_btn" onClick="crew_join_write();">가입 신청하기</button>
          </div>
        </div>
      </div>
    </div>
   <!-- 수정버튼을 클릭하면 나오는 첫번쨰 모달 -->
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
                              <select class="form-control text-center" id="city2" name="city">
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
      <form id="crew_write_update" enctype="multipart/form-data">
      <!-- 2번째 모달 -->


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

      <!-- 3번째 모달 -->
          <input type=hidden id='crew_write_code' name='crew_write_code'>
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
                              <img id="teamPhotoPreview" src="" alt="팀 사진 미리보기" style="width: 100%; height: auto; border-radius: 5px; position: relative; z-index: 1;">
                              <button type="button" class="btn delete-btn" id="deletePhotoBtn" onclick="deletePhoto()" style="position: absolute; top: 10px; left: 10px; z-index: 2; background-color: rgba(255, 255, 255, 0.7); border: none;">지우기</button>
                          </div>

                          <div class="mt-3">
                              <label class="form-label">크루 소개</label>
                              <textarea id="teamIntro3" name='teamIntro3' class="form-control" placeholder="여기를 눌러 크루를 소개하세요" style="height: 200px;"></textarea>
                          </div>

                          <div class="btn-group mt-3">
                              <button type="button" class="common-btn" id="prevBtnInCreateModal">뒤로</button>
                              <button type="button" class="common-btn" id="submitCreateCrewBtn" onClick='crew_write_update()'>등록하기</button>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </form>
<script>
var Authorization = localStorage.getItem("Authorization");
const urlParams = new URLSearchParams(window.location.search);
const create_crew_code = urlParams.get('create_crew_code');
const crew_write_code = urlParams.get('crew_write_code');
var usercode;
$('#nextBtn').on('click', function() {
    $('#crewInfoModal').modal('hide');
    crew_write_detail_check(crew_write_code);
    $('#thirdModal').modal('show');
});

$('#nextBtnInThirdModal').on('click', function() {
    $('#thirdModal').modal('hide');
    $('#uploadTeamPhotoModal').modal('show');
});
$('#prevBtnInThirdModal').on('click', function() {
    // 두 번째 모달을 닫고 첫 번째 모달을 다시 열기
    $('#thirdModal').modal('hide');
    $('#crewInfoModal').modal('show');
});
$('#prevBtnInCreateModal').on('click', function() {
    // 두번째 모달을 열고 3번쨰 모달을 닫는 코드 추가
    $('#uploadTeamPhotoModal').modal('hide');  // 현재 모달을 닫음
    $('#thirdModal').modal('show');  // 두 번째 모달을 다시 띄움
});

    $(document).ready(function() {
        crew_detail_select();

        $('#crew_write_code').val(crew_write_code);
    });

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

    function crew_detail_select(){
        $.ajax({
            url: '/crew/detail',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization,
                create_crew_code : create_crew_code
            },
            success: function(result) {
            clog(result);
                $('#crew_img').attr('src', '/crew_upload/'+result[0].logo);
                $('#team_name').text(result[0].crew_name);
                $('#addr').text(result[0].addr);
                $('#team_info').text(result[0].a_s);
                $('#gender').text(result[0].gender);
                $('#age').text(result[0].age);

                // 이미지가 있는 경우
                if (result[0].b_s && result[0].b_s !== 'null') {
                    $('#content_img').attr('src', '/crew_upload/' + result[0].b_s);
                    $('.image-wrapper').show(); // 이미지가 있으면 보여줌
                } else {
                    $('.image-wrapper').hide(); // 이미지가 없으면 숨김
                }

                $('#content').text(result[0].content);
                $('#hits').text('조회수 ' + result[0].hits);
                $('#crew_request').text('신청자수 ' + result[0].a_n);
                $('#write_date').text('업데이트    ' + result[0].writedate);

                usercode = result[0].b_n;
                if (result[0].usercode == usercode) {
                    $('#crew_request_btn').hide();
                    $('#crew_request_delete').hide();
                } else {
                    $('#update_btn').hide();
                    $('#delete_btn').hide();
                    if (result[0].c_n > 0) {
                        $('#crew_request_delete').show();
                        $('#crew_request_btn').hide();
                    } else {
                        $('#crew_request_delete').hide();
                        $('#crew_request_btn').show();
                    }
                }
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }


    function crew_join_write(){
        $.ajax({
            url: '/crew/join_write',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization,
                create_crew_code : create_crew_code,
                join_content       : $('#join_content').val()
            },
            success: function(result) {
                $('#crew_request_delete').show();
                $('#crew_request_btn').hide();
                if(result>0) alert('가입신청이 완료되었습니다.')
                //else alert('이미 가입신청 되어있습니다.');
            },
            error: function(e) {
                console.error('Error: ', e);
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
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }

    function user_check() {
        const myModal = new bootstrap.Modal(document.getElementById('joinModal'), {
            keyboard: false
        });
        $.ajax({
            url: '/crew/user_check',
            type: 'POST',
            async: false,
            data: {
                  Authorization : Authorization,
                  crew_write_code : crew_write_code
            },
            success: function(response) {
                if (response != 1) {
                    alert('모집조건에 맞지 않습니다.');
                } else {
                    myModal.show(); // 조건이 맞으면 모달을 표시
                }
            },
            error: function(error) {
                console.log(error);
                alert('가입 신청 중 오류가 발생했습니다.');
            }
        });
    }

    function crew_write_delete(){
        if (confirm('모집을 중단하시겠습니까?')) {
            $.ajax({
                url: '/crew/crew_write_delete',
                type: 'post',
                async: false,
                data: {
                    Authorization: Authorization,
                    crew_write_code: crew_write_code
                },
                success: function(result) {
                    alert('크루모집이 취소되었습니다.');
                    window.location.href = '/crew/crewList';
                },
                error: function(e) {
                    console.error('Error: ', e);
                }
            });
        } else {
            alert('취소되었습니다.');
        }
    }

    function crew_write_page_update_detail(){
        $.ajax({
            url: '/crew/crew_write_page_update_detail',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization,
                create_crew_code : create_crew_code
            },
            success: function(result) {
               addr_select_draw('city2');//select 박스 그리기
               $('#city2').val(result[0].addr);
               addr_gu_select_draw('region2', result[0].addr,result[0].addr_gu)
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
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }

    function crew_write_detail_check(crew_write_code) {
        $.ajax({
            url: '/crew/crew_write_detail_check',
            type: 'post',
            async: false,
            data: {
                Authorization: localStorage.getItem('Authorization'),
                crew_write_code: crew_write_code  // 전역변수 사용
            },
            success: function(result) {
                // 두 번째 모달 (thirdModal)에 성별 및 나이대 값 적용
                $('input[name="gender3"][value="' + result[0].gender + '"]').prop('checked', true);

                var age_arr = result[0].age.split(',');
                $('input[type="checkbox"][name="age[]3"]').prop('checked', false); // 체크박스 초기화
                for (var i in age_arr) {
                    $('input[name="age[]3"][value="' + age_arr[i] + '"]').prop('checked', true);
                }

                // 세 번째 모달 (uploadTeamPhotoModal)에 팀 소개 및 이미지 적용
                $('#teamIntro3').val(result[0].content);
                if (result[0].teamPhoto) {
                    $('#teamPhotoPreview').attr('src', '/crew_upload/' + result[0].teamPhoto).show(); // 팀 사진 미리보기
                    $('#photoPreviewSection').show();
                } else {
                    $('#photoPreviewSection').hide();
                }
            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }
    function crew_write_update() {
        var form = $('#crew_write_update')[0];
        var formData = new FormData(form);

        // 성별과 나이 선택 여부 확인
        var ageChecked = $('input[name="age[]3"]:checked').length > 0;
        var genderChecked = $('input[name="gender3"]:checked').length > 0;

        if (!ageChecked) {
            alert('주요 나이대를 선택해주세요.');
            return false;
        }
        if (!genderChecked) {
            alert('성별을 선택해주세요.');
            return false;
        }

        if ($('#teamIntro3').val() == '') {
            alert('모집내용을 입력해주세요.');
            return false;
        }

        // 글 수정 폼 데이터를 서버로 전송
        $.ajax({
            url: '/crew/crew_write_update',
            type: 'POST',
            headers: {
                Authorization: localStorage.getItem('Authorization')
            },
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('크루 모집이 수정되었습니다!');
                $('#uploadTeamPhotoModal').modal('hide');
                setTimeout(function() { crew_detail_select(); }, 100); // 업데이트된 내용을 다시 불러오는 함수
            },
            error: function(error) {
                console.log(error);
                alert('크루 모집 수정 중 오류가 발생했습니다.');
            }
        });
    }
    function go_crew_manage(){
        window.location.href = '/crew/crewManage?create_crew_code=' + create_crew_code + '&user_code=' + usercode;
    }

</script>