window.onload = function () {
    var page;
    reloadPage(page);



}
function reloadPage(page){
    if (page==null){
        page=1;
    }
    $.ajax({
        url:"/adminPages/selectmlist",
        type:"POST",
        data:{
            page:page,


        },
        success:function(r){

            var members = r.list;  // 회원 목록
            var pVO = r.pvo;  // 페이징 정보
            var role=r.role
            // 1. 회원 목록 렌더링

                var tag = "<li><div id='usertitle2'><div class='username '>아이디 </div><div class='name'>이름</div>";
                tag += "<div class='nickname'>닉네임</div><div class='is_google'>소셜로그인여부</div><div class='is_info_disclosure'>정보공개여부</div>";
                tag += "<div class='tel'>전화번호</div><div class='birthdate'>생년월일</div>";
                tag += "<div class='creation_date'>가입일</div><div class='buttonline'></div></div></li>";

                members.forEach(function (member) {
                    tag += "<li><div class='usertitle3'><input type='checkbox' name='test[]' class='checkbox' style='display: none;' value='" + member.usercode + "'/>";
                    tag += "<div class='username'>" + member.username + "</div><div class='name'>" + member.name + "</div>";
                    tag += "<div class='nickname'>" + member.nickname + "</div><div class='is_google'>" + member.is_google + "</div><div class='is_info_disclosure'>";
                    tag += member.is_info_disclosure + "</div>";
                    tag += "<div class='tel'>" + member.tel + "</div>";
                    tag += "<div class='birthdate'>" + member.birthdate + "</div><div class='creation_date'>" + (member.creation_date).substring(0, 10) + "</div>";
                    tag += "<button class='btn btn-outline-secondary buttonline' type='button' style='flex-shrink: 0;' onclick='userdetail(" + member.usercode + ")'>상세보기</button></div></li>";
                });

                $("#userList").html(tag);

                // 2. 페이징 정보 렌더링
                var paginationTag = "";

                // 이전 버튼
                if (pVO.nowPage > 1) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage - 1) + ");'>Previous</a></li>";
                }

                // 페이지 번호 출력
                for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:reloadPage(" + p + ");'>" + p + "</a></li>";
                    }
                }

                // 다음 버튼
                if (pVO.nowPage < pVO.totalPage) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage + 1) + ");'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);


        },
        error: function (e) {
            console.log(e);
        }
    });
}
function excelDownload(){
    $.ajax({
        url:"/adminPages/uListDownload",
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
function userdetail(usercode){
    alert(usercode);
    document.getElementById("userdetailbackground").style.display="block";
    $.ajax({
        url:"/adminPages/userdetail",
        type:"post",
        data:{usercode:usercode
        },
        success:function(r){
            var rlist=r.rlist;
            var users=r.mvo;

            var usertag=`
            <div id="userprofile">
                <img src="../../profileImg/`+users.profile_img+`"/>
                <div><input type="button"value="탈퇴시키기" onclick="userdel(users.usercode)"/></div>
                <div><input type="button"value="7일 정지"  onclick="userstop(users.usercode)"/></div>
            </div>
            <div id="userstatus">
                <div class="onelow">
                    <div id="name">이름:`+users.name+`</div>
                    <div id="username">아이디:`+users.username+ `</div>
                </div>
                <div class="onelow">
                    <div id="nickname">닉네임:`+users.nickname+`</div>
                    <div id="birthday">생년월일:`+users.birthdate+`</div>
                </div>
                <div class="onelow">
                    <div id="tel">핸드폰번호:`+users.tel+`</div>
                    <div id="reportcnt">신고당한횟수:`+rlist.length+`</div>
                </div>
                <div class="onelow">
                    <div id="zipcode">우편번호:`+users.zip_code+`</div>
                    <div id="addr"> 주소:`+users.addr+` </div>
                </div>
                <div class="onelow">
                    <div id="addrdetail">상세주소:`+users.addr_details+`</div>
                </div>
            </div>`;
            document.getElementById("usermain").innerHTML=usertag;

            console.log(rlist);

        },error:function(e){
            console.log("에러발생"+e);
        }


    })
}
function closedetail(){
    document.getElementById("userdetailbackground").style.display="none";
}
