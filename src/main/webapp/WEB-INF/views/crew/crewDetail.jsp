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
<link rel="stylesheet" href="/css/crewDetail.css" type="text/css">

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg" />
    </div>
    <div class="content_body">
        <div class="content_left">
            <section class="section3">
                <div class="profile_container">
                    <div class="team-header">
                        <div class="team-emblem">
                            <div class="emblem-wrapper">
                                <div class="emblem-background">
                                    <img src="/img/man1.png" class="emblem-image" />
                                </div>
                            </div>
                        </div>
                        <div class="team-content">
                            <div><span class="team-name">dd</span></div>
                            <span class="team-info">여자 · 축구 · 10대 · 비기너3</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- 멤버 모집 조건 박스 -->
            <div class="recruitment-box">
                <h3>👩‍👩‍👧‍👧 멤버 모집 조건</h3>
                <div class="team-body">
                    <div class="feature-list">
                        <div class="feature-item">
                            <span class="icon-emoji">⭐</span>
                            <span class="feature-text">여자만</span>
                        </div>
                        <div class="feature-item">
                            <span class="icon-emoji">⭐</span>
                            <span class="feature-text">20대~30대</span>
                        </div>
                        <div class="feature-item">
                            <span class="icon-emoji">⭐</span>
                            <span class="feature-text">스타터</span>
                        </div>
                        <div class="feature-item">
                            <span class="icon-emoji">⭐</span>
                            <span class="feature-text">0원/월</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="button-container">
                <div class="top-buttons">
                    <button class="action-button">수정하기</button>
                    <button class="action-button">모집중단하기</button>
                </div>
                <div class="bottom-button">
                    <button class="action-button wide">가입신청하기</button>
                </div>
            </div>
        </div>
        <div class="content_right">
            <section class="section1">
                <div class="image-text-container">
                    <div class="image-wrapper">
                        <img
                            src="/img/러닝고화질.jpg"
                            alt="Sample Image"
                            class="responsive-image"
                        />
                    </div>
                    <div class="text-wrapper">
                        <p>여기에 텍스트를 넣으세요. 원하는 설명이나 내용을 작성할 수 있습니다.</p>
                    </div>
                    <div class="extra-info">
                        조회 8 · 신청 0
                        <span style="float: right;">업데이트 39분 전</span>
                    </div>
                </div>
            </section>
        </div>
    </div></div>
<script>
    $(document).ready(function() {
        var createCrewCode = "${create_crew_code}";
        console.log("Crew Code:", createCrewCode);  // JavaScript로 값 확인
    });

</script>