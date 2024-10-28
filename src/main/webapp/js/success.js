// 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
// 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
const urlParams = new URLSearchParams(window.location.search);

// 서버로 결제 승인에 필요한 결제 정보를 보내세요.
async function confirm() {
    var requestData = {
        paymentKey: urlParams.get("paymentKey"),
        orderId: urlParams.get("orderId"),
        amount: urlParams.get("amount"),
    };

    const response = await fetch("/confirm", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(requestData),
    });

    const json = await response.json();

    if (!response.ok) {
        // TODO: 결제 실패 비즈니스 로직을 구현하세요.
       /* console.log(json);*/
        window.location.href = `/fail?message=${json.message}&code=${json.code}`;
    }

    // TODO: 결제 성공 비즈니스 로직을 구현하세요.
    // console.log(json);
  /*  console.log("json확인"+JSON.stringify(json));
    console.log("requestData확인"+JSON.stringify(requestData));*/
    return json;
}
confirm().then(function (data) {
   /* console.log(data);*/
    //결제금액
    var total_Amount=data.balanceAmount;

    //카드결제일때 json
    var card=data.crad;
    //결제방식
    var method=data.method;
    //주문번호
    var orderId=data.orderId;
    //주문상품
    var orderName=data.orderName;
    //결제시간
    var approvedAt=data.approvedAt;
    //결제key
    var paymentKey=data.paymentKey;
    $.ajax({
       url:"/payment/saveOrder",
       type:"post",
        contentType: 'application/json', // 서버에서 JSON 형식을 기대할 경우
        data: JSON.stringify({
            method: method,
            orderId: orderId,
            total_Amount: total_Amount,
            usercode: usercode1,
            paymentKey: paymentKey
        }),
        success:function(r){
            // 동적으로 폼 생성
            let form = document.createElement("form");
            form.method = "post";
            form.action = "/payment/complete";  // 이동할 페이지 설정

            // 전달할 값을 폼에 숨겨진 필드로 추가
            let orderIdInput = document.createElement("input");
            orderIdInput.type = "hidden";
            orderIdInput.name = "orderId";
            orderIdInput.value = orderId;
            form.appendChild(orderIdInput);

            let totalAmountInput = document.createElement("input");
            totalAmountInput.type = "hidden";
            totalAmountInput.name = "totalAmount";
            totalAmountInput.value = total_Amount;
            form.appendChild(totalAmountInput);

            let methodInput = document.createElement("input");
            methodInput.type = "hidden";
            methodInput.name = "method";
            methodInput.value = method;
            form.appendChild(methodInput);

            let usercodeInput = document.createElement("input");
            usercodeInput.type = "hidden";
            usercodeInput.name = "usercode";
            usercodeInput.value = usercode1;
            form.appendChild(usercodeInput);

            // 동적으로 생성한 폼을 문서에 추가하고 제출
            document.body.appendChild(form);
            form.submit();
        },
        error: function(xhr, status, error) {
         /*   console.error("결제 실패: " + error);
            console.log(error);
            console.log(status);
            console.log(xhr);
            alert("결제 중 오류가 발생했습니다. 다시 시도해주세요.");*/
        }
    });


  /*  console.log(total_Amount);
    document.getElementById("response").innerHTML = `<pre>${JSON.stringify(data, null, 4)}</pre>`;*/
});

const paymentKeyElement = document.getElementById("paymentKey");
const orderIdElement = document.getElementById("orderId");
const amountElement = document.getElementById("amount");

orderIdElement.textContent = urlParams.get("orderId");
amountElement.textContent = urlParams.get("amount") + "원";
paymentKeyElement.textContent = urlParams.get("paymentKey");

