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

    <!-- Bootstrap CSS 연결 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome 아이콘 라이브러리 연결 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        /* 페이지 전체 스타일 */
        body {
            background-color: black;
            color: white;
            margin: 0;
        }

        /* 테이블 형식의 배경 이미지 설정 */
        .header-table {
            width: 100%;
            height: 400px;
            background-image: url('../img/런닝배경사진.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 테이블 위에 텍스트 스타일 */
        .header-text {
            font-size: 3rem;
            font-weight: bold;
            color: white;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);
        }

        #listmain {
            width: 100%;
            height: auto;
            padding: 20px 0;
            background-color: #121212;
        }

        /* 카드 높이 설정 */
        .card {
            height: 100%;
            border: none;
            background-color: rgba(255, 255, 255, 0.1);
            margin-bottom: 0;
        }

        /* 카드 텍스트 색상을 흰색으로 */
        .card-body {
            color: white;
            padding: 10px;
        }

        /* SOLD OUT 텍스트 빨간색 */
        .text-danger {
            color: red;
            margin: 0;
            padding: 0;
        }

        /* 좋아요와 찜 아이콘 스타일 */
        .icon-group {
            display: inline-block;
            margin-left: 10px;
        }

        .icon-group i {
            margin-right: 8px;
            color: white; /* 아이콘 기본 색상을 화이트로 변경 */
            cursor: pointer;
        }

        .icon-group i:hover {
            color: #ff4757;
        }

        /* 클릭된 좋아요 및 찜 아이콘의 색상 설정 */
        .icon-group i.clicked {
            color: red; /* 좋아요 클릭 시 색상 */
        }

        .icon-group i.bookmarked {
            color: yellow; /* 찜 클릭 시 색상 */
        }

        /* 카드 내 텍스트 정렬 */
        .card-body .text-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .heart{
            position: absolute;
            bottom: 15px;
            right:110px;
            z-index: 130;
        }
        .box{
        position: relative;
        }
    </style>
</head>
<body>


<div class="header-table">
    <div class="header-text">
        <!-- 런닝 마라톤 이벤트 -->
    </div>
</div>

<div id="listmain">
    <div class="container mt-5">
        <h1 class="text-center">마라톤 목록</h1>

        <!-- 마라톤 섹션들 -->
        <h2 class="mt-5">2024년 9월 마라톤</h2>
        <div class="row">
            <div class="col-md-3 mb-4 box">
            <i class="fas fa-heart heart" id="likeIcon1" ></i>
                <a href="/marathon/marathonDetail" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/마라톤1.png" class="card-img-top" alt="마라톤 이미지 1">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 1</h5>
                            <p class="card-text">가격: 25,000원</p>
                            <p class="card-text">날짜: 2024-09-27</p>
                            <p class="card-text">장소: 성수동</p>
                            <div class="text-container">
                                <p class="text-danger">SOLD OUT</p>
                                <div class="icon-group">
                                    <span class="icon-text">좋아요</span>
                                     <!-- 좋아요 아이콘 -->
                                    <span class="icon-text">찜</span>
                                    <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <h2 class="mt-5">2024년 10월 마라톤</h2>
        <div class="row">
            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=2" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/마라톤2.png" class="card-img-top" alt="마라톤 이미지 2">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 2</h5>
                            <p class="card-text">가격: 30,000원</p>
                            <p class="card-text">날짜: 2024-10-10</p>
                            <p class="card-text">장소: 강남구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <h2 class="mt-5">2024년 11월 마라톤</h2>
        <div class="row">
            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=3" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/마라톤3.png" class="card-img-top" alt="마라톤 이미지 3">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 3</h5>
                            <p class="card-text">가격: 35,000원</p>
                            <p class="card-text">날짜: 2024-11-15</p>
                            <p class="card-text">장소: 종로구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <h2 class="mt-5">2024년 12월 마라톤</h2>
        <div class="row">
            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=4" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/마라톤4.png" class="card-img-top" alt="마라톤 이미지 4">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 4</h5>
                            <p class="card-text">가격: 40,000원</p>
                            <p class="card-text">날짜: 2024-12-01</p>
                            <p class="card-text">장소: 송파구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=5" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/마라톤4.png" class="card-img-top" alt="마라톤 이미지 5">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 5</h5>
                            <p class="card-text">가격: 20,000원</p>
                            <p class="card-text">날짜: 2024-12-15</p>
                            <p class="card-text">장소: 서초구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <h2 class="mt-5">2025년 1월 마라톤</h2>
        <div class="row mt-4">
            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=6" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/채팅.png" class="card-img-top" alt="마라톤 이미지 6">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 6</h5>
                            <p class="card-text">가격: 50,000원</p>
                            <p class="card-text">날짜: 2025-01-10</p>
                            <p class="card-text">장소: 용산구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=6" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/채팅.png" class="card-img-top" alt="마라톤 이미지 6">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 6</h5>
                            <p class="card-text">가격: 50,000원</p>
                            <p class="card-text">날짜: 2025-01-10</p>
                            <p class="card-text">장소: 용산구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=6" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/채팅.png" class="card-img-top" alt="마라톤 이미지 6">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 6</h5>
                            <p class="card-text">가격: 50,000원</p>
                            <p class="card-text">날짜: 2025-01-10</p>
                            <p class="card-text">장소: 용산구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

            <div class="col-md-3 mb-4">
                <a href="detail.jsp?id=6" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/채팅.png" class="card-img-top" alt="마라톤 이미지 6">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 6</h5>
                            <p class="card-text">가격: 50,000원</p>
                            <p class="card-text">날짜: 2025-01-10</p>
                            <p class="card-text">장소: 용산구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>

            <div class="col-md-3 mb-4">
                    <div class="card">
                <a href="detail.jsp?id=6" style="text-decoration: none; color: inherit;">
                        <img src="../img/채팅.png" class="card-img-top" alt="마라톤 이미지 6">
                </a>
                        <div class="card-body">
                            <h5 class="card-title">마라톤 6</h5>
                            <p class="card-text">가격: 50,000원</p>
                            <p class="card-text">날짜: 2025-01-10</p>
                            <p class="card-text">장소: 용산구</p>
                            <div class="text-container">
                            <p class="text-danger">SOLD OUT</p>
                            <div class="icon-group">
                            <span class="icon-text">좋아요</span>
                            <i class="fas fa-heart" id="likeIcon1"></i> <!-- 좋아요 아이콘 -->
                            <span class="icon-text">찜</span>
                            <i class="fas fa-bookmark" id="bookmarkIcon1"></i> <!-- 찜 아이콘 -->
                            </div>
                        </div>
                    </div>
            </div>
        </div>

    <script>
        // 좋아요 아이콘 클릭 이벤트 처리
        document.getElementById('likeIcon1').addEventListener('click', function () {
            this.classList.toggle('clicked'); // 클릭 시 좋아요 색상 변경
        });

        document.getElementById('bookmarkIcon1').addEventListener('click', function () {
            this.classList.toggle('bookmarked'); // 클릭 시 찜 색상 변경
        });

        document.getElementById('likeIcon2').addEventListener('click', function () {
            this.classList.toggle('clicked'); // 클릭 시 좋아요 색상 변경
        });

        document.getElementById('bookmarkIcon2').addEventListener('click', function () {
            this.classList.toggle('bookmarked'); // 클릭 시 찜 색상 변경
        });
    </script>

    </body>
    </html>