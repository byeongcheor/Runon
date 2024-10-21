<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../inc/sidebar.jspf" %>
<link rel="stylesheet" href="/css/adminPages/ReportList.css" type="text/css">
<script src="/js/adminPages/ReportList.js" type="text/javascript"></script>
<div class="adminContainer">
    <div id="ReportHead">
        <div id="maintop">
            <div id="menutitle">ReportList</div>
            <div id="subtitle">사용자 신고 목록을 관리합니다.</div>
        </div>
    </div>
    <div id="Reportlistbody">
        <div id="mainmid">
            <div>
                <form>
                    <div id="checkboxlist" >

                    </div>
                    <div id="searchbar">
                        <select class="form-select" id="reportSearchValue" name="reportSearchValue"onchange="changeOption()" >
                            <option value="all_code">
                                전체
                            </option>
                            <option value="offender_code">
                                가해자
                            </option>
                            <option value="victim_code">
                                신고자
                            </option>
                        </select>
                        <select class="form-select" id="reportSearchValue2" name="reportSearchValue2" onchange="changeOption()">
                            <option value="nickname">
                                닉네임
                            </option>
                            <option value="report_status">
                                처리상태
                            </option>
                        </select>
                        <div id="searchbox">
                            <input type="text" id="searchtext" name="searchtext" onkeydown="enterKey(event)" />
                            <div type="button" id="searchbutton" class="btn btn-m search" onclick="searchbutton()">
                                <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                            </div>
                        </div>
                        <div id="resetbutton" onclick="reset()"><i class="fa-solid fa-arrows-rotate test"></i></div>


                    </div>   <div id="selectbutton"></div>
                </form>
                <div id="downloadbutton" style="margin: auto 0; display: none"></div>
            </div>
        </div>
        <div id="ReportListbottom">
            <div class="ReportFavMain">
                <div id='ReportList'></div>
            </div>
            <ul class="pagination justify-content-center">
            </ul>
            <div class="box_rightType1">
            </div>
        </div>
    </div>
</div>

<div id="reportdetailbackground">
    <div id="reportdetail">
        <div  id="closedetail"><i onclick="closedetail()" class="fa-regular fa-circle-xmark fa-3x"></i></div>
        <div id="usermain">
        </div>

        <div id="reportcontent">
            <div id="pay">
                <div><b>신고내역</b></div>
                <div id="userpay">
                    <h1>lodding</h1>

                </div>
            </div>
            <div id="myRunning">
                <div><b>점수변동</b></div>
                <div id="userrecord">
                    <h1>lodding</h1>
                </div>
            </div>
        </div>
    </div>
</div>
</div>



