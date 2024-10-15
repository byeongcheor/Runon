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
        width: 1400px;
        height: 900px;
        margin: 0 auto;
        border-radius: 10px 10px 0 0;
        padding: 20px;
    }
    .page_title{
        font-size: 18pt;
        text-align: center;
        margin: 30px;
        font-weight: 500;
    }
    .uploadFile{
        text-align: center;
    }
    .row {
        border-bottom: 1px solid #ddd;
        width: 90%;
        margin: 0 auto;
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
    #filenames{
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
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
</style>
<script>
    setTimeout(function(){
            $.ajax({
                url:"/mypage/certificateList",
                type:"post",
                data:{
                    username:username1,
                    usercode:usercode1,
                    Token:ToKen
                } ,
                success:function(r){
                    var tag="";
                    $.each(r.list, function(i, vo){
                        var dateresult=vo.result_date;
                        if (dateresult==null){
                            dateresult="";
                        }

                        tag += `
                            <div class="row">
                                <div class="col-sm-1 p-2">`+vo.certificate_code+`</div>
                                <div class="col-sm-2 p-2">`+vo.content+`</div>
                                <div class="col-sm-2 p-2" id="filenames">`+vo.proof_photo+`</div>
                                <div class="col-sm-2 p-2">`+vo.updated_date+`</div>
                                <div class="col-sm-1 p-2">`+vo.result_status+`</div>
                                <div class="col-sm-2 p-2">`+dateresult+`</div>
                                <div class="col-sm-2 p-2">
                                    <button type="button" class="btn btn-outline-danger" onclick="deleteCertificate(`+vo.certificate_code+`)">삭제</button>
                                </div>
                            </div>
                        `;
                    });
                    document.getElementById("list").innerHTML = tag;
                },error:function (e){
                    alert(e);
                }
            });
    },1000);

    function openUploadModal(){
        var modal = document.getElementById("uploadFileModal");
        if(modal){
            modal.style.display="block";

        }else{
            console.error("실패");
        }
    }
    function closeUploadModal(){
        var modal = document.getElementById("uploadFileModal");
        if (modal) {
            modal.style.display = "none";  // 모달을 숨김
        } else {
            console.error("Modal element not found: " + modalId);
        }
    }
    function submitUploadForm(){

        var content = document.getElementById('content').value;
        var proof_photo = document.getElementById('proof_photo').files[0];
        alert(username1);
        var formData = new FormData();
        formData.append("content", content);
        formData.append("proof_photo", proof_photo);
        formData.append("username", username1);

            $.ajax({
                url: "/mypage/uploadCertificate",
                type: "post",
                data: formData,
                contentType: false,  // 파일 전송 시 반드시 false로 설정
                processData: false,
                success: function (r) {
                    alert("파일업로드 성공!");
                    closeUploadModal();
                    location.reload();
                }, error: function (e) {
                    alert("파일업로드 실패..");
                    console.log(e);

                }
            });
        return false;
    }
    function deleteCertificate(certificate_code){
        if(confirm("정말 삭제하시겠습니까?")){
            $.ajax({
                url: "/mypage/deleteCertificate",
                type: "post",
                data: {certificate_code: certificate_code,
                        username: username1},
                success: function(r){
                    alert("삭제되었습니다.");
                    location.reload();
                },error: function(e){
                    alert("삭제실패하였습니다.");
                }
            })
        }
    }
</script>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">내 기록인증하기</div>
    <div class="body_container">
        <div class="uploadFile">
            <div style="text-align: right; padding: 30px;">
                <a onclick="openUploadModal()" style="margin-right: 50px;">📤파일올리기</a>
            </div>

            <div class="row">
                <div class="col-sm-1 p-2"><b>번호</b></div>
                <div class="col-sm-2 p-2"><b>제목</b></div>
                <div class="col-sm-2 p-2"><b>파일</b></div>
                <div class="col-sm-2 p-2"><b>업로드일</b></div>
                <div class="col-sm-1 p-2"><b>처리상태</b></div>
                <div class="col-sm-2 p-2"><b>처리일</b></div>
                <div class="col-sm-2 p-2"><b> </b></div>
            </div>
            <div id="list"></div>

            <div id="uploadFileModal" class="modal" style="display:none;">
                <div class="modal-content" style="width: 20%;">
                    <span class="close-button" onclick="closeUploadModal()">&times;</span>
                    <h2 style="font-weight: 700; font-size: 20pt; line-height: 40px;">기록인증첨부</h2>
                    <form class="modal-contents" method="post"  action="/" id="uploadForm" onsubmit="return submitUploadForm()">
                        <div>
                            <div>
                                <input class="inputs" type="text" name="content" id="content" placeholder="마라톤 대회명을 입력하세요." required/>
                            </div>
                            <div>
                                <input type="file" name="proof_photo" id="proof_photo"/>
                            </div>
                            <div class="btnBox">
                                <button type="submit" style="margin-top: 20px;" id="deleteBtn">제출하기</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
