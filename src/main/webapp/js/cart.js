   ///장바구니 추가된 상품 수량 변경부분
let number = 1;

function increase() {
    number++;
    document.getElementById("number").textContent = number;
}

function decrease() {
    if (number > 1) {
        number--;
        document.getElementById("number").textContent = number;
    }
}
////////
// 전체 선택 체크박스 클릭 시 호출
function toggleSelectAll() {
        var selectAllCheckbox = document.getElementById('selectAll');
        var itemCheckboxes = document.querySelectorAll('.itemCheckbox');

        // 전체 선택 체크박스의 상태에 따라 모든 개별 체크박스를 선택/해제
        itemCheckboxes.forEach(function(checkbox) {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }

    // 개별 체크박스 클릭 시 전체 선택 상태를 업데이트
    function updateSelectAll() {
        var selectAllCheckbox = document.getElementById('selectAll');
        var itemCheckboxes = document.querySelectorAll('.itemCheckbox');

        // 모든 개별 체크박스가 체크되었는지 확인
        var allChecked = true;
        itemCheckboxes.forEach(function(checkbox) {
            if (!checkbox.checked) {
                allChecked = false;
            }
        });

        // 모든 개별 체크박스가 체크되었다면 전체 선택 체크박스도 체크
        selectAllCheckbox.checked = allChecked;
    }
// 모달 열기
function openModal() {
    document.getElementById("couponModal").style.display = "flex";
}

// 모달 닫기
function closeModal() {
    document.getElementById("couponModal").style.display = "none";
}

// 쿠폰 적용 기능
function applyCoupon() {
    alert("쿠폰을 적용했습니다!");
}