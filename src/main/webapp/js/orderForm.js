var mypoint = 0;
var realamount = 0;
var usedPoints = 0;
var cnt = 0;
var inputVal;
var inputPoints;
var availableAmount;
let preventFocusOut = false;
var marathon_names = [];
var marathon_namesString="";
var index=0;
var cart_codes=[];
setTimeout(function () {
    console.log(marathon_names);
    if (marathon_names.length>=1){
        for(var i=0;i<1;i++){
            marathon_namesString+=marathon_names[i];
        }
        console.log(marathon_namesString);
        index=marathon_names.length-1;
    }
    if (index!=0){
        marathon_namesString= marathon_namesString+" 그외 "+index;
    }
    console.log(marathon_namesString);
    main();

    $.ajax({
        url: "/order/selectmypoint",
        type: "post",
        data: {
            usercode: usercode1,
        },
        success: function (r) {
            var pvo = r.pvo;
            mypoint = pvo.mypoint;
            console.log("포인트: " + r);
            var tag = `
                <div><div>보유 포인트<div/> <span id="userPoints">` + pvo.mypoint.toLocaleString('ko-KR') + `P</span></div>
                사용<input type="text" id="pointInput" value="0p" placeholder="100p부터 사용가능" onfocusout="usePoints()" onfocus="test()" />
                <button type="button" onclick="useAllPoints()">전액 사용</button>
               `;
            document.getElementById("pointTable").innerHTML = tag;
            document.getElementById("totalamount").innerText = totalAmount.toLocaleString('ko-KR') + "원";
            document.getElementById("totalAmounts").innerText = totalAmount.toLocaleString('ko-KR') + "원";
            selectMarathonForm();
        }
    });
}, 300);

function resetInput() {
    // 포인트 입력 필드를 초기화
    document.getElementById("pointInput").value = ""; // 입력 값 초기화

    // 사용된 포인트 및 관련된 금액들 초기화
    usedPoints = 0;
    realamount = totalAmount; // 총 결제 금액을 원래 값으로 복구
    availableAmount = totalAmount; // 사용 가능한 금액 복구
    cnt = 0; // 전액 사용 카운터 초기화

    // 화면에 보여지는 값들도 초기화
    document.getElementById("userPoints").innerText = mypoint.toLocaleString('ko-KR') + "P"; // 보유 포인트 복구
    document.getElementById("totalAmounts").innerText = totalAmount.toLocaleString('ko-KR') + "원"; // 결제 금액 복구
    document.getElementById("usePoint").innerText = "0P"; // 사용된 포인트 초기화
}

function selectMarathonForm() {
    //마라톤신청폼있는지 확인
    $.ajax({
        url: "/order/selectMyForm",
        type: "post",
        data: {
            usercode: usercode1
        },
        success: function (r) {
            console.log(r);
            MFvo = r.MFvo;
            if (MFvo != null && MFvo != "") {
                var tag = `
             <h2 style="text-align: center">기존 마라톤 신청서</h2>
                  
    
                    <div>
                        <label for="name">이름:</label>
                        <input type="text" id="name" name="name" value="` + MFvo.name + `" maxlength="30" disabled />
                    </div>
                    <div>
                        <label for="tel">전화번호:</label>
                        <input type="tel" id="tel" name="tel"  value="` + MFvo.tel + `" maxlength="15" disabled />
                    </div>
                    <div>
                        <label for="addr">주소:</label>
                        <input type="text" id="addr" value="` + MFvo.addr + `" name="addr" maxlength="100" disabled />
                    </div>
                    <div>
                        <label for="addr_details">상세 주소:</label>
                        <input type="text" id="addr_details" value="` + MFvo.addr_details + `" name="addr_details" maxlength="300" disabled />
                    </div>
                    <div>
                        <label for="gender">성별:</label>
                        
                        <select id="gender" name="gender" disabled>
                            <option value="M" ` + (MFvo.gender === 'M' ? 'selected' : '') + `>남성</option>
                            <option value="F" ` + (MFvo.gender === 'F' ? 'selected' : '') + `>여성</option>
                        </select>
                    </div>
                    <div>
                        <label for="birth_date">생년월일:</label>
                        <input type="date" id="birth_date" name="birth_date" value="` + MFvo.birth_date + `" disabled />
                    </div>
                    <div>
                        <label for="size">사이즈:</label>
                        <input type="text" id="size" name="size" value="` + MFvo.size + `" maxlength="30" disabled />
                    </div>
                   <div>
                       <label for="terms_agreement">이용약관 동의:</label>
                       <input type="checkbox" id="terms_agreement" name="terms_agreement"  value="1" disabled ` + (MFvo.terms_agreement == 1 ? 'checked' : '') + ` />
                   </div>
                    <div>
                        <label for="privacy_consent">개인정보 수집 동의:</label>
                        <input type="checkbox" id="privacy_consent" name="privacy_consent"  value="1" disabled ` + (MFvo.privacy_consent == 1 ? 'checked' : '') + ` />
                    </div>
                    <div>
                        <label for="media_consent">미디어 사용 동의:</label>
                        <input type="checkbox" id="media_consent" name="media_consent"  value="1" disabled ` + (MFvo.media_consent == 1 ? 'checked' : '') + ` />
                    </div>
              <button type="button" id="bolckbtn" onclick="blockbutton()">수정하기</button>
              <div id="hiddenbtn"><button type="button" onclick="savemarathonform()">저장</button><button onclick="cancelmarathonform()" type="button">취소</button></div>
            
            `;
                document.getElementById("marathonForm").innerHTML = tag;
            }
        }
    });
}

var fields = ["name", "tel", "addr", "addr_details", "gender", "birth_date", "size", "terms_agreement", "privacy_consent", "media_consent"];

function blockbutton() {

    fields.forEach(function (fieldId) {
        document.getElementById(fieldId).disabled = false;
    });

    document.getElementById("hiddenbtn").style.display = "block";
    document.getElementById("bolckbtn").style.display = "none";
}

function savebutton() {
    var formdatas = {};
    fields.forEach(function (fieldId) {
        var fieldElement = document.getElementById(fieldId);

        // 체크박스의 경우 checked 상태를 value로 사용
        if (fieldElement.type === "checkbox") {
            if (fieldElement.checked) {
                formdatas[fieldId] = 1;
            }
        } else {
            formdatas[fieldId] = fieldElement.value;
        }
    });
    formdatas.usercode = usercode1;
    $.ajax({
        url: "/mypage/createMarathonForm",
        type: "post",
        data: formdatas,
        success: function (r) {
            selectMarathonForm();
        }
    });


}

function savemarathonform() {
    var formdatas = {};
    fields.forEach(function (fieldId) {
        var fieldElement = document.getElementById(fieldId);

        // 체크박스의 경우 checked 상태를 value로 사용
        if (fieldElement.type === "checkbox") {
            if (fieldElement.checked) {
                formdatas[fieldId] = 1;
            }
        } else {
            formdatas[fieldId] = fieldElement.value;
        }
    });
    formdatas.usercode = usercode1;
    $.ajax({
        url: "/order/updateForm",
        type: "post",
        data: formdatas,
        success: function (r) {

        }


    });


    // 모든 필드를 비활성화
    fields.forEach(function (fieldId) {
        document.getElementById(fieldId).disabled = true;
    });
    document.getElementById("hiddenbtn").style.display = "none";
    document.getElementById("bolckbtn").style.display = "block";
}

function cancelmarathonform() {
    document.getElementById("hiddenbtn").style.display = "none";
    document.getElementById("bolckbtn").style.display = "block";


    // 모든 필드를 비활성화
    fields.forEach(function (fieldId) {
        document.getElementById(fieldId).disabled = true;
    });
}
var count=0;
async function main() {
    const button = document.getElementById("payment-button");
    const testpoint = document.getElementById("pointInput");
    const totalAmountElement = document.getElementById("totalAmounts");

    const amount = {
        currency: "KRW",
        value: totalAmount - usedPoints,
    };

    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const customerKey = generateRandomString();
    const tossPayments = TossPayments(clientKey);
    const widgets = tossPayments.widgets({customerKey});

    await widgets.setAmount(amount);
    await widgets.renderPaymentMethods({selector: "#payment-method", variantKey: "DEFAULT"});
    await widgets.renderAgreement({selector: "#agreement", variantKey: "AGREEMENT"});

    // ------  totalAmounts의 값이 변경될 때 금액 업데이트 ------
    const observer = new MutationObserver(async function (mutations) {
        mutations.forEach(async function (mutation) {
            if (mutation.type === 'childList' || mutation.type === 'characterData') {
                console.log("totalAmounts의 값이 변경되었습니다:", totalAmountElement.innerText);

                const newTotalAmount = Number(totalAmountElement.innerText.replace(/[^0-9]/g, ''));
                const newDiscount = Number(testpoint.value); // 사용한 포인트 (할인 값)
                count=newTotalAmount - newDiscount;
                // 할인을 적용하여 토스페이 위젯에 금액 설정
                await widgets.setAmount({
                    currency: "KRW",
                    value: newTotalAmount - newDiscount,
                });

                console.log("새로운 금액:", newTotalAmount - newDiscount);
            }
        });
    });

    // totalAmountElement 값 변경 감시
    observer.observe(totalAmountElement, {
        childList: true,
        characterData: true,
        subtree: true
    });

    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    button.addEventListener("click", async function () {
        var discount_amount=document.getElementById("pointInput").value;
        discount_amount = discount_amount.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자를 제거 (쉼표와 "P" 제거)
        discount_amount = parseInt(discount_amount, 10); // 문자열을 숫자로 변환
        const orderId = generateRandomString();
        $.ajax({
            url:"/payment/insertpayment",
            type:"post",
            contentType: "application/json",
            data: JSON.stringify({
                orderId: orderId,     // 주문 ID
                usercode: usercode1,                 // 사용자 코드
                total_amount: totalAmount,
                discount_amount:discount_amount,
                cart_codes:cart_codes //결제한 카트코드
            }),
            function(r){
                console.log("확인");
            }
        });
        console.log(count);

        await widgets.requestPayment({
            orderId: orderId,
            orderName: marathon_namesString,
            successUrl: window.location.origin + "/success",
            failUrl: window.location.origin + "/fail",
        });


    });
}

function generateRandomString() {
    return window.btoa(Math.random()).slice(0, 20);
}