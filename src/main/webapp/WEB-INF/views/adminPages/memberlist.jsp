<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/adminPages/memberlist.css" type="text/css">
<script src="/js/adminPages/memberlist.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>

<%@ include file="../inc/sidebar.jspf" %>

<div id="memlistbody">
    <div>
        <div id="maintop">
            <div id="menutitle">Members</div>
            <div id="subtitle">회원의 정보와 목록을 관리합니다.</div>
        </div>
    </div>
    <div id="mainmid">
        <div>
            <form>
                <div id="checkboxlist" style="min-width:170px; max-width: 249px;">
                    <button type="button" class="clickbox">체크표시</button>
                    <button type="button" class="clickbox">일괄체크</button>
                    <button type="button" class="clickbox">강제탈퇴</button>
                </div>
                <div id="searchbar">
                    <select class="form-select">
                        <option>
                            아이디
                        </option>
                        <option>
                            이름
                        </option>
                        <option>
                            핸드폰번호
                        </option>
                        <option>
                            소셜로그인여부
                        </option>
                    </select>
                    <div>
                        <input type="text"/>
                        <button type="button" id="searchbutton" class="btn btn-m search">
                            <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                        </button>
                    </div>
                </div>

            </form>
            <div><input type="button" value="Excel" onclick="excelDownload()"/></div>
        </div>
    </div>
    <div id="memlistbottom">
        <div class="AdminFavMain">
            <div id='userList'></div>
        </div>
        <ul class="pagination justify-content-center">
        </ul>
        <div class="box_rightType1">
        </div>
    </div>
</div>
<div id="userdetailbackground">
    <div id="userdetail">
        <div  id="closedetail"><i onclick="closedetail()" class="fa-regular fa-circle-xmark fa-3x"></i></div>
        <div id="usermain">
        </div>

        <div id="usercontent">
            <div id="pay">
                <div>결제내역</div>
                <div>
asdfasdf
                </div>
            </div>
            <div id="myRunning">
                <div>점수변동</div>
                <div id="userrecord">
                    <h1>총점수:128km</h1>
                <ul>
                    <li> 점수변동 +32km 현재점수:32Km 변동일:2024-10-08</li>

                </ul>

                </div>
            </div>
            <div id="crewhistory">
                <div>히스토리</div>
                <div>

                </div>
            </div>
        </div>
    </div>
</div>