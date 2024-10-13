<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/adminPages/memberlist.css" type="text/css">
<script src="/js/adminPages/memberlist.js" type="text/javascript"></script>
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
                    <button type="button" class="clickbox" onclick="blockhidden()">체크표시</button>
                    <button type="button" class="clickbox" onclick="checkAll()">일괄체크</button>
                    <button type="button" class="clickbox" onclick="selectExcel()">선택엑셀</button>
                </div>
                <div id="searchbar">
                    <select class="form-select" id="searchvalue" name="searchvalue">
                        <option value="username">
                            아이디
                        </option>
                        <option value="name">
                            이름
                        </option>
                        <option value="tel">
                            핸드폰번호
                        </option>
                        <option value="is_disabled">
                            정지여부
                        </option>
                    </select>
                    <div>
                        <input type="text" id="searchtext" name="searchtext" onkeydown="enterKey(event)" />
                        <div type="button" id="searchbutton" class="btn btn-m search" onclick="searchbutton()">
                            <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                        </div>
                    </div>
                </div>

            </form>
            <div style="margin: auto 0"><input type="button" value="전체유저정보받기" onclick="excelDownload()"/></div>
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
                <div>참여대회&결제내역</div>
                <div id="userpay">
                    <h1>lodding</h1>

                </div>
            </div>
            <div id="myRunning">
                <div>점수변동</div>
                <div id="userrecord">
                <h1>lodding</h1>
                </div>
            </div>
        </div>
    </div>
</div>
</div>