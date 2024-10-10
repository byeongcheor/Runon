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
                            <div class="col-sm-3 p-2" id="profile_Box">
                                <img src="/resources/uploadfile/`+vo.profile_img+`" id="profile_Img"/>
                            </div>
                            <div class="col-sm-3 p-2">`+vo.nickname+`</div>
                            <div class="col-sm-3 p-2">`+vo.gender+`</div>
                            <div class="col-sm-3 p-2">`+vo.mate_popup_date+`</div>
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
</script>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">나의 메이트이력</div>
    <div class="body_container">
        <div class="matetable">
            <div class="row" id="profiles">
                <div class="col-sm-3 p-2"><b>프로필</b></div>
                <div class="col-sm-3 p-2"><b>닉네임</b></div>
                <div class="col-sm-3 p-2"><b>성별</b></div>
                <div class="col-sm-3 p-2"><b>매칭일자</b></div>
            </div>

            <div id="matelist"></div>
        </div>
    </div>
</div>