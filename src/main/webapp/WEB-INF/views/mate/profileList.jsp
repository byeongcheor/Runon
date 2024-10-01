<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$('#header').hide();
</script>
<style>
 /* 중앙 메인 콘텐츠 */
 .main-content {
        width: 100%;
        padding-top:50px;
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
        align-items: center;  /* 중앙 정렬 */
    }
    .rank-name {
        font-size: 14px;
        font-weight: bold;
        color:azure;
    }

    .profile-box:hover {
        transform: scale(1.05);
        border-color: #CCFF47;

    }

    .profile-box img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 10px;
    }

    #profile_img {
        width: 100px;
        height: 100px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 5px;/*동그라미 태두리*/
    }

    #profile_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    }


    .profile-box p {
        margin: 5px 0;
    }

</style>
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
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man11.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man02.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman01.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman05.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman05.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man03.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man02.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman02.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man05.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man04.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman01.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man01.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman02.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman03.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/man03.png" alt="프로필 1 이미지">
                </div>
            </div>
            <div class="profile-box">
                <div id="profile_img">
                    <img src="/img/woman04.png" alt="프로필 1 이미지">
                </div>
            </div>
        </div>
    </div>
</body>