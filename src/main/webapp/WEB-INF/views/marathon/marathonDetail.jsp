<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 메타 데이터 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap JS 및 추가 스크립트 연결 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 카카오 지도 API 연결 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c0dd7bd78a44e2891255c1e5f1403da"></script>
<!-- Bootstrap CSS 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- FontAwesome 아이콘 라이브러리 연결 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<!-- 커스텀 스타일 시트 연결 -->
<link rel="stylesheet" href="/css/marathonDetail.css" type="text/css">
<%@ include file="/WEB-INF/views/chat/chatList.jsp" %>



<div class="marathonDetailFrm">
    <div class="marathonDetailFrmImg">
        <img src="/img/marathonListImg.jpg"/>
    </div>
    <div class="marathonDetailF">
        <div class="marathonDTop">
            <div class="marathonDImg">
                <img src="/img/defaultimg.png"/>
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
                            <span id="likeCount" class="like-count">0</span> <!-- 좋아요 수 -->
                        </div>
                        <button class="MC">장바구니</button>
                        <button class="MP">바로구매</button>
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
                        <li class="list-group-item"><strong><img src="/img/4.png"/> 일시: </strong> ${marathon.event_date}</li> <!-- 대회 날짜 -->
                        <li class="list-group-item"><strong><img src="/img/5.png"/> 장소: </strong> ${marathon.addr}</li> <!-- 장소 -->
                        <li class="list-group-item"><strong><img src="/img/6.png"/> 종목: </strong> ${marathon.total_distance}</li> <!-- 종목 -->
                    </ul>
                </div>
                <!-- 오른쪽 열: 접수 정보 -->
                <div class="col-md-6">
                    <ul class="list-group">
                        <li class="list-group-item"><strong><img src="/img/1.png"/> 접수기간: </strong> ${marathon.registration_start_date} ~ ${marathon.registration_end_date}</li>
                        <li class="list-group-item"><strong><img src="/img/2.png"/> 결제가능: </strong> 가능</li>
                        <li class="list-group-item"><strong><img src="/img/3.png"/> 주최: </strong> (주)러닝포인트</li>
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
            <iframe id="mapIframe" class="iframe1"></iframe>
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


<script>
    //db불러오고 다시 주석 풀기
    <%--var marathonId = ${marathon.marathon_code};--%>


    <!-- 좋아요 버튼 클릭 이벤트 처리 -->
    const likeButton = document.getElementById('likeButton'); // 좋아요 버튼
    const heartIcon = document.getElementById('heartIcon'); // 하트 아이콘
    const likeCount = document.getElementById('likeCount'); // 좋아요 카운트 표시
    let liked = false; // 좋아요 상태 플래그
    let count = 0; // 초기 좋아요 카운트

    // 좋아요 버튼 클릭 이벤트
    likeButton.addEventListener('click', function () {
        liked = !liked; // 좋아요 상태 토글
        if (liked) {
            heartIcon.classList.remove('far'); // 비어있는 하트 제거
            heartIcon.classList.add('fas'); // 채워진 하트로 변경
            likeButton.classList.add('clicked'); // 하트 색상 빨간색으로 변경
            count++; // 좋아요 카운트 증가
        } else {
            heartIcon.classList.remove('fas'); // 채워진 하트 제거
            heartIcon.classList.add('far'); // 비어있는 하트로 변경
            likeButton.classList.remove('clicked'); // 하트 색상 원래대로
            count--; // 좋아요 카운트 감소
        }

        likeCount.textContent = count; // 좋아요 카운트 업데이트
    });

    //마라톤 거리 옵션 선택
    const marathonItem = document.getElementById('marathonDItem');
    const marathonSize = document.getElementById('marathonDSize');
    const totalPriceDisplay = document.querySelector('.DP');
    const cartButton = document.querySelector('.MC'); // 장바구니 버튼

    // 함수: 두 가지 선택 옵션이 모두 선택되었는지 확인 후 총 금액 표시
    function updateTotalPrice() {
        const itemPrice = parseInt(marathonItem.value);
        const sizeSelected = marathonSize.value !== '0'; // 사이즈가 선택되었는지 확인

        if (itemPrice > 0 && sizeSelected) {
            totalPriceDisplay.textContent = itemPrice + "원";
        } else {
            totalPriceDisplay.textContent = "0원"; // 하나라도 선택되지 않으면 0원 표시
        }
    }

    // 장바구니 버튼 클릭 시
    document.querySelector('.MC').addEventListener('click', function() {
        const itemPrice = parseInt(document.getElementById('marathonDItem').value); // 선택한 상품 가격
        // 마라톤 ID를 선택한 상품의 select 요소에서 가져오는 예시
        const marathonItem = document.getElementById('marathonDItem');
        const marathonId = marathonItem.value; // 선택한 마라톤의 ID

        const usercode = "YOUR_USER_CODE"; // 실제 사용자 코드로 교체해야 합니다.
        const sizeSelected = document.getElementById('marathonDSize').value !== '0'; // 사이즈 선택 여부 확인

        if (itemPrice > 0 && sizeSelected) {
            // 장바구니에 담을 데이터를 서버로 전송
            const cartData = {
                price: itemPrice,
                marathon_code: marathonId,
                usercode: usercode,
                quantity: 1
            };

            fetch('/marathon/addToCart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(cartData)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 모달 띄우기
                        const cartModal = new bootstrap.Modal(document.getElementById('cartModal'), {});
                        cartModal.show(); // 장바구니에 성공적으로 담기면 모달 띄움
                    } else {
                        alert(data.message); // 실패 메시지 출력
                    }
                })
                .catch(error => {
                    console.error('Error adding to cart:', error);
                    alert('장바구니에 담기 실패!');
                });
        } else {
            alert('상품과 사이즈를 모두 선택해주세요.');
        }
    });

    // 장바구니로 이동 버튼 클릭 시
    document.getElementById('goToCartBtn').addEventListener('click', function() {
        window.location.href = '/marathon/cart'; // 장바구니 페이지로 이동
    });



    //지도
    // "지도로" 버튼 클릭 시 길찾기 iframe 표시
    // JSP/Thymeleaf에서 전달받은 위도와 경도 값을 자바스크립트 변수에 할당
    var latitude = '37.402056';  // 위도
    var longitude =  '127.108212'; // 경도
    var marathonName =  '마라톤 장소'; // 마라톤 이름

    // 길찾기 iframe URL 설정
    var iframeSrc = 'https://map.kakao.com/link/to/' + encodeURIComponent(marathonName) + ',' + latitude + ',' + longitude;

    // iframe에 길찾기 URL 적용
    document.getElementById('mapIframe').src = iframeSrc;



    //////////////////////
    //     // 병원 버튼 클릭 시 병원 마커 표시
    //     document.getElementById('hospitalButton').addEventListener('click', function() {
    //         searchHospitals(); // 병원 검색 함수 호출
    //     });
    //
    //     // 지도 생성 및 병원 검색 기능
    //     var mapContainer = document.getElementById('mapIframe'); // 지도를 표시할 iframe
    //     var mapOption = {
    //         center: new kakao.maps.LatLng(37.566535, 126.97796919999996), // 지도의 중심 좌표 (예시 좌표)
    //         level: 3 // 지도의 확대 레벨
    //     };
    //
    //     var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    //
    //     // 장소 검색 객체 생성
    //     var ps = new kakao.maps.services.Places();
    //
    //     // 병원 검색 함수
    //     function searchHospitals() {
    //         var options = {
    //             location: map.getCenter(), // 현재 지도 중심 좌표
    //             radius: 1000 // 1km 반경 내 검색
    //         };
    //
    //         ps.categorySearch('HP8', placesSearchCB, options); // 병원 카테고리 검색 (HP8: 병원)
    //     }
    //
    //     // 장소 검색 결과 처리 함수
    //     function placesSearchCB(data, status, pagination) {
    //         if (status === kakao.maps.services.Status.OK) {
    //             for (var i = 0; i < data.length; i++) {
    //                 displayMarker(data[i]); // 마커 표시
    //             }
    //         }
    //     }
    //
    //     // 마커 표시 함수
    //     function displayMarker(place) {
    //         var marker = new kakao.maps.Marker({
    //             map: map,
    //             position: new kakao.maps.LatLng(place.y, place.x) // 장소의 좌표로 마커 설정
    //         });
    //
    //         // 마커 클릭 시 장소명 표시
    //         kakao.maps.event.addListener(marker, 'click', function() {
    //             alert(place.place_name);
    //         });
    //     }

</script>
