var count2=0;
setTimeout(function(){
    // '전체 선택' 체크박스도 선택 상태로 설정




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
        url:"/order/deleted",
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


function increase(test,cart_code) {
    datas={};

    if (test==1){
        datas.action="add";
    }else{
        datas.action = "remove";
    }
    datas.cart_code=cart_code;
    $.ajax({
        url:"/order/cartupdate",
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
    }else if(selectAllCheckbox.checked){
        cartload();
    }

}
let totalAmounts = 0;
// 체크박스 상태가 변경될 때 호출되는 함수
function updateTotalAmount(cartCode, amount, isChecked) {
    const selectAllCheckbox = document.getElementById('selectAll');
    selectAllCheckbox.checked=true;
    if (selectAllCheckbox.checked==true){
        const checkboxes = document.querySelectorAll('.itemCheckbox');

        checkboxes.forEach((checkbox) => {
            checkbox.checked = selectAllCheckbox.checked; // 전체 선택 체크박스의 상태에 따라 체크박스 상태 설정
        });
        isChecked==true
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

    alert(totalAmounts.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' }));
    /*document.getElementById('amount').innerText=allamount .toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });*/
    document.getElementById('totalAmounts').innerText=totalAmounts .toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
}
function cartload(){

    $.ajax({
        url:"/order/cart",
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
            tag+=`</div>`;
            document.getElementById('ticket_cart').innerHTML = tag;
            const selectAllCheckbox = document.getElementById('selectAll');
            if (selectAllCheckbox.checked){
                const checkboxes = document.querySelectorAll('.itemCheckbox');

                checkboxes.forEach((checkbox) => {
                    checkbox.checked = true; // 전체 선택 체크박스의 상태에 따라 체크박스 상태 설정
                });
            }


            // 모든 항목을 기본적으로 선택

            document.getElementById('amount').innerText = cnt.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
            updateTotalAmount( cart.cart_code, cnt , this.checked)
        }
    });
}
