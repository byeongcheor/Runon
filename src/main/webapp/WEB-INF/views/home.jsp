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
	<script>
		$( document ).ready( function() {
			$('.center').slick({
				slidesToShow: 1,
				autoplay: true,
				autoplaySpeed : 2000,
				infinite: true,
				arrows: false,
				responsive: [
					{
					breakpoint: 768,
					settings: {
						arrows: false,
						centerMode: true,
						centerPadding: '40px',
						slidesToShow: 3
					}
					},
					{
					breakpoint:  480,
					settings: {
						arrows: false,
						centerMode: true,
						centerPadding: '40px',
						slidesToShow: 1
					}
					}
				]
				});
		} );
	</script>

	<style>
		.slideBox{
			width: 550px;
			height: 500px;
			margin: 20px;
			z-index: 10;
			position: relative;
		}
		#slide{
			width: 550px;
			position: absolute;
			top: 40%;
			left: 3%;
		}
		#posterrecruit{
			background-color: #CCFF47;
			border-radius: 15px;
			color:#121212;
			width: 100px;
			height: 50px;
			text-align: center;
		}
		#posterrecruit>span{
			font-size: 18pt;
			color:#121212;
			line-height: 50px;
			font-weight: bold;
		}
		#postername{
			color: white;
			font-size: 30pt;
			font-weight: bold;
		}
		#posterdate{
			color: white;
			font-size: 20pt;
		}
	</style>

	<style>
		*{
			font-family: "Noto Sans KR", sans-serif;
			font-optical-sizing: auto;
			font-style: normal;
		}
		/**{
			max-width: 1920px;
		}
		body,html{
			margin:0;
			padding:0;
			font-family:'Montserrat',sans-serif;
		}*/
		body{
			margin:0;
			padding:0;
			animation: fadein 4s;
		}
		@keyframes fadein {
			0% {
				opacity:0;
			}
			100% {
				opacity:1;
			}
		}
		#header{
			position:fixed;
			z-index: 999;
			width:100%;
			box-sizing: border-box;
			background:rgba(18,18,18,0.8);
			transition:.5s;
		}
		#header nav{
			top:0; left:0;
			width:100%;
			max-width:1700px;
			margin:0 auto;
		}


		#header nav .logo{ float:left;padding:30px 0;}
		#header nav .logo img{height:22px;}
		#header nav ul{ float:right; margin:0;padding:30px 0;}
		#header nav ul li{ float:left; display:block; list-style: none;}
		#header nav ul li a{ padding:0 15px; line-height: 22px; text-decoration: none; color: white; font-size:16px;}
		#header nav ul li:hover a{text-decoration: none; color: #CCFF47; cursor: pointer; font-weight: bold;}

		#header nav ul li a, #header nav .logo img{transition:.5s;}

		/* 스크롤 내렸을때 CSS .active */
		#header.active{
			background:#121212;
			border-radius: 10px;
			width:98%;
			margin: 20px;
		}
		#header.active nav ul li:hover a{color: #CCFF47;}
		#header.active nav .logo ,#header.active nav ul{padding:20px 0; transition:.5s;}
		#header.active nav ul li a{
			color:#fff;
			font-size:14px;
		}
		#header.active  nav .logo img{height:18px;}

		#div{
			width:100%;
			height:1500px;
		}

		.section1{
			width: 1920px;
			height: auto;
			font-size: 0;
			position:relative;
		}
		.section1 img{
			margin: 0;
			padding: 0;
		}
		.section2{
			background-color: #CCFF47;
			padding: 0;
			margin: 0;
			color: #121212;
			text-align: center;
			width: 100%;
			height: 45px;
		}
		.section2 p{
			padding: 0;
			margin: 0;
			font-size: 14pt;
			font-weight: bold;
			line-height: 45px;
		}
		.section3{
			text-align: center;
		}
		.section3 h1{
			padding-top: 50px;
			padding-bottom: 20px;
			font-size: 45pt;
		}
		.section3 p{
			font-size: 20pt;
			padding-bottom: 50px;
			line-height: 45px;
		}
		.section3 #more1{
			border-radius: 50px;
			font-size: 15pt;
			font-weight: bold;
			padding: 5px;
			margin-bottom: 80px;
			border: 2px solid #CCFF47;
			line-height: 50px;
			background-color: #CCFF47;
			color: #121212;
		}
		.section3 #more1:hover {
			background-color: #fff;
			transition: 0.5s ease-out;
		}
		#more2{
			border-radius: 50px;
			font-size: 15pt;
			font-weight: bold;
			padding: 5px;
			margin-bottom: 80px;
			border: 2px solid #121212;
			line-height: 50px;

			color: #121212;
		}
		#more2:hover{
			background-color: #121212;
			color: #f1f3f5;
			transition: 0.5s ease-out;
		}
		#more3{
			border-radius: 50px;
			font-size: 15pt;
			font-weight: bold;
			padding: 5px;
			margin-bottom: 80px;
			border: 2px solid #121212;
			line-height: 50px;
			background-color: #CCFF47;
			color: #121212;
		}
		#more3:hover{
			background-color: #121212;
			color: #f1f3f5;
			transition: 0.5s ease-out;
		}

		.section4 #inner1{
			background-color: #f1f3f5;
			border-radius: 30px 30px 0 0;
			width: 100%;
			height: 100px;
		}
		.section4 #inner2{
			background-color: #f1f3f5;
			width:100%;
			height:800px;
			text-align: center;
		}

		#inner2 h1{
			margin: 0;
			padding: 0;
			font-size: 45pt;
		}
		#inner2 p{
			font-size: 20pt;
			padding-bottom: 20px;
			margin-top: 30px;
			margin-bottom: 50px;
		}

		.poster{
			width:300px;
			height:400px;
			background-color: #CCFF47;
			padding: 20px;
		}
		#outer1{
			background-color: #f1f3f5;
		}
		#inner3{
			background-color: #CCFF47;
			border-radius: 30px 30px 0 0;
			width: 100%;
			height: 80px;
		}
		#inner4{
			background-color: #CCFF47;
			width:100%;
			height:900px;
			text-align: center;
		}
		#inner4 h1{
			margin: 0;
			padding: 0;
			font-size: 45pt;
		}
		#inner4 p{
			font-size: 20pt;
			padding-bottom: 20px;
		}

		#outer2{
			background-color: #CCFF47;
		}
		#inner5{
			background-color: #000;
			border-radius: 30px 30px 0 0;
			width: 100%;
			height: 80px;
		}
		#inner6{
			background-color: #000;
			width:100%;
			height:900px;
			text-align: center;
		}

		.listImg{
			background-color: #CCFF47;
			width: 300px;
			height: 200px;
		}

		#hitmarathon{
			width: 70%;
			margin: 0 auto;
			display: flex;
			flex-direction: row;
			align-items: center;
			justify-content: space-between;
			overflow-x: auto;
			scrollbar-width: none;
		}
		#hit_poster{
			width: 300px;
			height: 450px;
		}
		#poster_img{
			width: 300px;
			height: 300px;
			position: relative;
		}
		#poster_img>img{
			width: 100%;
			height: 100%;
			object-fit: cover;
			border-radius: 15px;
		}
		#recruit{
			background-color: #CCFF47;
			position: absolute;
			top: 5%;
			left: 5%;
			border-radius: 5px;
		}
		#recruit>span{
			padding: 5px 5px 5px 5px;
			font-weight: bold;
		}

		#chatImgBox{
			width: 70%;
			height: auto;
			margin: 0 auto;
			margin-top: 80px;
		}
		#chatImg{
			border-radius: 15px;
			margin-right: 20px;
			float: left;
		}
		#crewInfo{
			text-align: right;
		}
		#crewInfo p:first-child{
			font-size: 23pt;
			font-weight: bold;
			margin-bottom: 60px;
			line-height: 45px;
		}
		#crewInfo p:last-child{
			font-size: 18pt;
			line-height: 35px;

		}
		#chatImgBox #more3{
			margin-top: 80px;
			margin-left: 400px;
		}

		#inner6 h1{
			margin: 0;
			padding: 0;
			color: #CCFF47;
			font-size: 45pt;
		}
		#inner6 p{
			margin-top: 30px;
			color: beige;
			font-size: 20pt;
			line-height: 35px;
		}
		.autoplay div{
			width:300;
			height: 200;
			background-color: #CCFF47;
		}
	</style>
	<style>
		footer{
			background-image: url(./img/푸터배경.png);
			background-repeat: no-repeat;
			width: 100%;
			padding:0;
			margin:0;
			text-align: center;
			height: 300px;
		}

		.footer-message{
			font-weight: bold;
			font-size:12pt;
			color:white;
		}
		.footer-contact{
			font-size:12pt;
			color:white;
			margin:0.6rem;
		}
		.footer-copyright{
			font-size:12pt;
			color:white;
			margin:0.6rem;
		}
	</style>

	<!--헤더 스크롤-->
	<script>
            $(window).on('scroll',function(){
                if($(window).scrollTop()){
                    $('#header').addClass('active');
                }else{
                    $('#header').removeClass('active');
                }
            });
    </script>
</head>
<body>
	<div id="mainBox">
		<div class="section1">
			<img src="./img/banner.png">
			<div class="center" id="slide">
				<div class="slideBox">
					<div id="posterrecruit"><span>모집중</span></div>
					<p id="postername">2024 에너지 히어로 레이스</p><br>
					<p id="posterdate">📅24.09.21~24.09.21</p>
				</div>
				<div class="slideBox">
					<div id="posterrecruit"><span>접수마감</span></div>
					<p id="postername">2024 공주백제마라톤</p><br>
					<p id="posterdate">📅24.09.22~24.09.22</p>
				</div>
				<div class="slideBox">
					<div id="posterrecruit"><span>모집중</span></div>
					<p id="postername">럽콘브레이킹 30K</p><br>
					<p id="posterdate">📅24.09.22~24.09.22</p>
				</div>
			</div>
		</div>
		<div class="section2">
				<a><p>러닝메이트 매칭하기 →</p></a>
		</div>
		<div class="section3">
			<h1>Everywhere we run!</h1>
			<p>러닝을 사랑하는 모든 사람들을 위한 커뮤니티, 샤샤샥. <br>
				이곳에서는 다양한 러닝 크루를 모집하고, 마라톤 대회 및 관련 정보를 한눈에 확인하세요. <br>
				함께 달리며 건강한 삶을 추구하고, 목표를 향해 나아가는 여정을 공유하는 것은 덤입니다. <br>
				여러분의 러닝을 항상 응원합니다!
			</p>
			<div id="hitmarathon">
				<div id="hit_poster">
					<div id="poster_img">
						<img src="./img/마라톤1.png">
						<div id="recruit"><span>모집중</span></div>
					</div>
					<div>
						<div style="margin: 10px;">📍전국 어디서나</div>
						<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
					</div>
				</div>
				<div id="hit_poster">
					<div id="poster_img">
						<img src="./img/마라톤2.png">
						<div id="recruit"><span>모집중</span></div>
					</div>
					<div>
						<div style="margin: 10px;">📍전국 어디서나</div>
						<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
					</div>
				</div>
				<div id="hit_poster">
					<div id="poster_img">
						<img src="./img/마라톤3.png">
						<div id="recruit"><span>모집중</span></div>
					</div>
					<div>
						<div style="margin: 10px;">📍전국 어디서나</div>
						<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
					</div>
				</div>
				<div id="hit_poster">
					<div id="poster_img">
						<img src="./img/마라톤4.png">
						<div id="recruit"><span>모집중</span></div>
					</div>
					<div>
						<div style="margin: 10px;">📍전국 어디서나</div>
						<div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
					</div>
				</div>
			</div>
			<button id="more1">&nbsp;더알아보기→&nbsp;</button>
		</div>
		<div class="section4">
			<div id="inner1"></div>
			<div id="inner2">
				<h1>Recruiting</h1>
				<p>현재 진행 중인 러닝이벤트를 살펴보세요.</p>
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
		<div class="section5">
			<div id="outer1">
				<div id="inner3"></div>
			</div>

			<div id="inner4">
				<h1>Run Together</h1>
				<p>러닝메이트를 만들어 함께 달려보세요.</p>
				<div id="chatImgBox">
					<img src="./img/채팅2.png" id="chatImg">
					<div id="crewInfo">
						<p>시간맞는 크루끼리 모여</br>정기러닝부터 번개러닝까지</p>
						<p>러닝크루모집페이지에서 원하는 날짜,<br> 원하는 시간에 함께 뛸 크루들을 모집하세요.<br>
							샤샤샥에서 인증된 크루들과 함께 <br>더욱 폭넓고 즐거운 러닝활동을 만들어 가보세요!</p>
					</div>
					<button id="more3">&nbsp;더알아보기→&nbsp;</button>
				</div>
			</div>
		</div>
		<div class="section6">
			<div id="outer2">
				<div id="inner5"></div>
			</div>
			<div id="inner6">
				<h1>Feel this Mood!</h1>
				<p>
					샤샤샥과 함께 러닝한 분들은 현재 이런 느낌을 느끼고 있어요!<br>
					여러분도 함께 느껴요!
				</p>
			</div>
		</div>
	</div>
</body>
</html>