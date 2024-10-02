<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    $('#header').hide();

    // 팝업 창에서 쿼리 파라미터로 전달된 gender 값 가져오기
    function getQueryParam(param) {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    // gender 값 가져오기
    var gender = getQueryParam('gender');
    // usercode 값 가져오기
    var usercode = getQueryParam('usercode');

    // 콘솔에 gender와 usercode 값 출력
    console.log("Gender value received from parent window: ", gender);
    console.log("Usercode value received from parent window: ", usercode);

    function profile_draw(gender) {
        var list = '';
        var imgGender = (gender === 'Female') ? 'woman' : 'man';  // 성별에 따른 값 설정
        for (var i = 0; i < 16; i++) {  // 15개의 프로필 박스 생성
            list += '<div class="profile-box">';
            list += '<div class="profile_img" onclick="profile_click(this);" >';  // class로 변경하고 this 전달
            list += '<img src="/img/' + imgGender + (i + 1) + '.png" alt="프로필 이미지" data-value="' + (i + 1) + '">';
            list += '</div>';
            list += '</div>';
        }

        // 프로필 컨테이너에 결과 반영
        $('.profile-container').empty();
        $('.profile-container').append(list);
    }

    $(document).ready(function() {
        profile_draw(gender);  // gender 값에 따라 프로필 출력
    });

    // 클릭된 요소에서 data-value 가져오기
   function profile_click(element) {
       var profileValue = $(element).find('img').data('value');
       $.ajax({
           url:'/mate/profile_click',
           type:'post',
           async: false,
           data:{
               profileValue:profileValue,
               usercode:usercode
           },
           success:function(result){
               if (result === 0) {  // 성공적인 처리 (result가 0일 때)
                   console.log('Profile saved successfully.');

                   // 부모 창(mate.jsp) 새로고침
                   if (window.opener) {
                       window.opener.location.reload();  // 부모 창 새로고침
                   }

                   window.close();  // 팝업 창 닫기
               } else {
                   console.log('Profile saving failed, result:', result);
               }
           },
           error:function(e){
               console.error('Error occurred while sending profile click:', e);
           }
       });
   }
</script>
 <style>
    /* 중앙 메인 콘텐츠 */
    .main-content {
        width: 100%;
        padding-top: 50px;
        display: flex;
        align-items: center;
        flex-direction: column;
        background-color: #1e1e1e;
    }

    /* 프로필 박스 컨테이너 */
    .profile-container {
        margin: 30px 0;
        width: 75%;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        grid-gap: 35px;
    }

    /* 개별 프로필 박스 */
    .profile-box {
        background-color: #333;
        border: 2px solid #474545;
        border-radius: 10px;
        padding: 20px;
        text-align: center;
        transition: transform 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .rank-name {
        font-size: 14px;
        font-weight: bold;
        color: azure;
    }

    .profile-box:hover {
        transform: scale(1.05);
        border-color: #CCFF47;
    }

    .profile-box img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 10px;
    }

    #profile_img {
        width: 100px;
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 5px;
    }
 </style>
</head>
<body>
    <header>
         <div id="header">
            <nav>
                <div class="logo">
                   <img src="/img/logo3.png" id="logoimage"/>
                </div>
                <ul>
                    <li><a>PROFILE-LIST </a></li>
                    <li><a>Double-click to select your profile image.&nbsp;&nbsp;</a></li>
                </ul>
            </nav>
        </div>
   </header>
    <div class="main-content">
        <div class="profile-container">
        </div>
    </div>
</body>
</html>