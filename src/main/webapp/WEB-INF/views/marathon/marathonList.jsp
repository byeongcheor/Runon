<style>
    /* 페이지 전체 스타일 */
    body {
        background-color: black; /* 배경색 검정 */
        color: white; /* 텍스트 색상을 흰색으로 */
        margin: 0; /* 기본 여백 제거 */
    }

    /* 테이블 형식의 배경 이미지 설정 */
    .header-table {
        width: 100%;
        height: 400px; /* 이미지의 높이 */
        background-image: url('../img/런닝배경사진.jpg'); /* 배경 이미지 경로 */
        background-size: cover; /* 배경 이미지가 화면 전체를 덮도록 설정 */
        background-position: center; /* 배경 이미지가 중앙에 위치 */
        background-repeat: no-repeat; /* 배경 이미지 반복 없음 */
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
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8); /* 텍스트에 그림자 추가 */
    }

    #listmain {
        width: 100%;
        height: auto;
        padding: 20px 0; /* 배경 이미지와 내용 사이에 여백 추가 (상단 및 하단) */
        background-color: #121212; /* 배경색을 #121212로 설정 */
    }

    /* 카드 높이 설정 */
    .card {
        height: 100%;
        border: none; /* 카드 테두리 제거 */
        background-color: rgba(255, 255, 255, 0.1); /* 카드 배경을 약간 투명하게 설정 */
        margin-bottom: 0; /* 카드 아래 여백 제거 */
    }

    /* 카드 텍스트 색상을 흰색으로 */
    .card-body {
        color: white;
        padding: 10px; /* 카드 내 여백 설정 */
    }

    /* SOLD OUT 텍스트 빨간색 */
    .text-danger {
        color: red;
        margin: 0; /* SOLD OUT 아래 여백 제거 */
        padding: 0; /* padding도 0으로 설정 */
    }

    /* 카드 내 다른 요소에 대한 여백 제거 */
    .card-text {
        margin-bottom: 5px; /* 다른 카드 텍스트의 아래 여백 줄이기 */
    }

    /* 하단부 배경 테이블 스타일 */
    .bottom-table {
        width: 100%;
        height: 30px; /* 하단부 높이 */
        background-color: black; /* 페이지 배경과 동일한 색 */
        margin-top: 10px; /* 위쪽 여백 */
        border-radius: 10px; /* 모서리를 둥글게 */
    }
</style>

<!-- 상단에 테이블 형식으로 배경 이미지와 텍스트를 넣음 -->
<div class="header-table">
    <div class="header-text">
        2024 런닝 마라톤 이벤트
    </div>
</div>

<div id="listmain">
    <div class="container mt-5">
        <h1 class="text-center">마라톤 목록</h1>

        <!-- 마라톤 섹션들 -->
        <h2 class="mt-5">2024년 9월 마라톤</h2>
        <div class="row">
            <div class="col-md-3 mb-4">
                <a href="/marathon/marathonDetail" style="text-decoration: none; color: inherit;">
                    <div class="card">
                        <img src="../img/마라톤1.png" class="card-img-top" alt="마라톤 이미지 1">
                        <div class="card-body">
                            <h5 class="card-title">마라톤 1</h5>
                            <p class="card-text">가격: 25,000원</p>
                            <p class="card-text">날짜: 2024-09-27</p>
                            <p class="card-text">장소: 성수동</p>
                            <p class="text-danger">SOLD OUT</p>
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
                            <p class="text-danger">SOLD OUT</p>
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
                            <p class="text-danger">SOLD OUT</p>
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
                            <p class="text-danger">SOLD OUT</p>
                        </div>
                    </div>
                </a>
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
                            <p class="text-danger">SOLD OUT</p>
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
                            <p class="text-danger">SOLD OUT</p>
                        </div>
                    </div>
                </a>
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
                            <p class="text-danger">SOLD OUT</p>
                        </div>
                    </div>
                </a>
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
                            <p class="text-danger">SOLD OUT</p>
                        </div>
                    </div>
                </a>
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
                            <p class="text-danger">SOLD OUT</p>
                        </div>
                    </div>
                </a>
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
                            <p class="text-danger">SOLD OUT</p>
                        </div>
                    </div>
                </a>
            </div>
       </div>
    </div>
