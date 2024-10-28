var boardSearchType = null;
var boardSearchValue = null;


setTimeout(function() {
    var page;

    if (usercode1!=null &&usercode1!=0 &&usercode1!=""){
        $.ajax({
            url:"/adminPages/checkuser",
            type:"post",
            data:{
                usercode:usercode1
            },success:function(r){
                var role=r.role;
                if (role!="ROLE_USER"){
                    loadBoardPage(page);
                }else{
                    window.location.href="/";
                }


            }
        })

    }else{
        window.location.href="/";
    }


}, 200);

function loadBoardPage(page, boardSearchType, boardSearchType2, boardSearchValue) {
    if (page == null) {
        page = 1;

    }

    var BoardData = {
        page: page,
        searchKey: boardSearchType,
        searchWord: boardSearchValue,
        usercode:usercode1
    };
    // 마라톤명 검색이 있을 경우
    if (boardSearchType === "marathon_name" && boardSearchValue) {
        BoardData.searchKey = boardSearchType; // 마라톤명으로 검색
        BoardData.searchWord = boardSearchValue; // 검색어 설정
    }
    // 활성화 여부 또는 삭제 여부 검색이 있을 경우
    if (boardSearchType === "is_active" && boardSearchValue) {
        BoardData.searchKey = boardSearchType;
        BoardData.searchWord = boardSearchValue === "Y" ? 1 : 0; // "Y"일 때 1, "N"일 때 0
    }
    if (boardSearchType === "is_deleted" && boardSearchValue) {
        BoardData.searchKey = boardSearchType;
        BoardData.searchWord = boardSearchValue === "Y" ? 1 : 0; // "Y"일 때 1, "N"일 때 0
    }

    $.ajax({
        url: "/adminPages/BoardList",
        type: "post",
        data: BoardData,
        success: function(r) {
          /*  console.log("Total Records: ", r.pvo.totalRecord);
            console.log("Total Pages: ", r.pvo.totalPage);*/
            var BoardList = r.list;
            var pVO = r.pvo;
            var roles=r.Avo.role;
            var cerate=r.Avo.permission_add;
            var deleted=r.Avo.permission_delete;
            var edit=r.Avo.permission_edit;
            console.log(roles);
            if (r.list.length > 0) {
                // 결과값이 존재할 때 검색어 초기화
                document.getElementById("searchtext").value = ""; // 검색어 입력 필드의 ID가 'searchInput'인 경우
            }
            if (roles<3||r.pvo.admin_code==0){
                if (roles<2||r.pvo.admin_code==0){
                    var downloadbuttontag = `<input type="button" value="게시글 리스트 받기" onClick="excelDownload()"/>`;
                    document.getElementById("downloadbutton").innerHTML = downloadbuttontag;
                    document.getElementById("downloadbutton").style.display = "block";
                }
                //작성하기 버튼 생성
                if (cerate=="1"||r.pvo.admin_code==0){
                    var writeButtonHtml  = `<input type="button" value="글 작성하기" onClick="writePost()"/>`;
                    document.getElementById("writebutton").innerHTML = writeButtonHtml; // 기존 버튼을 덮어씀
                    document.getElementById("writebutton").style.display = "block";
                }

            }
            var tag = "<li><div id='board_title2'><div class='board_code'>마라톤번호</div><div class='marathon_name'>마라톤명</div>";
            tag += "<div class='created_date'>생성날짜</div><div class='activation_date'>활성화 여부</div>";
            tag += "<div class='deleted_date'>삭제 여부</div><div class='deleted_date'>삭제 완료일</div>"; // 삭제 완료일 추가
            if (roles<3||r.pvo.admin_code==0){
                if (edit== "1"||r.pvo.admin_code==0){
                    tag += "<div class='edit_button'>수정</div>";
                }
                if (deleted== "1" ||r.pvo.admin_code==0){
                    tag +="<div class='delete_button'>삭제</div>";
                }
            }
            tag += "</div></li>";
            /*console.log("BoardData:", BoardData); // AJAX 호출 전에 추가*/

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
                if(roles<3){
                    // 수정 및 삭제 버튼
                    if (edit=="1"||r.pvo.admin_code==0){
                        tag += "<div class='edit_button'><button class='btn btn-outline-success' onClick='editMarathon(" + board.marathon_code + ")'>수정</button></div>";
                    }
                    if (deleted=="1"||r.pvo.admin_code==0){
                        tag += "<div class='delete_button'><button class='btn btn-outline-danger' onClick='deleteBoard(" + board.marathon_code + ")'>삭제</button></div>";
                    }
                }
                tag += "</div></li>";
            });

            document.getElementById("BoardList").innerHTML = tag;

            var paginationTag = "";
            var totalPages = Math.ceil(pVO.totalRecord / pVO.onePageRecord); // 총 페이지 수 계산


// 이전 버튼
            if (pVO.nowPage > 1) {
                paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadBoardPage(" + (pVO.nowPage - 1) + ");'>Previous</a></li>";
            }

// 페이지 번호 표시 (현재 페이지를 기준으로 최대 5페이지까지 표시)
            var startPage = Math.max(1, pVO.nowPage - 2); // 시작 페이지
            var endPage = Math.min(startPage + 4, pVO.totalPage); // 끝 페이지

            if (endPage - startPage < 4) {
                startPage = Math.max(1, endPage - 4); // 시작 페이지가 1보다 작으면 조정
            }

            for (var p = startPage; p <= endPage; p++) {
                paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:loadBoardPage(" + p + ");'>" + p + "</a></li>";
            }

// 다음 버튼
            if (pVO.nowPage < pVO.totalPage) {
                paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadBoardPage(" + (pVO.nowPage + 1) + ");'>Next</a></li>";
            }


// 페이징 태그 삽입
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

// 검색 버튼 클릭 시 호출되는 함수
function searchbutton() {
    const boardSearchType = document.getElementById("BoardSearchValue").value; // 선택된 검색 조건
    const boardSearchValue = document.getElementById("searchtext").value; // 검색어

    // 콘솔 로그를 추가하여 디버깅
/*    console.log("Search Type:", boardSearchType);
    console.log("Search Value:", boardSearchValue);*/

    // 조건에 따라 검색어를 어떻게 처리할지 정의
    let searchType = null;

    if (boardSearchType === "marathon_name") {
        searchType = "marathon_name"; // 마라톤명 검색
    } else if (boardSearchType === "is_active") {
        searchType = "is_active"; // 활성화 여부 검색
    } else if (boardSearchType === "is_deleted") {
        searchType = "is_deleted"; // 삭제 여부 검색
    }

    // 검색을 수행
    loadBoardPage(1, boardSearchType, null, boardSearchValue); // searchKey2를 null로 설정
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
                /*console.log(response);*/
                if (response.ok) {
                    alert("삭제되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("삭제에 실패했습니다.");
                }
            })
            .catch(error => {
               /* console.error('삭제 중 오류 발생:', error);
                alert("삭제 중 오류가 발생했습니다.");*/
            });
    }else{
        alert("삭제를 취소하셨습니다");
    }
}

function changeOption() {
    const searchValue = document.getElementById('BoardSearchValue').value;
    const searchText = document.getElementById('searchtext');

    // 선택된 검색 조건에 따라 placeholder 변경
    if (searchValue === 'marathon_name') {
        searchText.placeholder = '마라톤명을 입력하세요';
    } else if (searchValue === 'is_active') {
        searchText.placeholder = '활성화 여부 (Y/N)';
    } else if (searchValue === 'is_deleted') {
        searchText.placeholder = '삭제 여부 (Y/N)';
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
          /*  console.log/!*("서버에서 받아온 값 ",r);*!/*/
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
