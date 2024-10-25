var boardSearchType = null;
var boardSearchValue = null;
var boardSearchType2 = null;

setTimeout(function() {
    var page;
    loadBoardPage(page);
}, 200);

function loadBoardPage(page, boardSearchType, boardSearchType2, boardSearchValue) {
    if (page == null) {
        page = 1;

    }

    var BoardData = {
        page: page,
        searchKey: boardSearchType,
        searchKey2: boardSearchType2,
        searchWord: boardSearchValue
    };

    if (boardSearchType && boardSearchValue) {
        BoardData.searchKey = boardSearchType;
        BoardData.searchWord = boardSearchValue;
    }
    // 활성화 여부 또는 삭제 여부 검색
    if (boardSearchType2 && boardSearchValue) {
        BoardData.searchKey2 = boardSearchType2;
        BoardData.searchWord2 = boardSearchValue;  // 추가로 검색어를 전달
    }

    $.ajax({
        url: "/adminPages/BoardList",
        type: "post",
        data: BoardData,
        success: function(r) {

            var BoardList = r.list;
            var pVO = r.pvo;
            var logininfo = r.Avo;




            var downloadbuttontag = `<input type="button" value="게시글 리스트 받기" onClick="excelDownload()"/>`;
            document.getElementById("downloadbutton").innerHTML = downloadbuttontag;
            document.getElementById("downloadbutton").style.display = "block";

            // 추가된 부분: 글 작성하기 버튼 추가
            var writeButtonHtml  = `<input type="button" value="글 작성하기" onClick="writePost()"/>`;
            document.getElementById("writebutton").innerHTML += writeButtonHtml; // 기존 버튼 다음에 추가
            document.getElementById("writebutton").style.display = "block";

            var tag = "<li><div id='board_title2'><div class='board_code'>마라톤번호</div><div class='marathon_name'>마라톤명</div>";
            tag += "<div class='created_date'>생성날짜</div><div class='activation_date'>활성화 여부</div>";
            tag += "<div class='deleted_date'>삭제 여부</div><div class='deleted_date'>삭제 완료일</div>"; // 삭제 완료일 추가
            tag += "<div class='edit_button'>수정</div><div class='delete_button'>삭제</div>";
            tag += "</div></li>";
            console.log("BoardData:", BoardData); // AJAX 호출 전에 추가

            BoardList.forEach(function (board) {
                tag += "<li><div class='board_title3'><div class='marathon_code'>" + board.marathon_code + "</div>";
                tag += "<div class='marathon_name' onClick='goToDetail(" + board.marathon_code + ")' style='cursor: pointer;'>" + board.marathon_name + "</div>";
                tag += "<div class='created_date'>" + board.created_date + "</div>";

                // 활성화 여부: 숫자 1이면 활성화, 0이면 비활성화
                var isActive = board.is_active == 1 ? "Y" : "N";
                tag += "<div class='is_active'>" + isActive + "</div>";

                // 삭제 여부: 숫자 1이면 삭제됨, 0이면 존재
                var isDeleted = board.is_deleted == 1 ? "Y" : "N";
                tag += "<div class='is_deleted'>" + isDeleted + "</div>";

                // 삭제 날짜: is_deleted가 1일 때만 표시
                if (board.is_deleted == 1 && board.deleted_date) {
                    tag += "<div class='deleted_date'>" + board.deleted_date + "</div>";
                } else {
                    tag += "<div class='deleted_date'>N/A</div>";
                }

                // 수정 및 삭제 버튼
                tag += "<div class='edit_button'><button class='btn btn-outline-success' onClick='editMarathon(" + board.marathon_code + ")'>수정</button></div>";
                tag += "<div class='delete_button'><button class='btn btn-outline-danger' onClick='deleteBoard(" + board.marathon_code + ")'>삭제</button></div>";
                tag += "</div></li>";
            });

            document.getElementById("BoardList").innerHTML = tag;

            var paginationTag = "";
            if (pVO.nowPage > 1) {
                paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadBoardPage(" + (pVO.nowPage - 1) + ");'>Previous</a></li>";
            }
            for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
                paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:loadBoardPage(" + p + ");'>" + p + "</a></li>";
            }
            if (pVO.nowPage < pVO.totalPage) {
                paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadBoardPage(" + (pVO.nowPage + 1) + ");'>Next</a></li>";
            }

            $(".pagination").html(paginationTag);

        },
        error: function (xhr, status, error) {
            console.error("AJAX Error: ", status, error);
            console.error("Response Text: ", xhr.responseText); // 서버의 응답 텍스트 출력
        }

    });
}

// 마라톤 상세 페이지로 이동하는 함수는 여기 넣습니다.
function goToDetail(marathonCode) {
    window.location.href = '/marathon/marathonDetail/' + marathonCode;
}
function editMarathon(marathonCode) {
    window.location.href = '/adminPages/boardEdit/marathonCode/' + marathonCode;
}

function searchbutton() {
    boardSearchType = document.getElementById("BoardSearchValue").value;
    boardSearchType2 = document.getElementById("BoardSearchValue2").value;
    boardSearchValue = document.getElementById("searchtext").value;

    // 콘솔 로그를 추가하여 디버깅
    console.log("Search Type:", boardSearchType);
    console.log("Search Type 2:", boardSearchType2);
    console.log("Search Value:", boardSearchValue);

    // 조건에 따라 검색어를 어떻게 처리할지 정의
    if (boardSearchType === "marathon_name") {
        alert("마라톤명 검색:" + boardSearchValue);
    } else if (boardSearchType2 === "is_active" || boardSearchType2 === "is_deleted") {
        alert(boardSearchType2 + " 상태로 검색: " + boardSearchValue);
    }

    loadBoardPage(1, boardSearchType, boardSearchType2, boardSearchValue);
}


function enterKey(event) {
    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}

function deleteBoard(marathonCode) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        fetch(`/adminPages/delete/${marathonCode}`, {
            method: 'POST' // 'DELETE' 대신 'POST'로 변경
        })
            .then((response) => {
                console.log(response);
                if (response.ok) {
                    alert("삭제되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(error => {
                console.error('삭제 중 오류 발생:', error);
                alert("삭제 중 오류가 발생했습니다.");
            });
    }
}

function changeOption() {
    var searchValue = document.getElementById("BoardSearchValue").value;
    var searchValue2 = document.getElementById("BoardSearchValue2").value;

    // 마라톤명이 선택된 경우
    if (searchValue === "marathon_name") {
        document.getElementById("searchtext").placeholder = "마라톤명을 입력하세요";
        document.getElementById("searchtext").style.width = "300px";
        document.getElementById("BoardSearchValue2").style.display = "block"; // 활성화 여부/삭제 여부 셀렉트 박스 보여줌
    }

    // 활성화 여부가 선택된 경우
    else if (searchValue2 === "is_active") {
        document.getElementById("searchtext").placeholder = "Y:활성화 N:비활성화";
        document.getElementById("BoardSearchValue").style.display = "none"; // 마라톤명 셀렉트 박스 숨김
    }
    // 삭제 여부가 선택된 경우
    else if (searchValue2 === "is_deleted") {
        document.getElementById("searchtext").placeholder = "Y:삭제됨 N:삭제되지 않음";
        document.getElementById("BoardSearchValue").style.display = "none"; // 마라톤명 셀렉트 박스 숨김
    }

    document.getElementById("searchtext").focus();
}

// 글 작성 페이지로 이동하는 함수
function writePost() {
    window.location.href = '/adminPages/writePost'; // 글 작성 페이지의 URL로 변경
}
//boardList 엑셀로 받기
function excelDownload(){
    $.ajax({
        url:"/adminPages/boardListDownload",
        type:"post",
        success:function(r){
            console.log("서버에서 받아온 값 ",r);
            download(r);
        }
    });

}
function download(data){

    const ws = XLSX.utils.json_to_sheet(data.list);  // JSON 데이터를 Worksheet로 변환
    const wb = XLSX.utils.book_new();  // 새로운 Workbook 생성
    XLSX.utils.book_append_sheet(wb, ws, "Sheet1");  // 워크시트를 Workbook에 추가
    XLSX.writeFile(wb, "data.xlsx");  // Excel
}


function reset() {
    loadBoardPage(1);
}
