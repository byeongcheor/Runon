<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../inc/sidebar.jspf" %>
<link rel="stylesheet" href="/css/adminPages/PaymentList.css" type="text/css">
<script src="/js/adminPages/PaymentList.js" type="text/javascript"></script>
<link rel="stylesheet" href="/css/complete.css" type="text/css">
<div class="PaymentContainer">
    <div id="PaymentHead">
        <div id="maintop">
            <div id="menutitle">PaymentList</div>
            <div id="subtitle">사용자의 결제내역을 관리합니다.</div>
        </div>
    </div>
    <div id="PaymentListbody">
        <div id="mainmid">
            <div>
                <form>
                    <div id="checkboxlist">

                    </div>
                    <div id="searchbar">
                        <select class="form-select" id="CertificateSearchValue" name="CertificateSearchValue"onchange="changeOption()" >
                            <option value="nickname">
                                닉네임
                            </option>
                            <option value="orderId">
                                주문번호
                            </option>
                        </select>
                        <div id="searchbox">
                            <input type="text" id="searchtext" name="searchtext" onkeydown="enterKey(event)" />
                            <div type="button" id="searchbutton" class="btn btn-m search" onclick="searchbutton()">
                                <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                            </div>
                        </div>
                        <div id="resetbutton" onclick="reset()"><i class="fa-solid fa-arrows-rotate test"></i></div>
                        <div>
                            <button type="button" id="amountSortBtn">금액순<i class="fa-solid "></i></button>
                        </div>
                        <div>
                            <button type="button" id="latestSortBtn">최신순<i class="fa-solid "></i></button>
                        </div>
                    </div>
                    <div id="selectbutton"></div>
                </form>
                <%-- <div id="downloadbutton" style="margin: auto 0; display: none"></div>--%>
            </div>
        </div>
        <div id="PaymentListbottom">
            <div class="PaymentListFavMain">
                <div id='PaymentList'></div>
            </div>
            <ul class="pagination justify-content-center">
            </ul>
            <div class="box_rightType1">
            </div>
        </div>
    </div>
    <div id="paymentdetailbackground">
        <div id="Paymentdetail">
            <div  id="closedetail"><i onclick="closedetail()" class="fa-regular fa-circle-xmark fa-3x"></i></div>
            <div id="usermain">
                <div class="orderSheetFrm">
                    <div class="orderStName">
                        <h1 style="margin-top: 30px;">주문내역</h1>
                    </div>
                    <div class="orderStTop">
                        <div id="orderStN" class="orderStN">

                        </div>
                        <div class="orderPt">
                            <span>날짜</span>
                            <span>상품명/옵션</span>
                            <span>상품금액</span>
                            <span>주문상태</span>
                        </div>
                        <div id="orderP2" class="orderP">

                        </div>
                    </div>
                    <div class="discountList">
                        <div class="discountListN">
                            <span>할인 정보</span>
                        </div>
                        <div class="discountL">
                            <div class="discountL2">
                                <span>포인트 사용</span>
                                <span id="usepoint">0원</span>
                            </div>
                        </div>
                    </div>
                    <div class="payList">
                        <div class="payListN">
                            <span>결제 정보</span>
                        </div>
                        <div class="discountL">
                            <div class="discountL2">
                                <span>상품금액</span>
                                <span id="totalamount">25,000원</span>
                            </div>
                            <div  class="discountL2">
                                <span>할인 합계</span>
                                <span id="discount2">0원</span>
                            </div>
                            <div class="discountL2">
                                <span>최종 결제 금액</span>
                                <span id="realamount"></span>
                            </div>
                            <div class="discountL2">
                                <span>결제 수단</span>
                                <span id="method"></span>
                            </div>
                        </div>
                    </div>
                    <div onclick="closedetail()" class="orderOk">
                        <span>확인</span>
                    </div>
                </div>
            </div>
            <div id="Certificatecontent">
                <div id="CertificateDetails">
                </div>
                <div id="certificate">
                </div>
            </div>
            <div id="addButton">
            </div>

        </div>
    </div>




</div>


</div>
