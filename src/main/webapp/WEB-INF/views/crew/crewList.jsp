<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/crewList.css" type="text/css">

    <div class="container">
        <div id="bannerBox">
            <img src="/img/크루배너.jpg" id="bannerImg"/>
        </div>
        <div id="crew_body">
            <div id="crew_nav">
                <ul>
                    <li>크루모집</li>
                    <li>크루생성</li>
                    <li>나의크루</li>
                </ul>
            </div>
        </div>
        <div class="crew_filter">
        </div>
        <div class="crew_list">
            <div class="list_wrapper">
                <ul>
                    <c:forEach var="i" begin="1" end="8">
                        <li class="list_item">
                            <div class="crew_profileimage">
                                <div class="profileBox">
                                    <img src="/img/a8.png" class="profileImg">
                                </div>
                            </div>
                            <div class="crew_content">
                                <div class="crew_title">
                                    <span class="crewname"><b>말달리자</b></span>
                                    <span class="count">🏃‍♀️8<span>
                                </div>
                                <div class="crew_info">
                                    <span class="crewaddr">서울시 영등포구</span>
                                    <span class="crewIntro">남녀모두 환영합니다. 함께하실 분을 찾습니다.</span>
                                    <span class="crewhit">조회 3,490</span>
                                </div>
                            </div>
                            <div class="recruit">
                                <button class="recruitbtn">가입신청하기</button>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
