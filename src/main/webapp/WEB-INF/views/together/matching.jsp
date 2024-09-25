<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/slick.css" type="text/css">
<link rel="stylesheet" href="/css/slick-theme.css" type="text/css">
<link rel="stylesheet" href="/css/main.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/slick.min.js"></script>
</head>

<style>
    .section4 #inner1 {
        background-color: #f1f3f5;
        border-radius: 30px 30px 0 0;
        width: 100%;
        height: 100px;
    }

    .section4 #inner2 {
        background-color: #f1f3f5;
        width: 100%;
        height: 800px;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .select-box-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        align-items: center;
        margin-bottom: 30px;
    }

     .select-box {
         position: relative;
         display: flex;
         align-items: center;
         justify-content: center;
         padding: 10px 20px;
         border: 1px solid #dcdcdc;
         border-radius: 30px;  /* 셀렉트 박스 테두리 둥글기 */
         background-color: #f8f8f8;
         color: #8b8b8b;
         font-size: 14px;
         cursor: pointer;
         width: 120px;
         text-align: center;
     }

    .select-box.active {
        border-color: #121212;  /* 검은색 테두리 */
        background: rgba(18, 18, 18, 0.8);
        color: #f1f3f5;  /* 흰색 텍스트 */
    }

    .select-box img {
        width: 20px;
        height: 20px;
        margin-right: 5px;
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background: rgba(18, 18, 18, 0.8);
        border: 1px solid #dcdcdc;  /* 셀렉트 박스와 동일한 테두리 색 */
        border-radius: 30px;  /* 셀렉트 박스와 동일한 모서리 둥글기 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        list-style: none;
        padding: 0;
        margin: 0;
        width: 100%;  /* 부모 요소와 동일한 너비 */
        z-index: 1000;
    }

    .dropdown-menu li {
        padding: 10px;
        cursor: pointer;
        border-bottom: 1px solid #f0f0f0;
    }


     .dropdown-menu li:hover {
         background-color: transparent;  /* 배경색은 변경하지 않음 */
         color: #CCFF47;  /* 글자 색상을 연두색으로 변경 */
         font-size: 15px;  /* 글자 크기를 살짝만 키움 (기존보다 약간만 큰 크기) */
         font-weight: bold;  /* 글자를 굵게 */
         cursor: pointer;
         transition: color 0.3s ease, font-size 0.3s ease;  /* 부드러운 전환 효과 */
     }

     .select-box.active .dropdown-menu {
         display: block;
     }

    #inner2 p {
        font-size: 20pt;
        padding-bottom: 20px;
        margin-top: 30px;
        margin-bottom: 50px;
    }

    #hitmarathon {
        width: 70%;
        margin: 0 auto;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
        overflow-x: auto;
        scrollbar-width: none;
    }

    #hit_poster {
        width: 300px;
        height: 450px;
    }

    .poster {
        width: 300px;
        height: 400px;
        background-color: #CCFF47;
        padding: 20px;
    }

    #poster_img {
        width: 300px;
        height: 300px;
        position: relative;
    }

    #poster_img > img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 15px;
    }

    #recruit {
        background-color: #CCFF47;
        position: absolute;
        top: 5%;
        left: 5%;
        border-radius: 5px;
    }

    #recruit > span {
        padding: 5px 5px 5px 5px;
        font-weight: bold;
    }

    #outer1 {
        background-color: #f1f3f5;
    }

    #inner3 {
        background-color: #CCFF47;
        border-radius: 30px 30px 0 0;
        width: 100%;
        height: 80px;
    }

    #inner4 {
        background-color: #CCFF47;
        width: 100%;
        height: 900px;
        text-align: center;
    }

    #inner4 h1 {
        margin: 0;
        padding: 0;
        font-size: 45pt;
    }

    #inner4 p {
        font-size: 20pt;
        padding-bottom: 20px;
    }

    #outer2 {
        background-color: #CCFF47;
    }

    #more2 {
        border-radius: 50px;
        font-size: 15pt;
        font-weight: bold;
        padding: 5px;
        margin-bottom: 80px;
        border: 2px solid #121212;
        line-height: 50px;
        color: #121212;
    }

    #more2:hover {
        background-color: #121212;
        color: #f1f3f5;
        transition: 0.5s ease-out;
    }
</style>

<script>
    function toggleDropdown(box) {
        const selectBoxes = document.querySelectorAll('.select-box');
        selectBoxes.forEach(b => {
            if (b !== box) {
                b.classList.remove('active');
            }
        });
        box.classList.toggle('active');
    }
</script>

<body>
<div class="section4">
    <div id="inner1"></div>
    <div id="inner2">
        <div class="select-box-container">
            <div class="select-box" onclick="toggleDropdown(this)">
                내 대회 <span>&nbsp;▼</span>
                <ul class="dropdown-menu">
                    <li>대회 1</li>
                    <li>대회 2</li>
                    <li>대회 3</li>
                </ul>
            </div>
            <div class="select-box" onclick="toggleDropdown(this)">
                나이 <span>&nbsp;▼</span>
                <ul class="dropdown-menu">
                    <li>10대</li>
                    <li>20대</li>
                    <li>30대</li>
                    <li>40대 이상</li>
                    <li>모든 나이</li>
                </ul>
            </div>
            <div class="select-box" onclick="toggleDropdown(this)">
                성별 <span>&nbsp;▼</span>
                <ul class="dropdown-menu">
                    <li>남성</li>
                    <li>여성</li>
                    <li>모두</li>
                </ul>
            </div>
            <div class="select-box" onclick="toggleDropdown(this)">
                참가횟수 <span>&nbsp;▼</span>
                <ul class="dropdown-menu">
                    <li>1~5</li>
                    <li>6~10</li>
                    <li>11~15</li>
                    <li>15회 이상</li>
                </ul>
            </div>
            <div class="select-box" onclick="toggleDropdown(this)">
                메이트인원 <span>&nbsp;▼</span>
                <ul class="dropdown-menu">
                    <li>1명</li>
                    <li>2명</li>
                    <li>3명</li>
                    <li>4명</li>
                    <li>5명</li>
                    <li>6명</li>
                    <li>7명</li>
                    <li>8명</li>
                    <li>9명</li>
                    <li>10명</li>
                    <li>11명</li>
                    <li>12명</li>
                    <li>13명</li>
                    <li>14명</li>
                    <li>15명</li>
                </ul>
            </div>
        </div>
        <p>현재 진행 중인 러닝 이벤트를 살펴보세요.</p>
        <div id="hitmarathon">
            <div id="hit_poster">
                <div id="poster_img">
                    <img src="./img/poster4.png">
                    <div id="recruit"><span>모집중</span></div>
                </div>
                <div>
                    <div style="margin: 10px;">📍전국 어디서나</div>
							<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
						</div>
					</div>
					<div id="hit_poster">
						<div id="poster_img">
							<img src="./img/poster1.png">
							<div id="recruit"><span>모집중</span></div>
						</div>
						<div>
							<div style="margin: 10px;">📍전국 어디서나</div>
							<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
						</div>
					</div>
					<div id="hit_poster">
						<div id="poster_img">
							<img src="./img/poster2.png">
							<div id="recruit"><span>모집중</span></div>
						</div>
						<div>
							<div style="margin: 10px;">📍전국 어디서나</div>
							<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
						</div>
					</div>
					<div id="hit_poster">
						<div id="poster_img">
							<img src="./img/poster3.png">
							<div id="recruit"><span>모집중</span></div>
						</div>
						<div>
							<div style="margin: 10px;">📍전국 어디서나</div>
							<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
						</div>
					</div>
				</div>
				<button id="more2">&nbsp;더알아보기→&nbsp;</button>
			</div>
</div>
</body>
</html>