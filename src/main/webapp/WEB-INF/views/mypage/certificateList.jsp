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
        width: 1024px;
        height: 900px;
        margin: 0 auto;
        border-radius: 10px 10px 0 0;
    }
    .page_title{
        font-size: 18pt;
        text-align: center;
        margin: 30px;
        font-weight: 500;
    }
    .uploadFile{
        text-align: right;
    }
    .row{
        border-bottom: 1px solid #ddd;
        width: 90%;
        margin: 0 auto;
    }
</style>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">내 기록인증하기</div>
    <div class="body_container">
        <div class="uploadFile">
            <div>
                <a >📤파일올리기</a>
            </div>

            <div class="row">
                <div class="col-sm-1 p-2"><b>번호</b></div>
                <div class="col-sm-3 p-2"><b>대회명</b></div>
                <div class="col-sm-2 p-2"><b>업로드일</b></div>
                <div class="col-sm-2 p-2"><b>처리상태</b></div>
                <div class="col-sm-2 p-2"><b>처리일</b></div>
                <div class="col-sm-2 p-2"><b> </b></div>
            </div>

            <!-- 자료실목록출력 -->

            <div class="row">
                <div class="col-sm-1 p-2">1</div>
                <div class="col-sm-3 p-2">한강나이트워크</div>
                <div class="col-sm-2 p-2">24-10-17</div>
                <div class="col-sm-2 p-2">처리완료</div>
                <div class="col-sm-2 p-2">24-10-07</div>
                <div class="col-sm-2 p-2">
                    <button type="button" class="btn btn-outline-danger" onclick="">삭제</button>
                </div>
            </div>

            <%--<c:forEach var="vo" items="${list}">
                <div class="row">
                    <div class="col-sm-1 p-2">${vo.no}</div>
                    <div class="col-sm-5 p-2"><a href="/datas/datasView/${vo.no}">${vo.title}</a></div>
                    <div class="col-sm-2 p-2">${vo.writer}</div>
                    <div class="col-sm-2 p-2"><a href="/fileupload/${vo.filename}" download><img src="/fileupload/${vo.filename}" style="width:75px;height:auto;border-radius:8px;"/></a></div>
                    <div class="col-sm-2 p-2">
                            <button type="button" class="btn btn-outline-info" onclick="datasEditForm(${vo.no})">수정</button>
                            <button type="button" class="btn btn-outline-danger" onclick="datasDel(${vo.no})">삭제</button>
                    </div>
                </div>
            </c:forEach>--%>
        </div>
    </div>
</div>
