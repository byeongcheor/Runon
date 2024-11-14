<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../inc/sidebar.jspf" %>
<link rel="stylesheet" href="/css/adminPages/QnaList.css" type="text/css">
<script src="/js/adminPages/QnaList.js" type="text/javascript"></script>

<div class="adminContainer">
    <div id="QnaHead">
        <div id="maintop">
            <div id="menutitle">Q&A</div>
            <div id="subtitle">Q&A를 관리합니다.</div>
        </div>
    </div>
    <div id="Qnalistbody">
        <div id="mainmid">
            <div>
                <form>
                    <div id="checkboxlist" >

                    </div>
                    <div id="searchbar">
                        <select class="form-select" id="reportSearchValue" name="reportSearchValue" >
                            <option value="username">
                                아이디
                            </option>
                            <option value="nickname">
                                닉네임
                            </option>
                        </select>
                        <select class="form-select" id="reportSearchValue2" name="reportSearchValue2" >
                            <option value="0">
                                접수중
                            </option>
                            <option value="1">
                                답변완료
                            </option>
                        </select>
                        <div id="searchbox">
                            <input type="text" id="searchtext" name="searchtext" onkeydown="enterKey(event)" />
                            <div type="button" id="searchbutton" class="btn btn-m search" onclick="searchbutton()">
                                <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                            </div>
                        </div>
                        <div id="resetbutton" onclick="reset()"><i class="fa-solid fa-arrows-rotate test" style="line-height: 25px;"></i></div>

                    </div>
                     <div id="selectbutton"></div>
                </form>
            </div>
        </div>
        <div id="QnaListbottom">
            <div class="QnaFavMain">
                <div id='QnaList'></div>
            </div>
            <ul class="pagination justify-content-center">
            </ul>
            <div class="box_rightType1">
            </div>
        </div>
    </div>
</div>

<div id="qnadetailbackground">
    <div id="qnadetail">
        <div  id="closedetail" style="text-align: right;"><i onclick="closedetail()" class="fa-regular fa-circle-xmark fa-3x"></i></div>
        <div id="usermain">
        </div>

        <div id="qnacontent">
            <div id="reportDetails">
                <div><h3>문의내역</h3></div>
                <div id="report">
                    <div>제목:더미 신고 사유 1</div>
                    <div>닉네임:nickname</div>
                    <div>아이디:admin@naver.com</div>
                    <div>접수상태</div>
                    <div>접수일:2024-10-22</div>
                    <div>내용:
                        <div>집가고싶다</div>
                    </div>
                </div>

            </div>
        </div>
        <div id="addreply">
        </div>
        <div id="qnareply">

        </div>
    </div>
</div>


</div>



