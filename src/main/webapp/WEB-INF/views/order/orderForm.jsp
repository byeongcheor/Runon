<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="totalAmount" value="0" />

<link rel="stylesheet" href="/css/orderForm.css" type="text/css">
<script src="/js/orderForm.js" type="text/javascript"></script>
<script src="https://js.tosspayments.com/v2/standard"></script>
<script>
    var marathon_names = [];


    // JSP의 forEach를 사용하여 배열에 마라톤명 추가
    <c:forEach var="order" items="${Cvo}">
    marathon_names.push("${order.marathon_name}");  // 서버 데이터를 클라이언트에 전달
    </c:forEach>
    <c:forEach var="order" items="${Cvo}">
    cart_codes.push("${order.cart_code}");  // 서버 데이터를 클라이언트에 전달
    </c:forEach>
</script>
<div class="cartFrm">
    <div class="cartName" id="cartItemsContainer">
        <h1>주문서 작성</h1>
    </div>
    <div class="orderMain">
        <div class="orderM">
            <div>상품정보</div>
            <div>수량</div>
            <div>상품단가</div>
            <div>상품금액</div>

        </div>

        <div id="ticket_order" class="ticket_order">
            <c:forEach var="order" items="${Cvo}">
                <div class="oneline">
                    <div class="ticket">
                        <div style="width:80px;height: 80px; border-radius: 10px;">
                            <img src="/img/marathonPoster/${order.poster_img}" style="width:100%; height:100%; object-fit: cover;border-radius: 10px;"/>
                        </div>
                        <span class="marathonT">${order.marathon_name}</span>
                    </div>
                    <div class="num">${order.quantity}</div>
                    <div class="price">${order.price}</div>
                    <div class="amount">${order.price*order.quantity}</div>
                </div>
                <c:set var="totalAmount" value="${totalAmount + (order.price * order.quantity)}" />

            </c:forEach>
        </div>
        <div class="titles">할인정보</div>
        <div class=tables>
            <div class="pointTables">
                <div class="aaa">포인트사용</div>
                <div id="pointTable">
                    <input type="text" id="pointInput" placeholder="100p부터 사용가능"/>
                    <button type="button" onclick="useAllPoints()">전액 사용</button>
                    <div>보유 포인트: <span id="userPoints">0원</span></div>
                </div>
            </div>
        </div>

        <div class="titles">기존 마라톤신청서</div>

            <div id="marathonForm">
                <div class="maraT">
                    <div class="maraL">
                        <label for="name">이름</label>
                    </div>
                    <div class="maraR">
                        <input type="text" id="name" name="name" maxlength="30" required />
                    </div>
                </div>
                <div class="maraT">
                    <div class="maraL">
                        <label for="tel">전화번호</label>
                    </div>
                    <div class="maraR">
                        <input type="tel" id="tel" name="tel" maxlength="15" required />
                    </div>
                </div>
                <div class="maraT">
                    <div class="maraL">
                        <label for="addr">주소</label>
                    </div>
                    <div class="maraR">
                        <input type="text" id="addr" name="addr" maxlength="100" required />
                    </div>
                </div>
                <div class="maraT">
                    <div class="maraL">
                        <label for="addr_details">상세 주소</label>
                    </div>
                    <div class="maraR">
                        <input type="text" id="addr_details" name="addr_details" maxlength="300" required />
                    </div>
                </div>
                <div class="maraT">
                    <div class="maraL">
                        <label for="gender">성별</label>
                    </div>
                    <div class="maraR">
                        <select id="gender" name="gender" required>
                            <option value="M">남성</option>
                            <option value="F">여성</option>
                        </select>
                    </div>
                </div>
                <div class="maraT">
                    <div class="maraL">
                        <label for="birth_date">생년월일</label>
                    </div>
                    <div class="maraR">
                        <input type="date" id="birth_date" name="birth_date" required />
                    </div>
                </div>
                <div class="maraT">
                    <div class="maraL">
                        <label for="size">사이즈</label>
                    </div>
                    <div class="maraR">
                        <input type="text" id="size" name="size" maxlength="30" required />
                    </div>
                </div>
                <div>
                    <label for="terms_agreement">이용약관 동의:</label>
                    <input type="checkbox" id="terms_agreement" name="terms_agreement" required />
                </div>
                <div>
                    <label for="privacy_consent">개인정보 수집 동의:</label>
                    <input type="checkbox" id="privacy_consent" name="privacy_consent" required />
                </div>
                <div>
                    <label for="media_consent">미디어 사용 동의:</label>
                    <input type="checkbox" id="media_consent" name="media_consent" />
                </div>
                <button type="button" onclick="savebutton()">작성하기</button>

            </div>

        <%--토스 --%>
        <div class="wrapper">
            <div class="box_section" style="padding: 40px 30px 50px 30px; margin-top: 30px; margin-bottom: 50px">
                <!-- 결제 UI -->
                <div id="payment-method"></div>
                <!-- 이용약관 UI -->
                <div id="agreement"></div>
                <!-- 쿠폰 체크박스 -->

            </div>

        </div>
    </div>
    <div class="paymentC">
        <ul class="payD">
            <li>총 주문 금액 </li>
            <li>사용 포인트</li>
            <li>총 결제 금액</li>
        </ul>
        <ul class="payP" id="totalAmountDisplay">
            <li id="totalamount">0원</li>
            <li id="usePoint">0원</li>
            <li id="totalAmounts">00원</li>
        </ul>

    </div>

    <div class="orderC">
        <!-- 결제하기 버튼 -->
        <div class="result wrapper checkOrder">
            <button class="button" id="payment-button" >마라톤 신청하기</button>
        </div>
    </div>
</div>


<script>
    totalAmount = ${totalAmount};
    /*console.log("Total Amount: " + totalAmount);*/
    function test(){
        resetInput();

        document.getElementById("pointInput").value = "";
        totalAmount = ${totalAmount};
        availableAmount=totalAmount
        cnt=0
        inputVal = document.getElementById("pointInput").value;
        inputPoints = 0;


    }

    /*function usePoints() {
        totalAmount=${totalAmount};
        inputVal = document.getElementById("pointInput").value;
        inputPoints = parseInt(inputVal, 10); // 숫자로 변환
        //alert("아웃되고 처음"+totalAmount);
        realamount=totalAmount;
        availableAmount = totalAmount - usedPoints; // 사용 가능한 총액 계산
        if (isNaN(inputPoints)){
            inputPoints=0;
            totalAmount=${totalAmount};


        }
        if (inputPoints < 100 &&inputPoints>0) {
            alert("100포인트 이상부터 사용 가능합니다.");
            inputPoints=0;
            return;
        }

        if (inputPoints > mypoint) {
            alert("  보유 포인트보다 많은 포인트를 사용할 수 없습니다\n총 결제 금액의 10%보다 많은 포인트를 사용할 수 없습니다.");
            inputPoints = totalAmount * 0.1 ;

        }else{
            if (inputPoints > availableAmount*0.1) {
                alert("총 결제 금액의 10%보다 많은 포인트를 사용할 수 없습니다.");
                inputPoints = availableAmount*0.1;
            }else if (inputPoints == availableAmount*0.1){
                inputPoints = availableAmount*0.1;
            }
        }
        //alert("마지막"+totalAmount);
        // 사용된 포인트 업데이트
        usedPoints = inputPoints;

        realamount=realamount-usedPoints
        // 남은 포인트와 화면에 보여줄 값 업데이트
        document.getElementById("userPoints").innerText = (mypoint - inputPoints).toLocaleString('ko-KR') + "P";
        document.getElementById("pointInput").value = usedPoints.toLocaleString('ko-KR') + "P";
        document.getElementById("totalAmounts").innerText=realamount.toLocaleString('ko-KR')+"원";
        document.getElementById("usePoint").innerText=usedPoints.toLocaleString('ko-KR') + "P";
        document.getElementById("testinput").value=usedPoints;


    }function useAllPoints() {
        resetInput()
        cnt++;
        if (cnt==1){
            usemypoint=0
            totalAmount=${totalAmount};
            availableAmount = totalAmount - usedPoints; // 사용 가능한 총액 계산

            usemypoint = mypoint >= availableAmount ? availableAmount : mypoint;
            usedPoints = usemypoint*0.1;
            realamount=totalAmount-usedPoints;
            // 사용된 포인트 업데이트


            // 남은 포인트와 화면에 보여줄 값 업데이트
            document.getElementById("usePoint").innerText=usedPoints.toLocaleString('ko-KR') + "P";
            document.getElementById("userPoints").innerText = (mypoint - usedPoints).toLocaleString('ko-KR') + "P";
            document.getElementById("pointInput").value = usedPoints.toLocaleString('ko-KR') + "P";
            document.getElementById("totalAmounts").innerText=realamount.toLocaleString('ko-KR')+"원";

        }
    }*/
    function usePoints() {
        totalAmount = ${totalAmount};
        inputVal = document.getElementById("pointInput").value;
        inputPoints = parseInt(inputVal, 10); // 숫자로 변환
        realamount = totalAmount;
        availableAmount = totalAmount - usedPoints; // 사용 가능한 총액 계산

        if (isNaN(inputPoints) || inputPoints < 100) {
            alert("100포인트 이상부터 사용 가능합니다.");
            inputPoints = 0;
            return;
        }

        // 100 단위로 조정
        if (inputPoints % 100 !== 0) {
            alert("포인트는 100 단위로만 사용 가능합니다.");
            inputPoints = Math.floor(inputPoints / 100) * 100; // 100의 배수로 내림
        }

        if (inputPoints > mypoint) {
            alert("보유 포인트보다 많은 포인트를 사용할 수 없습니다.");
            inputPoints = Math.floor(mypoint / 100) * 100;
        }

        if (inputPoints > availableAmount * 0.1) {
            alert("총 결제 금액의 10%보다 많은 포인트를 사용할 수 없습니다.");
            inputPoints = Math.floor((availableAmount * 0.1) / 100) * 100;
        }

        usedPoints = inputPoints;
        realamount = totalAmount - usedPoints;

        // 화면 업데이트
        document.getElementById("userPoints").innerText = (mypoint - usedPoints).toLocaleString('ko-KR') + "P";
        document.getElementById("pointInput").value = usedPoints.toLocaleString('ko-KR') + "P";
        document.getElementById("totalAmounts").innerText = realamount.toLocaleString('ko-KR') + "원";
        document.getElementById("usePoint").innerText = usedPoints.toLocaleString('ko-KR') + "P";
    }

    function useAllPoints() {
        resetInput();
        usemypoint = 0;
        totalAmount = ${totalAmount};
        availableAmount = totalAmount - usedPoints;

        usemypoint = mypoint >= availableAmount ? availableAmount : mypoint;
        if (usemypoint >= 100) {
            // 100 단위로 조정
            if (usemypoint % 100 !== 0) {
                usemypoint = Math.floor(usemypoint / 100) * 100;
            }

            usedPoints = usemypoint > availableAmount * 0.1 ? Math.floor((availableAmount * 0.1) / 100) * 100 : usemypoint;
            realamount = totalAmount - usedPoints;

            document.getElementById("usePoint").innerText = usedPoints.toLocaleString('ko-KR') + "P";
            document.getElementById("userPoints").innerText = (mypoint - usedPoints).toLocaleString('ko-KR') + "P";
            document.getElementById("pointInput").value = usedPoints.toLocaleString('ko-KR') + "P";
            document.getElementById("totalAmounts").innerText = realamount.toLocaleString('ko-KR') + "원";
        } else {
            alert("100포인트 단위로 사용 가능합니다.");
        }
    }
</script>