<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body{
        background-color: #F8FAFB;
    }
    #bannerBox{
        width:100%;
        height:200px;
        margin: 0 auto;
    }
    #bannerImg{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .body_container{
        background-color: white;
        width: 1000px;
        height: 900px;
        margin: 0 auto;
        border-radius: 10px 10px 0 0;
        padding-top: 30px;
    }
    .page_title{
        font-size: 18pt;
        text-align: center;
        margin: 30px;
        font-weight: 500;
    }
    .row{
        width: 85%;
        margin: 0 auto;
        text-align: center;
    }

    #profile_Img{
        width: 40px;
        height: 40px;
        border-radius: 200px;
        object-fit: cover;
    }
    #profiles{
        border-bottom: 1px solid black;
    }
    #profiles{
        line-height: 40px;
        border-bottom: 1px solid lightgray;
    }
    .modal {
        display: none;  /* 처음에는 숨겨둠 */
        position: fixed;
        z-index: 1;  /* 모달이 다른 요소들 위에 표시되도록 설정 */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0,0,0);  /* 반투명한 배경 */
        background-color: rgba(0,0,0,0.4);  /* 반투명한 배경 */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 30%;  /* 모달의 너비 설정 */
        border-radius: 15px;
    }

    .close-button {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close-button:hover,
    .close-button:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    .modal {
        z-index: 1000;  /* 다른 요소들 위에 모달을 표시 */
    }
    .inputs{
        border: 1px solid #d9e0e6;
        background-color: #f8fafb;
        width: 100%;
        height: 54px;
        border-radius: 16px;
        padding: 14px 15px;
        font-size: 16px;
        box-sizing: border-box;
        margin-bottom: 20px;
    }
    .modal-contents button{
        background-color: #1570ff;
        border: none;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
        margin-bottom: 20px;
        line-height: 40px;
        border-radius: 5px;
        color: white;
        margin-top: 20px;
    }
    .modal-content textarea{
        border: 1px solid #d9e0e6;
        background-color: #f8fafb;
        width: 100%;
        height: 200px;
        border-radius: 16px;
        padding: 14px 15px;
        font-size: 16px;
        box-sizing: border-box;
        margin-bottom: 20px;
    }
    .pagination .page-link{
        color: black;
    }
    .pagination .page-link:hover {
        color: #fff; /* 호버 시 텍스트 색상 */
        background-color: black; /* 호버 시 배경색 */
    }
    /* 활성화된 페이지 아이템 색상 변경 */
    .pagination .page-item.active .page-link {
        background-color: black; /* 배경색 */
        border-color: black;     /* 테두리 색상 */
        color: white;              /* 텍스트 색상 */
    }

    /* 활성화된 페이지 아이템 호버 시 색상 변경 */
    .pagination .page-item.active .page-link:hover {
        background-color: grey; /* 호버 시 배경색 */
        border-color: grey;     /* 호버 시 테두리 색상 */
    }
    #paging{
        display: flex;
        justify-content: center;
        margin: 30px;
    }

</style>
<script>
    setTimeout(function(){
        var page;
        reloadPage(page);
    },100);
    function reloadPage(page){
        if(page==null){
            page=1;
        }
        $.ajax({
            url:"/mypage/mymateList",
            type:"post",
            data:{
                usercode:usercode1,
                page:page
            },success: function(r){
                var tag="";
                var pvo=r.pvo;
                /*console.log(r);*/
                if(r.member.length == 0){
                    tag += `
                        <div class="row" style="text-align: center; margin-top: 40px;">
                            <p>메이트 페이지에서 매칭한 메이트 이력이 없습니다.</p>
                        </div>
                    `;
                }else{
                    $.each(r.member, function(i,vo){
                        tag += `
                        <div class="row" id="profiles">
                            <div class="col-sm-2 p-2" id="profile_Box">
                                <img src="/resources/uploadfile/${vo.profile_img ? vo.profile_img : 'basicimg.png'}" id="profile_Img"/>
                            </div>
                            <div class="col-sm-3 p-2" id="nicknameReport">`+vo.nickname+`</div>
                            <div class="col-sm-1 p-2">`+vo.gender+`</div>
                            <div class="col-sm-3 p-2">`+vo.writedate+`</div>
                            <div class="col-sm-3 p-2"><button type="button" class="btn btn-outline-danger" onclick="checkReport(`+vo.usercode+`, `+vo.matching_room_code+`)">신고하기</button></div>
                        </div>
                    `;
                    });
                }
                document.getElementById("matelist").innerHTML = tag;

                var paginationTag="";

                if (pvo.nowPage > 1) {
                    paginationTag += "<li class= 'page-item'><a class='page-link' href='javascript:reloadPage("+(pvo.nowPage - 1)+";'><</a></li>";
                }
                for (var p = pvo.startPageNum; p <= pvo.startPageNum + pvo.onePageNum - 1; p++) {
                    if (p <= pvo.totalPage) {
                        paginationTag += "<li class='page-item " + (pvo.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:reloadPage(" + p + ");'>" + p + "</a></li>";
                    }
                }
                if (pvo.nowPage < pvo.totalPage) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pvo.nowPage + 1) + ");'>></a></li>";
                }
                $(".pagination").html(paginationTag);

            },error: function(e){
                alert("다시 로드 해주세요.");
                /*console.log(e);*/
            }
        })
    }

    //신고하기 모달 열기
    function openReport(offender, matchingroomcode){
        document.getElementById("usercodeReport").value = offender;
        document.getElementById("matchingroom").value = matchingroomcode;
       /* console.log("신고할 사람:"+ offender);*/
        var modal = document.getElementById("uploadReport");
        if(modal) {
            /*console.log(offender);*/
            modal.style.display = "block";
        }else{
            /*console.log("안열림");*/
        }
    }
    //신고하기 모달닫기
    function closeReport(){
        var modal = document.getElementById("uploadReport");
        if(modal) {
            modal.style.display = "none";
        }
    }
    //신고내역 모달열기
    function openReportDetail(offender, matchingroomcode){
        document.getElementById("viewusercodeReport").value = offender;
        document.getElementById("viewmatchingroom").value = matchingroomcode;
        var modal = document.getElementById("viewReport");
        if(modal) {
            modal.style.display = "block";
        }else{
            /*console.log("안열림");*/
        }
    }
    //신고내역 모달닫기
    function closeViewReport(){
        var modal = document.getElementById("viewReport");
        if(modal) {
            modal.style.display = "none";
        }
    }
    //신고작성제출
    function submitReport(){
        usercode = usercode1;
        var offender = document.getElementById("usercodeReport").value;
        var subjectReport = document.getElementById("subjectReport").value;
        var contentReport = document.getElementById("contentReport").value;
        var proofReport = document.getElementById("proofReport").files[0];
        var matchingroom = document.getElementById("matchingroom").value;

        var formData = new FormData();
        formData.append("usercode", usercode)
        formData.append("offender", offender)
        formData.append("subjectReport", subjectReport);
        formData.append("contentReport", contentReport);
        formData.append("proofReport", proofReport);
        formData.append("matchingroom", matchingroom);
        $.ajax({
            url:"/mypage/createReport",
            type:"post",
            data:formData,
            contentType: false,
            processData: false
            ,success: function(r){
                /*console.log(r);*/
                /*alert("성공");*/
                closeReport();
            },error: function(e){
                /*alert("실패");*/
            }
        });
        return false;
    }
    //신고내역이 있는지 확인
    function checkReport(offender, matchingroomcode){

        $.ajax({
            url:"/mypage/checkReport",
            type: "post",
            data: {
                usercode: usercode1,
                matchingroom: matchingroomcode
            },
            success: function(r){
                if(r.exists){
                    var datas = r.data;
                    alert("기존에 작성한 신고내역이 있습니다.");
                   /* console.log(r.data);*/
                    var result = datas.report_status;
                    var adminresult = datas.report_result;
                   /* console.log(adminresult);*/
                    if(result == 0){
                        document.getElementById("resultstatus").value = "관리자가 신고내역 처리중";
                        document.getElementById("report_result").style.display = "none";
                    }else{
                        document.getElementById("resultstatus").value = "신고내역 처리완료";
                        document.getElementById("report_result").style.display = "block";
                    }

                    var modal = document.getElementById("viewReport");
                    if(modal){
                        document.getElementById("viewsubjectReport").value=datas.report_reason;
                        document.getElementById("viewcontentReport").value=datas.report_content;
                        if(adminresult){
                            document.getElementById("report_result").value = adminresult;
                        }
                    }
                    openReportDetail(offender, matchingroomcode);
                }else{
                    alert("기존에 작성한 신고내역이 없습니다.");
                    openReport(offender, matchingroomcode);
                }
            },error: function(e){
                alert("신고여부 확인 중 오류")
              /*  console.log(e);*/
            }
        })
    }
</script>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">나의 메이트이력</div>
    <div class="body_container">
        <div class="matetable">
            <div class="row" id="profiles">
                <div class="col-sm-2 p-2"><b>프로필</b></div>
                <div class="col-sm-3 p-2"><b>닉네임</b></div>
                <div class="col-sm-1 p-2"><b>성별</b></div>
                <div class="col-sm-3 p-2"><b>매칭일자</b></div>
                <div class="col-sm-3 p-2"><b></b></div>
            </div>

            <div id="matelist"></div>
        </div>
        <!-- 신고하기 모달 -->
        <div id="uploadReport" class="modal" style="display:none;">
            <div class="modal-content" style="width: 20%;">
                <span class="close-button" style="text-align: right;" onclick="closeReport()">&times;</span>
                <h2 style="font-weight: 700; font-size: 20pt; line-height: 40px; margin-bottom: 20px;">신고하기</h2>
                <form method="post" class="modal-contents" enctype="multipart/form-data" action="/" onsubmit="return submitReport()">
                    <div>
                        <input type="hidden" id="usercodeReport" name="usercodeReport">
                        <input type="hidden" id="matchingroom" name="matchingroom">
                        <div>
                            <input class="inputs" type="text" name="subjectReport" id="subjectReport" placeholder="제목을 입력해주세요." required/>
                        </div>
                        <div>
                            <textarea name="contentReport" id="contentReport" placeholder="신고할 내용을 입력해주세요." required></textarea>
                        </div>
                        <div>
                            <input type="file" name="proofReport" id="proofReport"/>
                        </div>
                        <button type="submit">제출하기</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- 신고한 내용 모달 -->
        <div id="viewReport" class="modal" style="display:none;">
            <div class="modal-content" style="width: 20%;">
                <span class="close-button" style="text-align: right;" onclick="closeViewReport()">&times;</span>
                <h2 style="font-weight: 700; font-size: 20pt; line-height: 40px; margin-bottom: 20px;">신고하기</h2>
                <form method="post" class="modal-contents" enctype="multipart/form-data" action="/" onsubmit="return editReport()">
                    <div>
                        <input type="hidden" id="viewusercodeReport" name="usercodeReport">
                        <input type="hidden" id="viewmatchingroom" name="matchingroom">
                        <div>
                            <input class="inputs" type="text" name="subjectReport" id="viewsubjectReport" readonly/>
                        </div>
                        <div>
                            <textarea name="contentReport" id="viewcontentReport" readonly></textarea>
                        </div>
                        <div>
                            <input class="inputs" type="text" name="resultstatus" id="resultstatus" style="color: tomato;" readonly/>
                        </div>
                        <div>
                            <input class="inputs" type="text" name="report_result" id="report_result" style="color: tomato;" readonly/>
                        </div>
                        <div>* 신고내역 취소 및 기타문의사항은 1:1문의하기로 관리자에게 문의해주세요.</div>
                    </div>
                </form>
            </div>
        </div>
        <div class="pagination" id="paging"></div>
    </div>
</div>