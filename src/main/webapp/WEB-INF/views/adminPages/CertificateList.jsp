<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../inc/sidebar.jspf" %>
<link rel="stylesheet" href="/css/adminPages/CertificateList.css" type="text/css">
<script src="/js/adminPages/CertificateList.js" type="text/javascript"></script>
<div class="CertificateContainer">
    <div id="CertificateHead">
        <div id="maintop">
            <div id="menutitle">CertificateList</div>
            <div id="subtitle">사용자의 거리인증을 관리합니다.</div>
        </div>
    </div>
    <div id="CertificateListbody">
        <div id="mainmid">
            <div>
                <form>
                    <div id="checkboxlist" >

                    </div>
                    <div id="searchbar">
                        <select class="form-select" id="CertificateSearchValue" name="CertificateSearchValue"onchange="changeOption()" >
                            <option value="username">
                                아이디
                            </option>
                            <option value="nickname">
                                닉네임
                            </option>
                        </select>
                        <select class="form-select" id="CertificateSearchValue2" name="CertificateSearchValue2" onchange="changeOption()">
                            <option value="처리중">
                                처리중
                            </option>
                            <option value="처리완료">
                                처리완료
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
        <div id="CertificateListbottom">
            <div class="CertificateFavMain">
                <div id='CertificateList'></div>
            </div>
            <ul class="pagination justify-content-center">
            </ul>
            <div class="box_rightType1">
            </div>
        </div>
    </div>

    <div id="Certificatedetailbackground">
        <div id="Certificatedetail">
            <div  id="closedetail"><i onclick="closedetail()" class="fa-regular fa-circle-xmark fa-3x"></i></div>
            <div id="usermain">
            </div>

            <div id="Certificatecontent">
                <div id="CertificateDetails">

                </div>
            </div>
            <div id="addreply">

            </div>

        </div>
    </div>




</div>






















</div>