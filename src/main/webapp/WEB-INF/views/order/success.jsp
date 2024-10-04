<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="orderSuccess">
    <h1>결제가 성공적으로 완료되었습니다!</h1>
        <p>주문번호: ${order_code}</p>
        <p>결제 금액: ${amount}원</p>
</div>