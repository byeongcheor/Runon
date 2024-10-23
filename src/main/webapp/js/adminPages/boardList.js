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
        page: page
    };

    if (boardSearchType && boardSearchValue) {
        BoardData.searchKey = boardSearchType;
        BoardData.searchWord = boardSearchValue;
    }

    if (boardSearchType2 && boardSearchValue2) {
        BoardData.searchKey2 = boardSearchType2;
    }
    if (usercode1){
        BoardData.usercode=usercode1;
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


            var tag = "<li><div id='board_title2'><div class='board_code'>마라톤번호</div><div class='marathon_name'>마라톤명</div>";
            tag += "<div class='created_date'>생성날짜</div><div class='activation_date'>활성화 여부</div>";
            tag += "<div class='deleted_date'>삭제 여부</div>";
            tag += "<div class='edit_button'>수정</div><div class='delete_button'>삭제</div>";
            tag += "</div></li>";

            BoardList.forEach(function (board) {
                tag += "<li><div class='board_title3'><div class='marathon_code'>" + board.marathon_code + "</div>";
                tag += "<div class='marathon_name' onClick='goToDetail(" + board.marathon_code + ")' style='cursor: pointer;'>" + board.marathon_name + "</div>";
                tag += "<div class='created_date'>" + board.created_date + "</div>";

                // 활성화 여부: 숫자 1이면 활성화, 0이면 비활성화
                var isActive = board.is_active == 1 ? "Y" : "N";
                tag += "<div class='is_active'>" + isActive + "</div>";

                // // 활성화 날짜: is_active가 1일 때만 표시
                // if (board.is_active == 1 && board.activation_date) {
                //     tag += "<div class='activation_date'>" + board.activation_date + "</div>";
                // } else {
                //     tag += "<div class='activation_date'>N/A</div>";
                // }

                // 삭제 여부: 숫자 1이면 삭제됨, 0이면 존재
                var isDeleted = board.is_deleted == 1 ? "Y" : "N";
                tag += "<div class='is_deleted'>" + isDeleted + "</div>";


                // // 삭제 날짜: is_deleted가 1일 때만 표시
                // if (board.is_deleted == 1 && board.deleted_date) {
                //     tag += "<div class='deleted_date'>" + board.deleted_date + "</div>";
                // } else {
                //     tag += "<div class='deleted_date'>N/A</div>";
                // }

                // 수정 및 삭제 버튼
                tag += "<div class='edit_button'><button class='btn btn-outline-secondary' onClick='editMarathon(" + board.marathon_code + ")'>수정</button></div>";
                tag += "<div class='delete_button'><button class='btn btn-outline-secondary' onClick='deleteBoard(" + board.marathon_code + ")'>삭제</button></div>";
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
        error: function (e) {
            console.error(e);
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
    alert(boardSearchType2 + ":" + boardSearchValue);
    loadBoardPage(1, boardSearchType, boardSearchType2, boardSearchValue);
}

function enterKey(event) {
    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
function changeOption() {
    var selectOption = document.getElementById("BoardSearchValue2");
    var value = selectOption.value;

    if (value == "is_active") {
        document.getElementById("BoardSearchValue").value = "all_code";
        document.getElementById("BoardSearchValue").style.display = "none";
        document.getElementById("searchtext").placeholder = "Y:활성화 N:비활성화";
        document.getElementById("searchtext").style.width = "400px";
    } else if (value == "is_deleted") {
        document.getElementById("BoardSearchValue").value = "all_code";
        document.getElementById("BoardSearchValue").style.display = "none";
        document.getElementById("searchtext").placeholder = "Y:삭제됨 N:삭제되지 않음";
        document.getElementById("searchtext").style.width = "400px";
    } else {
        document.getElementById("searchtext").removeAttribute("placeholder");
        document.getElementById("BoardSearchValue").style.display = "block";
        document.getElementById("searchtext").style.width = "300px";
    }
    document.getElementById("searchtext").focus();
}

function reset() {
    loadBoardPage(1);
}
