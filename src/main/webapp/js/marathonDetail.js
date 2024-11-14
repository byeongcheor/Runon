var usercode;

setTimeout(function(){
    var ToKen=localStorage.getItem("Authorization");
    if (ToKen!=null &&ToKen!="" ) {
        ToKen = ToKen.substring(7);
        console.log(ToKen);
        $.ajax({
            url: "/setToKengetUsers",
            type: "POST",
            data: {
                ToKen: ToKen
            },
            success: function (r) {
                // alert("Test");
                // 유저정보 담기
                usercode = r.mvo.usercode;
                username = r.mvo.username;

                console.log(usercode)
            },error:function(e){
                console.log(e);

            }
        });
    }
    alert("확인");
    console.log('User Code:', usercode); // 디버깅용 로그 추가

    // 페이지 로드 시 조회수 증가 요청
    fetch('/marathon/incrementViewCount', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            marathon_code: marathonId // 요청 본문에 데이터를 포함
        })
    })
        .then(response => response.json())

        .then(data => {
            console.log(data)
            if (!data.success) {
                console.error("조회수 증가 실패:", data.message);
            }
        })
        .catch(error => {
            console.error("조회수 증가 요청 중 오류 발생:", error);
        });

    // 좋아요 버튼 클릭 이벤트 처리
    const likeButton = document.getElementById('likeButton'); // 좋아요 버튼
    const heartIcon = document.getElementById('heartIcon'); // 하트 아이콘
    const likeCount = document.getElementById('likeCount'); // 좋아요 카운트 표시
    let count = parseInt(likeCount.textContent); // 현재 좋아요 수 가져오기
    let liked = false; // 좋아요 상태 플래그

    /// 초기 상태 설정 함수
    function setInitialLikeState() {
        fetch(`/marathon/checkLike?usercode=`+usercode+`&marathon_code=`+marathonId)
            .then(response => response.json())
            .then(data => {
                if (data.liked) {
                    liked = true; // 사용자가 이미 좋아요를 눌렀다면
                    heartIcon.classList.remove('far');
                    heartIcon.classList.add('fas');
                    likeButton.classList.add('clicked');
                }

                likeCount.textContent = count; // 초기 카운트 업데이트
            })
            .catch(error => {
                console.error('좋아요 상태 확인에 실패했습니다:', error);
            });
    }
    // 페이지 로드 시마다 좋아요 상태 확인
    setInitialLikeState();

// 좋아요 아이콘 업데이트 함수
    function updateHeartIcon() {
        if (liked) {
            heartIcon.classList.remove('far');
            heartIcon.classList.add('fas');
            likeButton.classList.add('clicked');
        } else {
            heartIcon.classList.add('far');
            heartIcon.classList.remove('fas');
            likeButton.classList.remove('clicked');
        }
    }

    // 좋아요 버튼 클릭 이벤트
    likeButton.addEventListener('click', function () {
        // 로그인 여부 확인
        if (!usercode) {  // usercode가 없을 경우
            alert('로그인 후 이용해주세요.'); // 로그인 후 이용 알림
            return;  // 로그인하지 않았으면 좋아요 요청을 보내지 않음
        }
        console.log('좋아요 버튼 클릭됨', usercode, marathonId); // 추가 로그
        fetch('/marathon/addLike', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                usercode: usercode,
                marathon_code: marathonId
            })
        })
            .then(response => response.json())
            .then(data => {
                console.log('서버에서 받은 데이터', data);
                if (data && data.success) {
                    liked = !liked; // 좋아요 상태 토글
                    liked ? count++ : count--; // 카운트 업데이트
                    likeCount.textContent = count; // 좋아요 카운트 업데이트
                    updateHeartIcon(); // 하트 상태 업데이트
                } else {
                    alert(data.message || '좋아요 추가 실패');
                }
            })
            .catch(error => {
                console.error('좋아요 추가에 실패했습니다:', error);
            });
    });

    // 마라톤 거리 옵션 선택
    const marathonItem = document.getElementById('marathonDItem'); // 마라톤 거리 선택 요소
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
    // 옵션 변경 시 총 금액 업데이트
    marathonItem.addEventListener('change', updateTotalPrice);
    marathonSize.addEventListener('change', updateTotalPrice);

    // 장바구니 버튼 클릭 시
    document.querySelector('.MC').addEventListener('click', function() {
        const itemPrice = parseInt(marathonItem.value); // 선택한 상품 가격
        const sizeSelected = marathonSize.value !== '0'; // 사이즈 선택 여부 확인


        // 대회 접수 마감 여부 확인
        const currentDate = new Date();
        const registrationStartDate = new Date(document.querySelector('.MC').getAttribute('data-start-date'));
        const registrationEndDate = new Date(document.querySelector('.MC').getAttribute('data-end-date'));

        if (currentDate < registrationStartDate) {
            alert('접수 시작 전입니다.');
            return;
        }

        if (currentDate > registrationEndDate) {
            alert('접수 마감 됐습니다.');
            return;
        }


        // 필수 항목 모두 선택 확인
        if (itemPrice > 0 && sizeSelected && usercode) {
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
            // 상품, 사이즈, 사용자 코드 선택 여부 확인 후 메시지 출력
            if (!usercode) {
                alert('로그인 후 다시 시도해주세요.'); // 로그인 미비 메시지
            } else {
                alert('상품과 사이즈를 모두 선택해주세요.'); // 필수 항목 미선택 메시지
            }
        }
    });

    // 장바구니로 이동 버튼 클릭 시
    document.getElementById('goToCartBtn').addEventListener('click', function() {
        window.location.href = '/cart/cart'; // 장바구니 페이지로 이동
    });
    // 장바구니 추가 후 이동하는 버튼 클릭 시
    document.getElementById('buyNowButton').addEventListener('click', function() {
        const itemPrice = parseInt(marathonItem.value); // 선택한 상품 가격
        const sizeSelected = marathonSize.value !== '0'; // 사이즈 선택 여부 확인

        // 대회 접수 마감 여부 확인
        const currentDate = new Date();
        const registrationStartDate = new Date(document.getElementById('buyNowButton').getAttribute('data-start-date'));
        const registrationEndDate = new Date(document.getElementById('buyNowButton').getAttribute('data-end-date'));

        if (currentDate < registrationStartDate) {
            alert('접수 시작 전입니다.');
            return;
        }

        if (currentDate > registrationEndDate) {
            alert('접수 마감 됐습니다.');
            return;
        }


        if (itemPrice > 0 && sizeSelected && usercode) {
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
                        // 장바구니에 추가 성공 후 장바구니 페이지로 이동
                        window.location.href = '/cart/cart'; // 장바구니 페이지로 이동
                    } else {
                        alert(data.message); // 실패 메시지 출력
                    }
                })
                .catch(error => {
                    console.error('Error adding to cart:', error);
                    alert('장바구니에 담기 실패!');
                });
        } else {
            // 상품, 사이즈, 사용자 코드 선택 여부 확인 후 메시지 출력
            if (!usercode) {
                alert('로그인 후 다시 시도해주세요.'); // 로그인 미비 메시지
            } else {
                alert('상품과 사이즈를 모두 선택해주세요.'); // 필수 항목 미선택 메시지
            }
        }
    });

    // 계속 쇼핑하기 버튼 클릭 시
    document.querySelector('.btn-secondary').addEventListener('click', function() {
        const cartModal = bootstrap.Modal.getInstance(document.getElementById('cartModal')); // 모달 인스턴스 가져오기
        cartModal.hide(); // 모달 닫기
        // 마라톤 리스트 페이지로 이동
        window.location.href = '/marathon/marathonList'; // 또는 사용자가 원래 있던 페이지로 이동
    });
    initializeMap();
},500);

var map;
function initializeMap() {
    var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(latitude, longitude),
            level: 4
        };

    // 전역 변수 map에 Kakao Map 객체 할당
    map = new kakao.maps.Map(mapContainer, mapOption);

    var imageSrc = '/img/runmaker.png',
        imageSize = new kakao.maps.Size(64, 69),
        imageOption = { offset: new kakao.maps.Point(27, 69) };
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

    var userMarker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(latitude, longitude),
        image: markerImage
    });
    userMarker.setMap(map);

    // Ajax 요청으로 병원 목록 가져오기
    $.ajax({
        url: "/marathon/hospitalList",
        type: "post",
        data: {
            latitude: latitude,
            longitude: longitude
        },
        success: function(r) {
            var hospitals = r.hvoList;
            hospitals.forEach(function(hospital) {
                displayMarker(hospital);
            });
        }
    });

    // 병원 위치에 마커와 툴팁을 표시하는 함수
    function displayMarker(hospital) {
        var position = new kakao.maps.LatLng(hospital.latitude, hospital.longitude);
        var tooltipMarker = new TooltipMarker(position, hospital.name);
        tooltipMarker.setMap(map);

        var markerTracker = new MarkerTracker(map, tooltipMarker);
        markerTracker.run();
    }
}

// 버튼 클릭 시 내 위치로 이동하는 함수
function panToUserLocation() {
    if (map) {
        var userPosition = new kakao.maps.LatLng(latitude, longitude);
        map.setCenter(userPosition);
    } else {
        console.error("Map 객체가 초기화되지 않았습니다.");
    }
}

// TooltipMarker 함수
function TooltipMarker(position, tooltipText) {
    this.position = position;
    var node = this.node = document.createElement('div');
    node.className = 'node';

    var tooltip = document.createElement('div');
    tooltip.className = 'tooltip';
    tooltip.appendChild(document.createTextNode(tooltipText));
    node.appendChild(tooltip);

    node.onmouseover = function() {
        tooltip.style.display = 'block';
    };
    node.onmouseout = function() {
        tooltip.style.display = 'none';
    };
}

TooltipMarker.prototype = new kakao.maps.AbstractOverlay;

TooltipMarker.prototype.onAdd = function() {
    var panel = this.getPanels().overlayLayer;
    panel.appendChild(this.node);
};

TooltipMarker.prototype.onRemove = function() {
    this.node.parentNode.removeChild(this.node);
};

TooltipMarker.prototype.draw = function() {
    var projection = this.getProjection();
    var point = projection.pointFromCoords(this.position);

    var width = this.node.offsetWidth;
    var height = this.node.offsetHeight;

    this.node.style.left = (point.x - width / 2) + "px";
    this.node.style.top = (point.y - height / 2) + "px";
};

TooltipMarker.prototype.getPosition = function() {
    return this.position;
};

// MarkerTracker 함수
function MarkerTracker(map, target) {
    var OUTCODE = { INSIDE: 0, TOP: 8, RIGHT: 2, BOTTOM: 4, LEFT: 1 };
    var BOUNDS_BUFFER = 30;
    var CLIP_BUFFER = 40;

    var tracker = document.createElement('div');
    tracker.className = 'tracker';

    var icon = document.createElement('div');
    icon.className = 'icon';

    var balloon = document.createElement('div');
    balloon.className = 'balloon';

    tracker.appendChild(balloon);
    tracker.appendChild(icon);

    map.getNode().appendChild(tracker);

    tracker.onclick = function() {
        map.setCenter(target.getPosition());
        setVisible(false);
    };

    function tracking() {
        var proj = map.getProjection();
        var bounds = map.getBounds();
        var extBounds = extendBounds(bounds, proj);

        if (extBounds.contain(target.getPosition())) {
            setVisible(false);
        } else {
            var pos = proj.containerPointFromCoords(target.getPosition());
            var center = proj.containerPointFromCoords(map.getCenter());

            var sw = proj.containerPointFromCoords(bounds.getSouthWest());
            var ne = proj.containerPointFromCoords(bounds.getNorthEast());

            var top = ne.y + CLIP_BUFFER;
            var right = ne.x - CLIP_BUFFER;
            var bottom = sw.y - CLIP_BUFFER;
            var left = sw.x + CLIP_BUFFER;

            var clipPosition = getClipPosition(top, right, bottom, left, center, pos);

            tracker.style.top = clipPosition.y + 'px';
            tracker.style.left = clipPosition.x + 'px';

            var angle = getAngle(center, pos);
            balloon.style.cssText +=
                '-ms-transform: rotate(' + angle + 'deg);' +
                '-webkit-transform: rotate(' + angle + 'deg);' +
                'transform: rotate(' + angle + 'deg);';

            setVisible(true);
        }
    }

    function extendBounds(bounds, proj) {
        var sw = proj.pointFromCoords(bounds.getSouthWest());
        var ne = proj.pointFromCoords(bounds.getNorthEast());

        sw.x -= BOUNDS_BUFFER;
        sw.y += BOUNDS_BUFFER;

        ne.x += BOUNDS_BUFFER;
        ne.y -= BOUNDS_BUFFER;

        return new kakao.maps.LatLngBounds(
            proj.coordsFromPoint(sw),
            proj.coordsFromPoint(ne)
        );
    }

    function getClipPosition(top, right, bottom, left, inner, outer) {
        function calcOutcode(x, y) {
            var outcode = OUTCODE.INSIDE;
            if (x < left) outcode |= OUTCODE.LEFT;
            else if (x > right) outcode |= OUTCODE.RIGHT;
            if (y < top) outcode |= OUTCODE.TOP;
            else if (y > bottom) outcode |= OUTCODE.BOTTOM;
            return outcode;
        }

        var ix = inner.x, iy = inner.y, ox = outer.x, oy = outer.y;
        var code = calcOutcode(ox, oy);

        while (true) {
            if (!code) break;
            if (code & OUTCODE.TOP) { ox += (ix - ox) / (iy - oy) * (top - oy); oy = top; }
            else if (code & OUTCODE.RIGHT) { oy += (iy - oy) / (ix - ox) * (right - ox); ox = right; }
            else if (code & OUTCODE.BOTTOM) { ox += (ix - ox) / (iy - oy) * (bottom - oy); oy = bottom; }
            else if (code & OUTCODE.LEFT) { oy += (iy - oy) / (ix - ox) * (left - ox); ox = left; }
            code = calcOutcode(ox, oy);
        }

        return { x: ox, y: oy };
    }

    function getAngle(center, target) {
        var dx = target.x - center.x;
        var dy = center.y - target.y;
        return ((-Math.atan2(dy, dx) * 180 / Math.PI + 360) % 360 | 0) + 90;
    }

    function setVisible(visible) {
        tracker.style.display = visible ? 'block' : 'none';
    }

    function hideTracker() {
        setVisible(false);
    }

    this.run = function() {
        kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.addListener(map, 'zoom_changed', tracking);
        kakao.maps.event.addListener(map, 'center_changed', tracking);
        tracking();
    };

    this.stop = function() {
        kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
        kakao.maps.event.removeListener(map, 'center_changed', tracking);
        setVisible(false);
    };
}