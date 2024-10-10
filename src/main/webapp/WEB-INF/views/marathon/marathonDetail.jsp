<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>2024 용인마라톤 대회</title>

    <!-- Bootstrap CSS 라이브러리 연결 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 커스텀 스타일 시트 연결 -->
    <link rel="stylesheet" href="/myapp/css/style.css" type="text/css"/>

    <style>
        /* 전체 컨테이너 중앙 정렬 */
        .container {
            max-width: 100%; /* 최대 너비를 100%로 설정 */
            margin: 0; /* 자동 여백으로 가운데 정렬 */
            padding: 0; /* 좌우 여백 제거 */
        }

        /* 배경색 검정으로 설정 */
        body {
            background-color: #121212; /* 배경색을 #121212로 변경 */
            color: white; /* 텍스트 색상을 흰색으로 변경 */
        }

        /* 새로운 테이블 스타일 설정 */
        .header-table {
            width: 100%; /* 너비를 100%로 설정 */
            height: auto; /* 높이를 자동으로 설정하여 비율에 맞추기 */
            margin: 0; /* 여백 제거 */
            padding: 0; /* 패딩 제거 */
            border: none; /* 테두리 제거 */
        }

        /* 런닝 배경 이미지 스타일 */
        .header-table img {
            width: 100%; /* 페이지 너비에 맞춤 */
            height: auto; /* 비율에 맞게 자동 조정 */
            max-height: 400px; /* 최대 높이 설정 */
            object-fit: cover; /* 비율 유지하며 채우기 */
            display: block; /* 이미지를 블록 요소로 만들어 여백 제거 */
            margin: 0; /* 여백 제거 */
        }

        /* 테이블과 셀 스타일 설정 */
        .marathon-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; /* 이미지 위에 여백 추가 */
        }

        .marathon-table td {
            vertical-align: top;
            padding: 80px;
        }

        /* 이미지의 크기와 모양 */
        .marathon-image {
            width: auto; /* 가로 자동 조정 */
            height: auto; /* 비율에 맞게 자동 조정 */
            max-width: 100%; /* 최대 너비를 80%로 줄임 */
            max-height: 300px; /* 최대 높이를 줄여서 페이지 크기 시 사진 크기 조정 */
            border-radius: 10px;
            margin-bottom: 20px; /* 이미지 아래에 여백 추가 */
        }

        /* 대회명 제목 스타일 설정 */
        .marathon-title {
            font-size: 2.5rem; /* 글자 크기 크게 조정 */
            font-weight: bold;
        }

        /* 홈페이지 이동 버튼 정렬 */
        .btn-container {
            margin-top: 30px; /* 버튼 위에 여백 추가 */
        }

        /* 대회 안내 섹션 스타일 */
        .marathon-info-section {
            display: flex; /* Flexbox 사용 */
            justify-content: flex-start; /* 왼쪽 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
            flex-direction: column; /* 세로 방향으로 정렬 */
            margin-top: 20px; /* 대회 안내 위에 여백 추가 */
            margin-bottom: 150px; /* 대회 안내 아래에 여백 추가 */
            text-align: left; /* 텍스트는 왼쪽 정렬 유지 */
            background-color: #121212; /* 배경색을 #121212로 설정 */
            color: white; /* 텍스트 색상을 흰색으로 변경 */
            padding: 20px; /* 패딩 추가 */
        }

        .list-group-item {
            font-size: 1.1rem;
            border-color: transparent; /* 셀 테두리를 투명하게 설정 */
            padding: 5px 10px; /* 좌우 패딩을 줄여서 셀 테두리 크기 조정 */
            background-color: #121212; /* 배경색 #121212로 설정 */
            color: white; /* 글씨 색상을 흰색으로 변경 */
        }
    </style>
</head>
<body>

    <!-- 전체 컨테이너 -->
    <div class="container">

        <!-- 새로운 테이블로 런닝 배경 이미지 추가 -->
        <table class="header-table">
            <tr>
                <td>
                    <img src="../img/런닝배경사진2.jpg" alt="런닝 배경 이미지"> <!-- 이미지 추가 -->
                </td>
            </tr>
        </table>

        <!-- 이미지와 대회 정보 섹션을 포함하는 테이블 -->
        <table class="marathon-table">
            <tr>
                <!-- 이미지 열 -->
                <td class="col-md-6" style="text-align: right;"> <!-- 오른쪽 정렬 -->
                    <img src="../img/마라톤1.png" alt="마라톤 이미지" class="marathon-image"> <!-- 마라톤 이미지 -->
                </td>

                <!-- 대회 정보 열 -->
                <td class="col-md-6">
                    <p class="marathon-subtitle">마라톤</p>
                    <h1 class="marathon-title">2024 용인마라톤 대회</h1>

                    <!-- 홈페이지 이동 버튼을 중앙으로 정렬 -->
                    <div class="btn-container">
                        <a href="http://www.naver.com" target="_blank" class="btn btn-primary">홈페이지 이동</a>
                    </div>
                </td>
            </tr>
        </table>

        <!-- 대회 안내 섹션 구분선 추가 -->
        <hr style="border: 2px solid white; margin-top: 30px; margin-bottom: 30px;">

        <!-- 대회 안내 섹션 -->
        <div class="marathon-info-section">
            <h2>대회안내</h2>
            <div class="row">
                <!-- 왼쪽 정보 -->
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item"><strong>일시:</strong> 2024.10.09</li>
                        <li class="list-group-item"><strong>장소:</strong> 경기 용인시 처인구 중부대로 1199</li>
                        <li class="list-group-item"><strong>종목:</strong> 10Km, 5Km</li>
                        <li class="list-group-item"><strong>문의:</strong> 1566-1936</li>
                    </ul>
                </div>
                <!-- 오른쪽 정보 -->
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

    <!-- Bootstrap JS 및 추가 스크립트 연결 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
