<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- 메타 데이터 설정 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>2024 용인마라톤 대회</title>

    <!-- Bootstrap JS 및 추가 스크립트 연결 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 카카오 지도 API 연결 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c0dd7bd78a44e2891255c1e5f1403da"></script>

    <!-- Bootstrap CSS 연결 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- FontAwesome 아이콘 라이브러리 연결 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- 커스텀 스타일 시트 연결 -->
    <link rel="stylesheet" href="/myapp/css/style.css" type="text/css"/>

    <style>
        /* 컨테이너 전체 설정 (가운데 정렬 및 최대 너비 설정) */
        .container {
            max-width: 100%;
            margin: 0;
            padding: 0;
        }

        /* 페이지 배경색 검정으로 설정, 텍스트 색상 흰색으로 설정 */
        body {
            background-color: #121212;
            color: white;
        }

        /* 테이블 및 이미지의 기본 스타일 설정 */
        .header-table {
            width: 100%;
            margin: 0;
            padding: 0;
        }

        /* 배경 이미지 설정 */
        .header-table img {
            width: 100%;
            height: auto;
            max-height: 400px;
            object-fit: cover;
            display: block;
            margin: 0;
        }

        /* 마라톤 테이블 스타일 (가운데 정렬) */
        .marathon-table {
            width: 100%;
            margin: 20px auto; /* 테이블 가운데 정렬 */
        }

        /* 테이블의 각 셀에 대한 패딩 설정 */
        .marathon-table td {
            vertical-align: top;
            padding: 80px;
        }

        /* 마라톤 이미지의 최대 크기 및 테두리 설정 */
        .marathon-image {
            max-width: 100%;
            max-height: 300px;
            border-radius: 10px;
            margin-bottom: 0px;
        }

        /* 마라톤 타이틀 스타일 설정 */
        .marathon-title {
            font-size: 2.5rem;
            font-weight: bold;
        }

        /* 버튼 컨테이너 스타일 설정 */
        .btn-container {
            margin-top: 30px;
            display: flex;
            gap: 10px;
            justify-content: flex-start;
            padding-right: 200px;
        }

        /* 버튼 내 텍스트를 상하 가운데 정렬 */
        .btn {
            display: flex;
            justify-content: center; /* 텍스트를 버튼 안에서 중앙 정렬 */
            align-items: center; /* 상하 가운데 정렬 */
        }

        /* 좋아요 버튼과 카운트 정렬 */
        .like-container {
            display: flex;
            align-items: center; /* 상하 가운데 정렬 */
        }

        /* 좋아요 버튼 스타일 설정 */
        .btn-like {
            font-size: 1.5rem;
            color: white;
            background-color: transparent;
            border: none;
        }

        /* 좋아요 버튼 클릭 시 색상 변경 */
        .btn-like.clicked {
            color: red;
        }
        /* 마우스를 올려두었을 때 하트 색상 빨간색으로 변경 */
        .btn-like:hover i {
            color: red; /* 마우스를 올려두었을 때 하트 빨간색 */
        }

        /* 좋아요 카운트 스타일 설정 */
        .like-count {
            font-size: 1.2rem;
            margin-left: 5px; /* 하트와 숫자 사이 간격 조절 */
            color: white;
            display: flex;
            align-items: center; /* 숫자를 상하 가운데 정렬 */
        }

        /* 대회 안내 섹션 스타일 */
        .marathon-info-section {
            display: flex;
            flex-direction: column;
            margin: 20px auto;
            max-width: 800px;
            text-align: left;
            padding: 20px;
            background-color: #121212;
            color: white;
        }

        /* 대회 정보 리스트 아이템 스타일 */
        .list-group-item {
            font-size: 1.1rem;
            padding: 5px 10px;
            background-color: #121212;
            color: white;
            border-color: transparent; /* 테두리 투명 */
        }

        /* 지도 버튼 노란색 스타일 설정 */
        .btn-yellow {
            background-color: #f1c40f; /* 기본 배경 노란색 */
            color: black;
            border: none;
        }

        /* 지도 버튼 호버 시 색상 변경 */
        .btn-yellow:hover {
            background-color: #d4ac0d; /* 약간 어두운 노란색으로 변경 */
        }

        /* 지도 iframe 스타일 (지도의 너비와 높이 설정) */
        #mapIframe {
            width: 70%; /* 너비를 %로 설정하여 좌우 공간 확보 */
            height: 700px;
            display: none; /* 기본적으로 숨겨져 있음 */
            border: none;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto; /* 가운데 정렬 */
            margin-bottom: 100px; /* 지도 아래쪽에 여백 추가 */
            border-radius: 10px;
        }

    </style>
</head>
<body>

    <div class="container">

        <!-- 배경 이미지 섹션 -->
        <table class="header-table">
            <tr>
                <td>
                    <!-- 런닝 배경 이미지 삽입 -->
                    <img src="../img/런닝배경사진2.jpg" alt="런닝 배경 이미지">
                </td>
            </tr>
        </table>

        <!-- 마라톤 정보 섹션 -->
        <table class="marathon-table">
            <tr>
                <!-- 이미지 열 -->
                <td class="col-md-6" style="text-align: right;">
                    <!-- 마라톤 관련 이미지 삽입 -->
                    <img src="../img/마라톤1.png" alt="마라톤 이미지" class="marathon-image">
                </td>

                <!-- 대회 정보 열 -->
                <td class="col-md-6">
                    <h1 class="marathon-title">2024 용인마라톤 대회</h1>

                    <!-- 버튼 컨테이너 (결제, 지도로, 좋아요 버튼) -->
                    <div class="btn-container">
                        <!-- 결제 버튼 -->
                        <a href="http://www.naver.com" target="_blank" class="btn btn-primary">결제</a>

                        <!-- "지도로" 버튼 (노란색 배경 적용) -->
                        <a href="#" class="btn btn-yellow" id="findRoadButton">지도</a>

                        <!-- 좋아요 버튼 및 카운트 -->
                        <div class="like-container">
                            <button class="btn btn-like" id="likeButton"><i class="fas fa-heart"></i></button>
                            <span id="likeCount" class="like-count">0</span>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <!-- 길찾기 결과를 표시할 iframe (초기에는 숨김 처리됨) -->
        <iframe id="mapIframe"></iframe>

        <!-- 대회 안내 섹션 구분선 -->
        <hr style="border: 2px solid white; margin-top: 30px; margin-bottom: 30px;">

        <!-- 대회 안내 섹션 (대회 정보 리스트) -->
        <div class="marathon-info-section">
            <h2>대회안내</h2>
            <div class="row">
                <!-- 왼쪽 열: 대회 정보 -->
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item"><strong>일시:</strong> 2024.10.09</li>
                        <li class="list-group-item"><strong>장소:</strong> 경기 용인시 처인구 중부대로 1199</li>
                        <li class="list-group-item"><strong>종목:</strong> 10Km, 5Km</li>
                        <li class="list-group-item"><strong>문의:</strong> 1566-1936</li>
                    </ul>
                </div>
                <!-- 오른쪽 열: 접수 정보 -->
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item"><strong>접수기간:</strong> 2024.08.01 ~ 2024.09.09</li>
                        <li class="list-group-item"><strong>결제가능:</strong> 불가능</li>
                        <li class="list-group-item"><strong>주최:</strong> 용인특례시, 용인신문</li>
                        <li class="list-group-item"><strong>홈페이지:</strong> <a href="http://www.naver.com" target="_blank">주소 입력할것.</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div> <!-- 컨테이너 종료 -->


    <!-- 좋아요 버튼 클릭 이벤트 처리 -->
    <script>
        const likeButton = document.getElementById('likeButton'); // 좋아요 버튼
        const likeCount = document.getElementById('likeCount'); // 좋아요 카운트 표시
        let liked = false; // 좋아요 상태 플래그
        let count = 0; // 초기 좋아요 카운트

        // 좋아요 버튼 클릭 이벤트
        likeButton.addEventListener('click', function () {
            liked = !liked; // 좋아요 상태 토글
            if (liked) {
                this.classList.remove('default'); // 기본 상태 제거
                this.classList.add('clicked'); // 클릭 상태 추가
                count++; // 좋아요 카운트 증가
            } else {
                this.classList.remove('clicked'); // 클릭 상태 제거
                this.classList.add('default'); // 기본 상태 추가
                count--; // 좋아요 카운트 감소
            }

            likeCount.textContent = count; // 좋아요 카운트 업데이트
        });

        // "지도로" 버튼 클릭 시 길찾기 iframe 표시
        document.getElementById('findRoadButton').addEventListener('click', function () {
            const iframe = document.getElementById('mapIframe'); // 지도 iframe 요소 가져오기
            iframe.src = 'https://map.kakao.com/link/to/카카오판교오피스,37.402056,127.108212'; // 카카오 길찾기 URL 설정
            iframe.style.display = 'block'; // iframe을 화면에 표시
        });
    </script>
</body>
</html>
