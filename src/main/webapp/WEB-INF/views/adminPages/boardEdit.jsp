<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- CKEditor 스크립트 추가 -->
<link rel="stylesheet" href="/ckeditor/ckeditor.css"/>
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/super-build/ckeditor.js"></script>
<script src="/ckeditor/ckeditor.js"></script>
<!-- Bootstrap CSS 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- FontAwesome 아이콘 라이브러리 연결 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/adminPages/boardEdit.css" type="text/css">
<script src="/js/adminPages/boardEdit.js" type="text/javascript"></script>


<form action="/adminPages/marathon/update" method="post" enctype="multipart/form-data" class="boardEditFrm">
    <input type="hidden" name="marathonCode" value="${marathonDetail.marathon_code}">
    <div class="marathonDetailFrm">
        <div class="marathonDetailF">
            <div class="marathonDTop">
                <div class="marathonDImg">
                    <!-- 이미지 업로드 -->
                    <input type="file" name="posterImage" id="posterImage" accept="image/*" onchange="updateImage(event)">
                    <img id="marathonPoster" src="/img/marathonPoster/${marathonDetail.poster_img}" alt="마라톤 포스터">
                </div>
                <div class="marathonDContent">
                    <div class="marathonDTTop">
                        <!-- 마라톤 이름 -->
                        <span>마라톤 대회명</span>
                        <input type="text" name="marathonName" id="marathonName" value="${marathonDetail.marathon_name}">
                        <div class="Mline"></div>
                        <div class="marathonType">
                            <span class="marathonO">상품</span>
                            <input type="text" name="total_distance" value="${marathonDetail.total_distance}">
                            <div class="marathonO text">마라톤 상품(km)별 적어주세요.<br/>(예: 5km,8km,10km)</div>
                        </div>
                        <div class="marathonTypeSize">
                            <span class="marathonO1">가격</span>
                            <input type="text" name="entry_fee" value="${marathonDetail.entry_fee}">
                            <div class="marathonO1 text">마라톤 거리에 따라 가격을 적어주세요.<br/>(예: 25000원/40000원/55000원)</div>
                        </div>

                    </div>
                </div>
            </div>
            <div style="border: 1px solid rgb(234, 234, 234); margin-top: 60px; margin-bottom: 30px;"></div>
            <!-- 대회 안내 섹션 (대회 정보 리스트) -->
            <div class="marathon-info-section">
                <h2>대회안내</h2>
                <div class="row">
                    <!-- 왼쪽 열: 대회 정보 -->
                    <div class="col-md-6">
                        <ul class="list-group">
                            <li class="list-group-item"><strong><img src="/img/d.png"/> 일시: </strong>  <input type="datetime-local" name="event_date" value="${marathonDetail.event_date}">
                            </li> <!-- 대회 날짜 -->
                            <li class="list-group-item"><strong><img src="/img/e.png"/> 장소: </strong> <input type="text" name="addr" value="${marathonDetail.addr}">
                            </li> <!-- 장소 -->
<%--                            <li class="list-group-item"><strong><img src="/img/f.png"/> 종목: </strong>  <input type="text" name="total_distance" value="${marathonDetail.total_distance}">--%>
                            </li> <!-- 종목 -->
                        </ul>
                    </div>
                    <!-- 오른쪽 열: 접수 정보 -->
                    <div class="col-md-6">
                        <ul class="list-group">
                            <li class="list-group-item"><strong><img src="/img/a.png"/> 접수기간: </strong> <input class="rg" type="date" name="registration_start_date" value="${fn:substring(marathonDetail.registration_start_date, 0, 10)}">
                                ~
                                <input class="rg" type="date" name="registration_end_date" value="${fn:substring(marathonDetail.registration_end_date, 0, 10)}"></li>
                            <li class="list-group-item"><strong><img src="/img/b.png"/> 결제가능: </strong> 가능</li>
                            <li class="list-group-item"><strong><img src="/img/c.png"/> 주최: </strong> (주)러닝포인트</li>
                        </ul>
                    </div>
                </div>
                <div class="marathonMap">
                    <h2>마라톤 지도</h2>
                    <span>위도:</span><input type="text" id="latitude" name="latitude" value="${marathonDetail.lat}"><br/>
                    <span>경도:</span><input type="text" id="longitude"  name="longitude"  value="${marathonDetail.lon}" >
                </div>
            </div>


            <div class="marathonDCC">
                <h2>마라톤 상세설명</h2>
                <div class="mDC">
                    <textarea name="marathonContent" id="marathonContent">${marathonDetail.marathon_content}</textarea>
                </div> <!-- 상세 설명 -->
            </div>
            <button type="submit" class="btn btn-outline-success tnwjdBtn">수정하기</button>

        </div>
    </div>


</form>
