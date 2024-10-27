<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../inc/sidebar.jspf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- Bootstrap JS 및 추가 스크립트 연결 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap CSS 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/adminPages/boardList.css" type="text/css">
<script src="/js/adminPages/boardList.js" type="text/javascript"></script>
<div class="adminContainer">
	<div id="BoardHead">
		<div id="maintop">
			<div id="menutitle">Board List</div>
			<div id="subtitle">관리자가 마라톤 게시글을 관리합니다.</div>
		</div>
	</div>
	<div id="BoardListBody">
		<div id="mainmid">
			<div>
				<form>
					<div id="checkboxlist" ></div>
					<div id="searchbar">
						<!--검색조건 -->
						<select class="form-select" id="BoardSearchValue" name="BoardSearchValue" style="width: 120px;" onchange="changeOption()">
							<option value="marathon_name">마라톤명</option>
							<option value="is_active">활성화여부</option>
							<option value="is_deleted">삭제여부</option>
						</select>
						<div id="searchbox">
							<!--검색어입력 -->
							<input type="text" id="searchtext" name="searchtext" onkeydown="enterKey(event)"/>
							<div type="button" id="searchbutton" class="btn btn-m search" onclick="searchbutton()">
								<i class="fa-solid fa-magnifying-glass fa-2x"></i>
							</div>
						</div>
						<div id="resetbutton" onclick="reset()"><i class="fa-solid fa-arrows-rotate test"></i></div>
					</div>
					<div id="selectbutton"></div>
				</form>
				<div id="writebutton" style="margin: auto 0; display: none"></div>
				<div id="downloadbutton" style="margin: auto 0; display: none"></div>
			</div>
		</div>
		<div id="BoardListBottom">
			<div class="BoardFavMain">
				<div id='BoardList'></div>
			</div>
			<ul class="pagination justify-content-center">
				<!-- 페이징 처리 -->
			</ul>
			<div class="box_rightType1">
			</div>
		</div>
	</div>
</div>
