<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Bootstrap JS 및 추가 스크립트 연결 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap CSS 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<%--    <!-- FontAwesome 아이콘 라이브러리 연결 -->--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">--%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="/css/marathonList.css" type="text/css">



<!-- 상단이미지 -->
<div class="marathonFrm">
    <div class="marathonFrmImg">
        <img src="/img/marathonListImg.jpg"/>
    </div>
    <!-- 상단부분 -->
    <div class="marathonListTop">
        <h2 id="courseName">마라톤 대회</h2>
        <div class="marathonF" style="text-align: right; margin-right: 70px; margin-bottom: 100px;">
            <span id="sort-view" style="cursor:pointer;">조회순</span> |
            <span id="sort-like" style="cursor:pointer;">좋아요순</span>
        </div>
        <!--필터 검색 -->
        <div class="mFilter-search">
            <!-- 전체년도 필터 -->
            <select id="year-filter">
                <option value="" selected>전체년도</option>
                <option value="2024">2024년</option>
                <option value="2025">2025년</option>
            </select>

            <!-- 전체월 필터 -->
            <select id="month-filter">
                <option value="" selected>전체월</option>
                <option value="1">1월</option>
                <option value="2">2월</option>
                <option value="3">3월</option>
                <option value="4">4월</option>
                <option value="5">5월</option>
                <option value="6">6월</option>
                <option value="7">7월</option>
                <option value="8">8월</option>
                <option value="9">9월</option>
                <option value="10">10월</option>
                <option value="11">11월</option>
                <option value="12">12월</option>
            </select>

            <!-- 지역 필터 -->
            <select id="mRegion-filter">
                <option value="" selected>지역</option> <!-- 기본으로 선택 -->
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="부산">부산</option>
                <option value="대구">대구</option>
                <option value="인천">인천</option>
                <option value="광주">광주</option>
                <option value="대전">대전</option>
                <option value="울산">울산</option>
                <option value="세종">세종</option>
                <option value="강원">강원</option>
                <option value="충북">충북</option>
                <option value="충남">충남</option>
                <option value="전북">전북</option>
                <option value="전남">전남</option>
                <option value="경북">경북</option>
                <option value="경남">경남</option>
                <option value="제주">제주</option>
            </select>

            <!-- 검색 입력 필드 -->
            <input type="text" id="search-input" placeholder="검색어를 입력하세요">

            <!-- 검색 버튼 -->
            <button id="mSearch-button" class="btn btn-outline-secondary">Search</button>
        </div>

        <!-- 대회 일정 -->
        <div class="marathon-container" id="marathon-list">
            <c:forEach var="marathon" items="${list}">
                <div class="marathon-card">
                    <div class="marathon-card2">
                        <div class="marathonC">
                            <!-- 카드 한 개 -->
                            <div class="marathonC2" onclick="goToDetailPage(${marathon.marathon_code})">
                                <div class="marathonListI">
                                    <div class="imgBox">
                                        <img src="/img/marathonPoster/${marathon.poster_img}" alt="마라톤 이미지">
                                    </div>

                                    <div class="receiptType">
                                        <span style="
                                        <c:if test='${marathon.registration_status == "접수마감"}'>color:red;</c:if>
                                        <c:if test='${marathon.registration_status == "접수 시작 전"}'>color:green; font-weight: bold;</c:if>
                                                ">
                                                ${marathon.registration_status}
                                        </span>
                                    </div>
                                </div>
                                <div class="marathonListContent">
                                    <span>📍 ${marathon.mainLocation}</span>
                                    <div class="mTitle">${marathon.marathon_name}</div>
                                    <div class="mPrice">${marathon.entry_fee}</div>
                                    <div class="mSubject">
                                        <div class="mH">
                                            <span>👀 ${marathon.hit}&nbsp;❤️ ${marathon.like_count}</span>
                                        </div>
                                        <div class="mDate">📅 ${marathon.event_date}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 페이징 UI -->
        <ul class="pagination justify-content-center" style="margin:100px;" id="paging">
            <!-- 이전 페이지 버튼 -->
            <c:if test="${pvo.nowPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="?nowPage=${pvo.nowPage - 1}&searchKey=${pvo.searchKey}&searchWord=${pvo.searchWord}&addr=${pvo.addr}">&lt;</a>
                </li>
            </c:if>

            <!-- 페이지 번호 출력 -->
            <c:forEach var="p" begin="${pvo.startPageNum}" end="${pvo.startPageNum + pvo.onePageNum - 1}">
                <c:if test="${p <= pvo.totalPage}">
                    <li class="page-item <c:if test="${p == pvo.nowPage}">active</c:if>">
                        <a class="page-link" href="?nowPage=${p}&searchKey=${pvo.searchKey}&searchWord=${pvo.searchWord}&addr=${pvo.addr}">${p}</a>
                    </li>
                </c:if>
            </c:forEach>

            <!-- 다음 페이지 버튼 -->
            <c:if test="${pvo.nowPage < pvo.totalPage}">
                <li class="page-item">
                    <a class="page-link" href="?nowPage=${pvo.nowPage + 1}&searchKey=${pvo.searchKey}&searchWord=${pvo.searchWord}&addr=${pvo.addr}">&gt;</a>
                </li>
            </c:if>
        </ul>



    </div>
</div>
<script>
    function goToDetailPage(marathonCode) {
       // URL 인코딩
        window.location.href = '/marathon/marathonDetail/' + marathonCode;
    }


    ///필터 검색

    $(document).ready(function() {
        $('#mSearch-button').on('click', function() {
            const year = $('#year-filter').val() || ""; // 기본값 설정
            const month = $('#month-filter').val() || ""; // 기본값 설정
            const addr = $('#mRegion-filter').val() || ""; // 기본값 설정
            const searchTerm = $('#search-input').val().trim() || ""; // 기본값 설정

            // 검색어 출력
            console.log('검색어:', searchTerm); // 여기에 추가합니다.

            // 아무것도 선택하지 않았을 경우
            if (!year && !month && !addr && !searchTerm) {
                alert("옵션 또는 검색어를 입력하세요.");
                return;
            }

            // 필터링된 데이터를 가져오는 AJAX 요청
            fetchFilteredData(year, month, addr, searchTerm);

        });


        // 조회순 클릭 이벤트
        $('#sort-view').on('click', function() {
            fetchFilteredData(null, null, null, null, '2');
        });

        // 좋아요순 클릭 이벤트
        $('#sort-like').on('click', function() {
            fetchFilteredData(null, null, null, null, '1');
        });
    });

    document.getElementById('search-input').addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            document.getElementById('mSearch-button').click(); // 'mSearch-button' 버튼을 클릭한 것과 동일한 동작
        }
    });


    function fetchFilteredData(year, month, addr, searchTerm, sortOrder) {
        // 검색어 출력
        console.log(addr+"----------------")
        console.log('검색어:', searchTerm); // 여기에 추가합니다.
        console.log('전송할 데이터:', {
            year: year || null,
            month: month || null,
            region: addr || null,
            search: searchTerm || null,
            sort1: sortOrder || null

        });
        $.ajax({
            url: '/marathon/filter', // 필터링된 데이터를 요청할 엔드포인트
            method: 'GET',
            data: {
                year: year || null,         // 선택한 연도
                month: month || null,       // 선택한 월
                addr: addr || null,     // 선택한 지역
                search: searchTerm || null,  // 검색어
                sort1: sortOrder || null    // 정렬 기준

            },
            success: function(response) {
                console.log("AJAX 응답:", response); // 응답 데이터 확인
                updateMarathonList(response);

            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 오류:", status, error);
                alert("상태: " + status + "\n오류 메시지: " + error);
            }
        });
    }

    function updateMarathonList(data) {
        console.log('서버에서 받은 데이터:', data); // 서버 응답 확인
        // 필터링된 데이터와 총 레코드 수를 처리하는 UI 업데이트 로직을 작성합니다.
        // const totalRecord = data.totalRecord;
        var pVO = data.pvo;
        console.log('pVO:', pVO.totalRecord);
        const marathons = data.filteredMarathons || []; // 기본값으로 빈 배열 설정
        // UI에 마라톤 리스트 업데이트 로직 추가
        // 예: 리스트를 비우고 새로 추가
        $('#marathon-list').empty(); // 마라톤 리스트가 있는 DOM 요소의 ID에 맞게 변경

        if (!Array.isArray(marathons) || marathons.length === 0) {
            $('#marathon-list').append('<p>검색 결과가 없습니다.</p>');
        } else {
            // 마라톤 카드를 추가할 HTML 문자열 생성
            let marathonHTML = '';
            marathons.forEach(marathon => {
                console.log(marathon);
                marathonHTML += `
                    <div class="marathon-card">
                        <div class="marathon-card2">
                            <div class="marathonC">
                                <div class="marathonC2" onclick="goToDetailPage(` + marathon.marathon_code + `)">
                                    <div class="marathonListI">
                                        <img src="/img/marathonPoster/` + marathon.poster_img + `" style="width: 300px; height: 300px;">
                                        <div class="receiptType">
                                             <span style="` + (marathon.registration_status == '접수마감' ? 'color:red;' : marathon.registration_status == '접수 시작 전' ? 'color:green; font-weight: bold;' : '') + `">
                                    ` + marathon.registration_status + `
                                </span>
                                        </div>
                                    </div>
                                    <div class="marathonListContent">
                                        <span>📍 ` + marathon.mainLocation + `</span>
                                        <div class="mTitle">` + marathon.marathon_name + `</div>
                                        <div class="mPrice">` + marathon.entry_fee + `원</div>
                                        <div class="mSubject">
                                            <div class="mH">
                                                <span>👀 ` + marathon.hit + `&nbsp;❤️ ` + marathon.like_count + `</span>
                                            </div>
                                            <div class="mDate">📅 ` + marathon.event_date + `</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
            });

            $('#marathon-list').append(marathonHTML);


            // 필터링 조건을 가져옵니다.
            let searchKey = $("#searchKey").val();
            let searchWord = $("#searchWord").val();
            let addr = $("#addr").val();

            // 페이징 태그 생성
            let paginationTag = "";
            const totalPages = Math.ceil(pVO.totalRecord / pVO.onePageRecord);

            // 이전 버튼
            if (pVO.nowPage > 1) {
                paginationTag += "<li class='page-item'>" +
                    "<a class='page-link' href='javascript:void(0);' onclick='loadBoardPage(" + (pVO.nowPage - 1) + ", \"" + searchKey + "\", \"" + searchWord + "\", \"" + addr + "\");'>&lt;</a>" +
                    "</li>";
            }

            // 페이지 번호 표시
            let startPage = Math.max(1, pVO.nowPage - 2);
            let endPage = Math.min(startPage + 4, totalPages);

            // 시작 페이지 조정
            if (endPage - startPage < 4) {
                startPage = Math.max(1, endPage - 4);
            }

            for (let p = startPage; p <= endPage; p++) {
                paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'>" +
                    "<a class='page-link' href='javascript:void(0);' onclick='loadBoardPage(" + p + ", \"" + searchKey + "\", \"" + searchWord + "\", \"" + addr + "\");'>" + p + "</a>" +
                    "</li>";
            }

            // 다음 버튼
            if (pVO.nowPage < totalPages) {
                paginationTag += "<li class='page-item'>" +
                    "<a class='page-link' href='javascript:void(0);' onclick='loadBoardPage(" + (pVO.nowPage + 1) + ", \"" + searchKey + "\", \"" + searchWord + "\", \"" + addr + "\");'>&gt;</a>" +
                    "</li>";
            }

            // 페이징 태그 삽입
            $("#paging").html(paginationTag);
        }

    }


</script>

