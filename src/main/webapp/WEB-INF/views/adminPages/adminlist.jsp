<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../inc/sidebar.jspf" %>
<link rel="stylesheet" href="/css/adminPages/adminlist.css" type="text/css">
<script src="/js/adminPages/adminlist.js" type="text/javascript"></script>
<div class="adminContainer">
    <div id="AdminHead">
        <div id="maintop">
            <div id="menutitle">Admins</div>
            <div id="subtitle">관리자의 권한을 관리합니다.</div>
        </div>
    </div>
    <div id="Adminlistbody">
        <div id="mainmid">
            <div>
                <form>
                    <div id="checkboxlist" >

                    </div>
                    <div id="searchbar">
                        <select class="form-select" id="adminSearchValue" name="adminSearchValue" onchange="changeOption()">
                            <option value="username">
                                아이디
                            </option>
                            <option value="role">
                                등급
                            </option>
                            <option value="permission_add">
                                쓰기권한
                            </option>
                            <option value="permission_edit">
                                수정권한
                            </option>
                            <option value="permission_delete">
                                삭제권한
                            </option>
                            <option value="is_deleted">
                                정지된 운영자
                            </option>

                        </select>
                        <div>
                            <input type="text" id="searchtext" name="searchtext" onkeydown="enterKey(event)" />
                            <div type="button" id="searchbutton" class="btn btn-m search" onclick="searchbutton()">
                                <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                            </div>
                        </div>


                    </div>   <div id="selectbutton"></div>
                </form>

                <div id="downloadbutton" style="margin: auto 0; display: none"></div>
            </div>
        </div>
        <div id="memlistbottom">
            <div class="AdminFavMain">
                <div id='AdminList'></div>
            </div>
            <ul class="pagination justify-content-center">
            </ul>
            <div class="box_rightType1">
            </div>
        </div>
    </div>
</div>




