
// 장바구니에 추가된 상품 수량 변경부분
let number = 1;
let price=0;
// 총 금액을 전역 변수로 선언
let totalAmount = 0; // 총 금액 초기화
let appliedPoints = 0; // 적용된 포인트 (할인으로 적용됨)
// 사용자 포인트(예시)
let userPoints = 1000;

setTimeout(function(){
    var usercode=usercode1
    var token = localStorage.getItem("Authorization");
    alert(usercode);
    const checkboxes = document.querySelectorAll('input[name="itemCheckbox"]');

    // 모든 항목을 기본적으로 선택
    checkboxes.forEach((checkbox) => {
        checkbox.checked = true;
    });

    // '전체 선택' 체크박스도 선택 상태로 설정
    const selectAllCheckbox = document.getElementById('selectAll');
    if (selectAllCheckbox) {
        selectAllCheckbox.checked = true;
    }

    // 상태 업데이트
    updateSelectAll();

    // '선택 상품 주문하기' 버튼 클릭 시 동작
    document.getElementById('orderButton').addEventListener('click', function () {
        const checkedItems = document.querySelectorAll('input[name="itemCheckbox"]:checked');

        console.log("Checked items:", checkedItems.length); // 체크된 상품 수량 로그

        // 체크된 상품이 있으면 결제 진행
        if (checkedItems.length > 0) {

            requestPayment(checkedItems); // 결제 요청 함수 호출
        } else {
            alert("선택한 상품이 없습니다."); // 체크된 상품이 없으면 메시지 표시
        }
    });
    $.ajax({
        url:"/order/cart",
        type:"POST",
        data: {
            usercode: usercode1,
        },
        success: function(r) {
            cart = r.ordercart;
            cart.forEach(function (cart) {
                tag = "<div>list.subject</div>"
            });
            document.getElementById('orderButton').innerHTML = tag;
        }
    });

},100);

// 선택된 상품 삭제 함수
function deleteSelectedItems() {
    const checkedItems = document.querySelectorAll('input[name="itemCheckbox"]:checked');
    alert(usercode1);
    alert(username1);
    if (checkedItems.length === 0) {
        alert("삭제할 상품을 선택해 주세요.");
        return; // 선택된 상품이 없으면 종료
    }

    checkedItems.forEach(item => {
        const tipoffElement = item.closest('.tipoff'); // 해당 상품의 부모 요소를 찾음
        if (tipoffElement) {
            tipoffElement.remove(); // DOM에서 해당 상품 삭제
        }
    });

    // 총 금액 업데이트
    updateProductTotal(); // 총 금액을 재계산하여 업데이트
}


// 페이지가 로드될 때 총 가격을 업데이트
document.addEventListener('DOMContentLoaded', function() {
    // 초기 상품 총 금액을 업데이트
    updateProductTotal();
});

// 상품 총 금액과 포인트 적용 금액을 업데이트하는 함수
function updateProductTotal() {

    // 선택된 상품들을 확인합니다.
    const checkedItems = document.querySelectorAll('input[name="itemCheckbox"]:checked');
    totalAmount = 0; // 총 금액 초기화

    // 선택된 상품들의 가격을 합산
    checkedItems.forEach(item => {
        const priceElement = item.closest('.tipoff').querySelector('.ticketP span');
        const price = parseInt(priceElement.innerText.replace(/[^0-9]/g, '')); // 가격 숫자 추출



        // 현재 수량을 가져옵니다.
        let quantity = parseInt(document.getElementById("number").textContent);

        // 총 금액 계산 (단가 * 수량)
        let totalPrice = price * quantity;

        // productTotal 요소에 상품 총 금액 업데이트
        document.getElementById('productTotal').innerText = totalPrice.toLocaleString() + "원";

        // 고객이 입력한 포인트 값 (할인 금액으로 사용)
        let discountAmount = appliedPoints || 0;
        document.getElementById('discountAmount').innerText = appliedPoints.toLocaleString() + "원";

        // 총 금액은 상품 금액에서 포인트를 뺀 값으로 계산
        let finalAmount = totalPrice - discountAmount;

        // 총 금액에 '원'을 붙여서 표시
        document.getElementById('totalAmount').innerText = finalAmount.toLocaleString() + "원";
    });
}
function increase() {

    number++;
    document.getElementById("number").textContent = number;

    // 수량이 증가할 때 총 가격 업데이트
    updateProductTotal();
}

function decrease() {
    if (number > 1) {
        number--;
        document.getElementById("number").textContent = number;

        // 수량이 감소할 때 총 가격 업데이트
        updateProductTotal();
    }
}





// 포인트 모달 열기
function openModal() {
    document.getElementById("couponModal").style.display = "flex";
}

// 포인트 모달 닫기
function closeModal() {
    document.getElementById("couponModal").style.display = "none";
}

// 상품 삭제 시 금액 업데이트 및 DOM에서 해당 항목 제거
// 상품 삭제 시 금액 업데이트 및 DOM에서 해당 항목 제거
function removeItem(itemId, price) {
    var item = document.getElementById(itemId);

    // 부모 요소 (상품 전체 칸)을 삭제
    if (item) {
        item.closest('.tipoff').remove();  // 부모 클래스 tipoff 삭제
    }

    // 상품 금액 감소
    totalAmount -= price;
    if (totalAmount < 0) totalAmount = 0;  // 금액이 음수가 되지 않도록

    // 남아있는 상품이 있는지 확인
    const remainingItems = document.querySelectorAll('.tipoff');

    // 장바구니에 남은 상품이 없을 때 총 금액을 0으로 설정
    if (remainingItems.length === 0) {
        resetTotalAmount();
    } else {
        // 남은 상품이 있을 경우, 총 금액 업데이트 함수 호출
        updateTotalAmountWithDiscount();
    }
}

// 총 금액을 0으로 초기화하는 함수
function resetTotalAmount() {
    totalAmount = 0;
    appliedPoints = 0;

    // 총 금액을 0으로 설정
    document.getElementById('productTotal').innerText = "0원";
    document.getElementById('discountAmount').innerText = "0원";
    document.getElementById('totalAmount').innerText = "0원";
}
// 포인트 최대 적용 함수
function applyMaxPoints() {
    // 사용자 포인트 가져오기
    const userPoints = parseInt(document.getElementById('userPoints').innerText.replace(/[^0-9]/g, '')); // 사용자 포인트 가져오기
    document.getElementById('discountInput').value = userPoints; // 입력 필드에 사용자 포인트 설정

    // 포인트 적용 후 총 금액 업데이트
    applyCoupon(); // 최대 포인트를 적용한 후 총 금액 업데이트
}

// 포인트 적용하기
function applyCoupon() {
    // 사용자가 입력한 포인트 값 가져오기
    let points = parseInt(document.getElementById('discountInput').value) || 0;

    // 입력한 포인트가 사용자 포인트를 초과하지 않는지 확인
    const userPoints = parseInt(document.getElementById('userPoints').innerText.replace(/[^0-9]/g, ''));
    if (points > userPoints) {
        alert("사용할 수 있는 포인트가 부족합니다. 최대 " + userPoints + " 원까지만 사용 가능합니다.");
        document.getElementById('discountInput').value = userPoints; // 최대 포인트로 설정
        points = userPoints; // 포인트를 최대값으로 설정
    }

    // 총 상품 금액보다 포인트가 클 경우 포인트를 상품 금액까지만 적용
    let totalPrice = parseInt(document.getElementById("productTotal").innerText.replace(/[^0-9]/g, ''));
    if (points > totalPrice) {
        points = totalPrice;
    }

    // 포인트 적용 후, 모달 닫기
    appliedPoints = points;
    document.getElementById('appliedPoints').innerText = appliedPoints.toLocaleString() + '원 사용';  // 모달에 적용된 포인트 표시
    closeModal();

    // 총 금액 업데이트
    updateTotalAmountWithDiscount();
}

// 총 금액과 할인 금액을 반영한 최종 금액 업데이트
function updateTotalAmountWithDiscount() {
    // productTotal에서 총 상품 금액을 가져옵니다.
    const productTotalText = document.getElementById("productTotal").innerText;
    let productTotal = parseInt(productTotalText.replace(/[^0-9]/g, ''));

    // 최종 금액 계산
    const finalAmount = productTotal - appliedPoints;

    // 상품 금액과 총 금액을 HTML에 업데이트
    document.getElementById('productTotal').innerText = productTotal.toLocaleString() + "원";
    document.getElementById('discountAmount').innerText = appliedPoints.toLocaleString() + "원";
    document.getElementById('totalAmount').innerText = (finalAmount > 0 ? finalAmount : 0).toLocaleString() + "원";
}

// 페이지가 로드될 때 총 가격을 업데이트
document.addEventListener('DOMContentLoaded', updateProductTotal);


// '전체 선택' 체크박스 클릭 시 모든 항목 선택/해제
function toggleSelectAll() {
    const selectAllCheckbox = document.getElementById('selectAll');
    const checkboxes = document.querySelectorAll('input[name="itemCheckbox"]');

    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAllCheckbox.checked; // 전체 선택 체크박스의 상태에 따라 체크박스 상태 설정
    });

    updateSelectAll(); // 체크박스 상태 업데이트
}

// 개별 항목 선택 시 상태 업데이트
function updateSelectAll() {
    const checkboxes = document.querySelectorAll('input[name="itemCheckbox"]');
    const orderButton = document.getElementById('orderButton');

    let isAnyChecked = false; // 하나라도 선택된 항목이 있는지 여부
    let isAllChecked = true;  // 모든 항목이 선택되었는지 여부

    // 체크박스 상태 확인
    checkboxes.forEach((checkbox) => {
        if (checkbox.checked) {
            isAnyChecked = true; // 선택된 항목이 있으면 true
        } else {
            isAllChecked = false; // 선택되지 않은 항목이 있으면 false
        }
    });

    // '전체 선택' 체크박스 상태 설정
    const selectAllCheckbox = document.getElementById('selectAll');
    if (selectAllCheckbox) { // 요소가 존재하는지 확인
        selectAllCheckbox.checked = isAllChecked; // 선택된 항목의 상태에 따라 전체 선택 체크박스 설정
    }


}

// 페이지 로드 시 모든 상품을 선택된 상태로 설정
$(document).ready(function () {

});
//온로드 끝
// 토스페이먼츠 결제 요청
const clientKey = "test_ck_ma60RZblrqKzA7jLeex63wzYWBn1";
const customerKey = "l1lg7ARfyrAiOiFlTQ2Eu";
const tossPayments = TossPayments(clientKey);

const payment = tossPayments.payment({ customerKey });
// 결제 요청 함수 (체크된 상품 배열을 사용하여 결제 처리)


async function requestPayment(checkedItems) {


    // 선택된 상품들의 가격을 합산
    checkedItems.forEach(item => {
        const priceElement = item.closest('.tipoff').querySelector('.ticketP span');
        const price = parseInt(priceElement.innerText.replace(/[^0-9]/g, '')); // 가격 숫자 추출
        const quantity = parseInt(document.getElementById("number").textContent); // 현재 수량 추출
        let totalPrice = price  * quantity;


        // productTotal 요소에 상품 총 금액 업데이트
        document.getElementById('productTotal').innerText = totalPrice.toLocaleString() + "원";

        // 고객이 입력한 포인트 값 (할인 금액으로 사용)
        let discountAmount = appliedPoints || 0;
        document.getElementById('discountAmount').innerText = appliedPoints.toLocaleString() + "원";

        // 총 금액은 상품 금액에서 포인트를 뺀 값으로 계산
        totalAmount = totalPrice - discountAmount;

        // 총 금액에 '원'을 붙여서 표시
        document.getElementById('totalAmount').innerText = totalAmount.toLocaleString() + "원";


    });


    try {

        console.log("Total amount for payment:", totalAmount); // 총 금액 로그
        await payment.requestPayment({
            method: "CARD",
            amount: {
                currency: "KRW",
                value: totalAmount,
            },
            orderId: "tele4rvgeIO2CBSn7rYII",
            orderName: "2024 3대 마라톤 - 여의도 나이트런",
            successUrl: window.location.origin + "/order/ordersheet",
            failUrl: window.location.origin + "/fail",
            customerEmail: "goguma123@naver.com",
            customerName: "고구마",
            customerMobilePhone: "01012341234",
            card: {
                useEscrow: false,
                flowMode: "DEFAULT",
                useCardPoint: false,
                useAppCardOnly: false,
            },
        });
        console.log("Payment request sent.");// 결제 요청 완료 로그
    } catch (error) {
        //console.error("Payment failed:", error); // 결제 실패 처리
        alert("결제 요청을 다시 시도해주세요."); // 사용자에게 알림
    }

}
