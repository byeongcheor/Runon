<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 메타 데이터 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap JS 및 추가 스크립트 연결 -->
<!-- 카카오 지도 API 연결 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- Bootstrap CSS 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- FontAwesome 아이콘 라이브러리 연결 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- 커스텀 스타일 시트 연결 -->
<link rel="stylesheet" href="/css/marathonDetail.css" type="text/css">
<script>
    const marathonItem = document.getElementById('marathonDItem');
    const marathonId = ${marathon.marathon_code}; // 선택한 마라톤의 ID
    // JSP/Thymeleaf에서 전달받은 위도와 경도 값을 자바스크립트 변수에 할당
    var latitude = '${marathon.lat}';  // 위도
    var longitude = '${marathon.lon}'; // 경도
    var marathonName = '${marathon.marathon_name}'; // 마라톤 이름
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05ef55fc6b73294aca4c220a11e58311&libraries=services"></script>

<script src="/js/marathonDetail.js" type="text/javascript"></script>
<div class="marathonDetailFrm">
    <div class="marathonDetailFrmImg">
        <img src="/img/marathonListImg.jpg"/>
    </div>
    <div class="marathonDetailF">
        <div class="marathonDTop">
            <div class="marathonDImg">
                <img src="/resources/uploadfile/${marathon.poster_img}" alt="마라톤 이미지">
            </div>
            <div class="marathonDContent">
                <div class="marathonDTTop">
                    <span class="marathonDName">${marathon.marathon_name}</span> <!-- 마라톤 이름 -->
                    <div class="Mline"></div>
                    <div class="marathonType">
                        <span class="marathonO">상품</span>
                        <select id="marathonDItem">
                            <option value="0" selected>선택</option>
                            <c:forEach var="distance" items="${distancePriceMap.keySet()}">
                                <option value="${distancePriceMap[distance]}">${distance}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="marathonTypeSize">
                        <span class="marathonO1">사이즈</span>
                        <select id="marathonDSize">
                            <option value="0" selected>선택</option>
                            <option value="티셔츠(S)">티셔츠(S)</option>
                            <option value="티셔츠(M)">티셔츠(M)</option>
                            <option value="티셔츠(L)">티셔츠(L)</option>
                            <option value="티셔츠(XL)">티셔츠(XL)</option>
                        </select>
                    </div>
                    <div class="marathonDPay">
                        <span class="DFP">총 금액</span>
                        <span class="DP">0원</span>
                    </div>
                    <!-- 좋아요 버튼 및 카운트 -->
                    <div class="marathonDCart">
                        <div class="like-container">
                            <button class="btn-like" id="likeButton">
                                <i class="far fa-heart" id="heartIcon"></i> <!-- 비어있는 하트 -->
                            </button>
                            <span id="likeCount" class="like-count">${marathon.like_count}</span> <!-- 좋아요 수 -->
                        </div>
                        <button class="MC">장바구니</button>
                        <button type="button" id="buyNowButton" class="MP">바로구매</button>
                    </div>
                </div>
            </div>
        </div>
        <div style="border: 1px solid rgb(234, 234, 234); margin-top: 30px; margin-bottom: 30px;"></div>
        <!-- 대회 안내 섹션 (대회 정보 리스트) -->
        <div class="marathon-info-section">
            <h2>대회안내</h2>
            <div class="row">
                <!-- 왼쪽 열: 대회 정보 -->
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item"><strong><img src="/img/d.png"/> 일시: </strong> ${marathon.event_date}</li> <!-- 대회 날짜 -->
                        <li class="list-group-item"><strong><img src="/img/e.png"/> 장소: </strong> ${marathon.addr}</li> <!-- 장소 -->
                        <li class="list-group-item"><strong><img src="/img/f.png"/> 종목: </strong> ${marathon.total_distance}</li> <!-- 종목 -->
                    </ul>
                </div>
                <!-- 오른쪽 열: 접수 정보 -->
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item"><strong><img src="/img/a.png"/> 접수기간: </strong> ${marathon.registration_start_date} ~ ${marathon.registration_end_date}</li>
                        <li class="list-group-item"><strong><img src="/img/b.png"/> 결제가능: </strong> 가능</li>
                        <li class="list-group-item"><strong><img src="/img/c.png"/> 주최: </strong> (주)러닝포인트</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="marathonDCC">
            <h2>마라톤 상세설명</h2>
            <div class="mDC">${marathon.marathon_content}</div> <!-- 상세 설명 -->
        </div>
        <!-- 지도 표시할 영역 -->
        <div class="hospital">
            <h2>마라톤대회 길찾기</h2>
            <div id="map" style="width:800px;height:600px;"></div>
            <!-- 병원 버튼 추가 -->
            <%--            <button id="hospitalButton" style="margin-top: 10px;">주변 병원 보기</button>--%>
        </div>

    </div>
    <!-- 모달 버튼 없이 직접 자바스크립트로 모달을 띄움 -->
    <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="cartModalLabel">장바구니 추가</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">계속 쇼핑하기</button>
                    <button type="button" class="btn btn-primary" id="goToCartBtn">장바구니로 이동</button>
                </div>
            </div>
        </div>
    </div>
</div>

