<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
      crossorigin="anonymous"
    />
<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
      crossorigin="anonymous"
    ></script>
<link rel="stylesheet" href="/css/crewList.css" type="text/css">
<script>
    var searchKey="${pvo.searchKey}";
    var searchWord="${pvo.searchWord}";
    var addr = "${pvo.addr}";
    function reloadPage(page){
        var url = "/crew/crewList?nowPage="+page;
        if(searchWord!=null && searchWord!=""){
           url += "&searchKey="+searchKey+"&searchWord="+searchWord;
        }
        if (addr != null && addr != "") {
            url += "&addr=" + addr;
        }
        location.href = url;
    }
</script>
    <div>
        <div id="bannerBox">
            <img src="/img/러닝고화질.jpg" id="bannerImg"/>
        </div>
        <div id="crew_body">
            <div id="crew_nav">
                <ul>
                    <li><a href="/crew/crewList">크루모집</a></li>
                    <li><a href="/crew/crewCreate">크루생성</a></li>
                    <li><a href="/crew/crewManage">나의크루</a></li>
                </ul>
            </div>
        </div>
        <div class="crew_search">
            <form class="searchForm">
                <select class="form-select" name="searchKey">
                    <option value="">전체</option>
                    <option value="crew_name" ${pvo.searchKey == 'crew_name' ? 'selected' : ''}>크루명</option>
                </select>
                <select class="form-select" name="addr">
                    <option value="">전체</option>
                    <option value="경기" ${pvo.addr == '경기' ? 'selected' : ''}>경기</option>
                    <option value="서울" ${pvo.addr == '서울' ? 'selected' : ''}>서울</option>
                </select>
                <input type="text" name="searchWord" id="searchWord" />
                <button type="submit" class="btn btn-outline-secondary">Search</button>
            </form>
        </div>
        <div class="crew_list">
            <div class="list_wrapper">
                <ul>
                    <c:forEach var="cvo" items="${list}">
                        <li class="list_item">
                            <div class="crew_profileimage">
                                <div class="profileBox">
                                    <img src="/img/a8.png" class="profileImg">
                                </div>
                            </div>
                            <div class="crew_content">
                                <div class="crew_title">
                                    <span class="crewname"><b>${cvo.crew_name}</b></span>
                                    <span class="count">🏃‍♀️${cvo.max_num}<span>
                                </div>
                                <div class="crew_info">
                                    <span class="crewaddr">${cvo.addr}&nbsp;${cvo.addr_gu}</span>
                                    <span class="crewIntro">남녀모두 환영합니다. 함께하실 분을 찾습니다.</span>
                                    <span class="crewhit">조회 3,490</span>
                                </div>
                            </div>
                            <div class="recruit">
                                <button type="button" class="btn btn-outline-dark" id="recruitbtn">가입신청하기</button>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!-- 페이징 -->
        <ul class="pagination justify-content-center" style="margin:100px;">
            <!-- 이전페이지 -->
            <!-- 첫번째 페이지 -->
            <c:if test="${pvo.nowPage==1}">
                <li class="page-item"><a class="page-link"
                href="javascript:void(0);"><</a></li>
            </c:if>
            <!-- 첫번째 페이지가 아니면 -->
            <c:if test="${pvo.nowPage>1}">
                <li class="page-item"><a class="page-link"
                href="javascript:reloadPage(${pvo.nowPage-1});">Previous</a></li>
            </c:if>
            <c:forEach var="p" begin="${pvo.startPageNum}"
            end="${pvo.startPageNum+pvo.onePageNum-1}">
                <c:if test="${p<=pvo.totalPage}">
                    <li class='page-item <c:if test="${p==pvo.nowPage}">active</c:if>'><a
                      class="page-link" href="javascript:reloadPage(${p});">${p}</a></li>
                </c:if>
            </c:forEach>

        <!-- 다음페이지 -->
        <!-- 다음페이지가 없을때 -->
            <c:if test="${pvo.nowPage==pvo.totalPage}">
                <li class="page-item"><a class="page-link"
                href="javascript:void(0);">Next</a></li>
            </c:if>
            <!-- 다음페이지가 있을때 -->
            <c:if test="${pvo.nowPage<pvo.totalPage}">
                <li class="page-item"><a class="page-link"
                href="javascript:reloadPage(${pvo.nowPage+1});">></a></li>
            </c:if>
        </ul>
    </div>
