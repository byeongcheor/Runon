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
    #profils{
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
</style>
<script>
    setTimeout(function(){
        $.ajax({
            url:"/mypage/mymateList",
            type:"post",
            data:{
                usercode:usercode1
            },success: function(r){
                console.log(r.member);
                var tag="";
                $.each(r.member, function(i,vo){
                    tag += `
                        <div class="row" id="profils">
                            <div class="col-sm-2 p-2" id="profile_Box">
                                <img src="/resources/uploadfile/${vo.profile_img ? vo.profile_img : 'basicimg.png'}" id="profile_Img"/>
                            </div>
                            <div class="col-sm-3 p-2" id="nicknameReport">`+vo.nickname+`</div>
                            <div class="col-sm-1 p-2">`+vo.gender+`</div>
                            <div class="col-sm-3 p-2">`+vo.mate_popup_date+`</div>
                            <div class="col-sm-3 p-2"><button type="button" class="btn btn-outline-danger" onclick="openReport(${vo.usercode})">신고하기</button></div>
                        </div>
                    `;
                });
                document.getElementById("matelist").innerHTML = tag;

            },error: function(e){
                alert("에러발생");
                console.log(e);
            }
        })
    },1000);

    function openReport(usercode){
        document.getElementById("usercodeReport").value = usercode;
        var modal = document.getElementById("uploadReport");
        if(modal) {
            console.log(usercode);
            modal.style.display = "block";
        }else{
            console.log("안열림");
        }
    }
    function closeReport(){
        var modal = document.getElementById("uploadReport");
        if(modal) {
            modal.style.display = "none";
        }
    }
    function submitReport(){
        var usercode = document.getElementById("usercodeReport").value;
        var subjectReport = document.getElementById("subjectReport").value;
        var contentReport = document.getElementById("contentReport").value;
        var proofReport = document.getElementById("proofReport").value;
        $.ajax({
            url:"/mypage/createReport",
            type:"post",
            data:{
                username: username1,
                usercode: usercode1,
                offender_code: usercode,
                nickname: nickname,
                subjectReport: subjectReport,
                contentReport: contentReport,
                proofReport: proofReport
            },success: function(r){
                alert("성공");
                if(r=="success"){
                    alert(nickname);
                }
            },error: function(e){
                alert("실패");
            }
        });
        return false;
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
                <form method="post" class="modal-contents" action="/" onsubmit="return submitReport()">
                    <div>
                        <input type="hidden" id="usercodeReport" name="usercodeReport">
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
    </div>
</div>