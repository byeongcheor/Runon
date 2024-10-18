setTimeout(function(){



    // '전체 선택' 체크박스도 선택 상태로 설정
    const selectAllCheckbox = document.getElementById('selectAll');
    if (selectAllCheckbox) {
        selectAllCheckbox.checked = true;
    }

    // 상태 업데이트
    //updateSelectAll();

    cartload();

},300);

// 선택된 상품 삭제 함수
function deleteSelectedItems() {
    const checkedItems = document.querySelectorAll('input[name="itemCheckbox"]:checked');
    alert(usercode1);
    if (checkedItems.length === 0) {
        alert("삭제할 상품을 선택해 주세요.");
        return; // 선택된 상품이 없으면 종료
    }
    let CheckedItems=[];
    checkedItems.forEach(item => {
        const tipoffElement = item.value; // 해당 상품의 부모 요소를 찾음
        CheckedItems.push(item.value);
        // 반복문확인 console.log(tipoffElement);// DOM에서 해당 상품 삭제

    });
    // 배열에 값 들어가는거 확인console.log(CheckedItems);

    // db조회후 안보이게
    $.ajax({
        url:"/cart/deleted",
        type:"post",
        contentType:"application/json",
        data:JSON.stringify({
            items:CheckedItems
        }),
        success:function(r){
            cartload();
        }
    });
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
function increase(test,cart_code) {
    datas={};

    if (test==1){
        datas.action="add";
    }else{
        datas.action = "remove";
    }
    datas.cart_code=cart_code;
    $.ajax({
        url:"/cart/cartupdate",
        type:"post",
        data:datas,
        success:function(r){
            cartload();
        }

    });

}



// 총 금액을 0으로 초기화하는 함수
function resetTotalAmount() {
    totalAmounts = 0;
    // 총 금액을 0으로 설정
    document.getElementById('totalAmounts').innerText = "0원";
}
// '전체 선택' 체크박스 클릭 시 모든 항목 선택/해제
function toggleSelectAll() {
    const selectAllCheckbox = document.getElementById('selectAll');
    const checkboxes = document.querySelectorAll('.itemCheckbox');

    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAllCheckbox.checked; // 전체 선택 체크박스의 상태에 따라 체크박스 상태 설정
    });
    if(!selectAllCheckbox.checked){
        resetTotalAmount();
    }else{
        cartload();
    }

}

let totalAmounts = 0;
// 체크박스 상태가 변경될 때 호출되는 함수
function updateTotalAmount(cartCode, amount, isChecked) {
    const checkboxes = document.querySelectorAll('.itemCheckbox');
    const selectAllCheckbox = document.getElementById('selectAll');
    for (let checkbox of checkboxes) {
        if (!checkbox.checked) {
            selectAllCheckbox.checked=false;// 체크되지 않은 체크박스가 있으면 false 반환
        }
    }

    // 상품 가격을 확인하고, 체크박스가 체크된 상태인지에 따라 처리
    console.log(isChecked);
    console.log("정수확인"+amount);
    amount = parseInt(amount);
    const allamount=amount;
    if (isChecked==true) {
        totalAmounts = totalAmounts+amount;
        console.log("정수확인3:"+amount);// 체크된 경우 금액을 더함
    } else if(isChecked==false){
        totalAmounts = totalAmounts-amount;
        if (0>=totalAmounts){
            totalAmounts=0;
        }
        console.log("정수확인4:"+amount);// 체크 해제된 경우 금액을 뺌
    }else{
        totalAmounts=amount;
    }
    alert(totalAmounts.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' }))
    /*document.getElementById('amount').innerText=allamount .toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });*/
    document.getElementById('totalAmounts').innerText=totalAmounts .toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
}
function cartload(){
    $.ajax({
        url:"/cart/cart",
        type:"POST",
        data: {
            usercode: usercode1,
        },
        success: function(r) {
            cart = r.cartItems;

            var cnt=0;
            var tag="<div class='tipoff'>";
            cart.forEach(function (cart) {
                var price=cart.price
                var amount=(cart.price*cart.quantity);
                var tagprice=price.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
                var tagamount=amount.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' })
                cnt+=amount;
                tag+='<div class="oneline">' +
                    '<input type="hidden" id="productId" name="productId" value="'+cart.marathon_code+'">';
                tag+=   '<div class="checkB"><input type="checkbox" name="itemCheckbox" class="itemCheckbox" id="itemCheckbox" value="'+cart.cart_code+'" onclick="updateTotalAmount(\'' + cart.cart_code + '\', \'' + amount + '\', this.checked)"></div>';
                tag+=   '<div class="ticket"><img src="'+cart.poster_img+'" alt="마라톤 포스터" class="marathonP"><span class="marathonT">'+cart.marathon_name+ '</span></div>';
                tag+=   '<div class="marathonC">'+
                    '<div class="counter-container">' +
                    '<button onclick="increase(0,' + cart.cart_code + ')">-</button>';
                tag += '<span id="number">' + cart.quantity + '</span>';
                tag += '<button onclick="increase(1, ' + cart.cart_code + ')">+</button>' ;
                tag+=           '</div></div>' +
                    '<div class="price">'+tagprice+'</div>' +
                    '<div class="amount">'+tagamount+'</div>' +
                    '</div>';

            });
            tag+="</div>";
            document.getElementById('ticket_cart').innerHTML = tag;


            const checkboxes = document.querySelectorAll('.itemCheckbox');
            console.log(checkboxes);
            // 모든 항목을 기본적으로 선택
            checkboxes.forEach((checkbox) => {
                checkbox.checked = true;

            });


            document.getElementById('amount').innerText = cnt.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
            updateTotalAmount( cart.cart_code, cnt , this.checked)
        }
    });
}
function goOrder(){
    const checkedItems = document.querySelectorAll('.itemCheckbox:checked');
    if (checkedItems.length === 0) {
        alert("선택한 상품이 없습니다.");
        return;
    }
    let selectedItems = [];

    // 체크된 항목들의 데이터를 추출
    checkedItems.forEach((item) => {
        const cartCode = item.value;  // cart_code 값을 가져옴 (체크박스의 value에 cart_code가 저장됨)
        selectedItems.push(cartCode);  // 선택된 cart_code를 배열에 추가
    });
    console.log(selectedItems);
    let form = document.createElement('form');
    form.method = 'POST';
    form.action = '/order/orderForm'; // 이동할 페이지


    selectedItems.forEach(item => {
        let input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'items[]';  // 서버에서 배열로 처리 가능
        input.value = item;
        form.appendChild(input);
    });
    let usercodeInput = document.createElement('input');
    usercodeInput.type = 'hidden';
    usercodeInput.name = 'usercode';  // 서버에서 usercode로 처리
    usercodeInput.value = usercode1;   // usercode 값을 여기서 가져옴
    form.appendChild(usercodeInput);

    document.body.appendChild(form);
    form.submit();  // 폼 전송

}