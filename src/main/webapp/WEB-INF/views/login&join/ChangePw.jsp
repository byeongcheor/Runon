<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<link rel="stylesheet" href="/css/login&join/ChangePw.css" type="text/css">
<script src="/js/login&join/ChangePw.js" type="text/javascript"></script>
<script>
    var username=`${username}`;
</script>
<div id="changePwForm" class="findIdFrm">
    <h1 class="findIdTop"><img src="/img/logo3.png"></h1>
    <h3 class="findIdMid">비밀번호 변경 </h3>
    <input type="password" id="newpw" placeholder="새로운 비밀번호를 입력해주세요">
    <input type="password" id="newpw2" placeholder="다시한번 입력해주세요">
    <button type="button" class="findBtn" onclick="changePw()">등록하기</button>
</div>

