<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body{
        background-color: #F8FAFB;
        animation: none;
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
        padding: 30px;
    }
    .page_title{
        font-size: 18pt;
        text-align: center;
        margin: 30px;
        font-weight: 500;
    }
    #row1{
        border-bottom: 2px solid #ddd;
        width: 90%;
        margin: 0 auto;
    }
    .row{
        border-bottom: 1px solid #ddd;
        width: 90%;
        margin: 0 auto;
        line-height: 40px;
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
            url:"/mypage/myQnAList",
            type:"post",
            data:{
                username:username1,
                usercode:usercode1,
                Token:ToKen,
                page:page
            } ,
            success:function(r){
                var tag="";
                var pvo= r.pvo;
                if(r.list.length==0){
                    tag += `
                        <div class="row" style="text-align: center; margin-top: 40px;">
                            <p>1:1문의한 내역이 없습니다.</p>
                        </div>
                    `;
                }else{
                    $.each(r.list, function(i, vo){
                        if (vo.qna_status==0){
                            vo.qna_status="처리중";
                        }else{
                            vo.qna_status="처리완료";
                        }
                        tag += `
                            <div class="row">
                                <div class="col-sm-1 p-2">`+vo.qna_code+`</div>
                                <div class="col-sm-4 p-2"><a onclick="submitviewQnA(`+vo.qna_code+`)">`+vo.qna_subject+`</a></div>
                                <div class="col-sm-2 p-2">`+vo.qna_status+`</div>
                                <div class="col-sm-3 p-2">`+vo.writedate+`</div>
                                <div class="col-sm-2 p-2">
                                    <button button type="button" class="btn btn-outline-danger" onclick="deleteQnA(`+vo.qna_code+`)">삭제</button>
                                </div>
                            </div>
                        `;
                    });
                }
                document.getElementById("list").innerHTML = tag;

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

            },error:function (e){
                alert(e);
            }
        });
    }


    //모달열기
    function openModal(){
        var modal = document.getElementById("uploadQnA");
        if(modal) {
            modal.style.display = "block";

        }
    }
    //모달닫기
    function closeModal(){
        var modal = document.getElementById("uploadQnA");
        if (modal) {
            modal.style.display = "none";  // 모달을 숨김
        }
    }
    function openViewQnA(){
        var modal = document.getElementById("viewQnA");
        if(modal) {
            modal.style.display = "block";

        }
    }
    function closeViewQnA(){
        var modal = document.getElementById("viewQnA");
        if(modal) {
            modal.style.display = "none";
        }
        location.reload();
    }
    //qna작성모달
    function submitQnA(){
        var subject = document.getElementById("subject").value;
        var content = document.getElementById("content").value;
        usercode = usercode1;
        $.ajax({
            url: "/mypage/submitQnA",
            type: "post",
            data: {
                usercode: usercode1,
                subject: subject,
                content: content
            },success:function (r){
                alert("질문이 등록되었습니다.")
                closeModal();
                location.reload();
            },error: function(e){
                alert("실패");
                console.log(e);
            }
        });
        return false;
    }
    //qna삭제
    function deleteQnA(qna_code){
        usercode = usercode1;
        if(confirm("정말 삭제하시겠습니까?")){
            $.ajax({
                url: "/mypage/deleteQnA",
                type: "post",
                data: {
                    qna_code: qna_code,
                    usercode: usercode
                },
                success: function(r){
                    alert("삭제되었습니다.");
                    location.reload();
                },error: function(e){
                    alert("삭제실패하였습니다.");
                }
            })
        }
    }
    //qna보기
    function submitviewQnA(qna_code){
        $.ajax({
            url: "/mypage/viewQnA",
            type: "post",
            data: {
                usercode: usercode1,
                qna_code: qna_code
            },success: function(r){
                console.log(r);
                document.getElementById("subject1").value = r.qna_subject;
                document.getElementById("content1").value = r.qna_content;
                if(r.answer_content){
                    document.getElementById("answer1").value = r.answer_content;
                }
                openViewQnA();
            },error: function(e){
                alert("조회실패..");
                console.log(e);
            }
        })
        return false;
    }
</script>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">나의 QnA</div>
    <div class="body_container">
        <div style="text-align: right;">
            <button type="button" class="btn btn-outline-success" onclick="openModal()">작성하기</button>
        </div>
        <div class="row" id="row1">
            <div class="col-sm-1 p-2"><b>번호</b></div>
            <div class="col-sm-4 p-2"><b>제목</b></div>
            <div class="col-sm-2 p-2"><b>답변</b></div>
            <div class="col-sm-3 p-2"><b>문의일</b></div>
            <div class="col-sm-2 p-2"><b> </b></div>
        </div>
        <div id="list">

        </div>
        <div id="uploadQnA" class="modal" style="display:none;">
            <div class="modal-content" style="width: 20%;">
                <span class="close-button" onclick="closeModal()">&times;</span>
                <h2 style="font-weight: 700; font-size: 20pt; line-height: 40px;">QnA작성하기</h2>
                <form class="modal-contents" method="post"  action="/" onsubmit="return submitQnA()">
                    <div>
                        <div>
                            <input class="inputs" type="text" name="subject" id="subject" placeholder="제목을 입력하세요." required/>
                        </div>
                        <div>
                            <textarea name="content" id="content" placeholder="내용을 입력하세요." required></textarea>
                        </div>
                        <div class="btnBox">
                            <button type="submit" style="margin-top: 20px;">제출하기</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="viewQnA" class="modal" style="display:none;">
            <div class="modal-content" style="width: 20%;">
                <span style="text-align: right;" class="close-button" onclick="closeViewQnA()">&times;</span>
                <h2 style="text-align: center">QnA</h2>
                <form method="post"  class="modal-contents" action="/" onsubmit="return submitviewQnA()">
                    <div>
                        <div>
                            <div>문의제목</div>
                            <div>
                                <input class="inputs" type="text" name="subject" id="subject1" readonly/>
                            </div>
                        </div>
                        <div>
                            <div>문의내용</div>
                            <div>
                                <textarea style="height: auto;" name="content" id="content1" readonly></textarea>
                            </div>
                        </div>
                        <div>
                            <div>관리자답변</div>
                            <div>
                                <textarea style="height: auto;" name="answer" id="answer1"  readonly></textarea>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
        <div class="pagination" id="paging"></div>
    </div>
</div>