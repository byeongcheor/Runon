<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <script>
        // 페이지가 로드되면 결제 실패 알림을 띄우고 리다이렉트
        window.onload = function() {
            alert("결제가 실패했습니다. 다시 시도해 주세요.");
            window.location.href = "/order/cart";  // 장바구니 경로로 수정
        };
    </script>
<div class="orderFail">
 <h1>결제가 실패했습니다. 다시 시도해 주세요.</h1>
<div>