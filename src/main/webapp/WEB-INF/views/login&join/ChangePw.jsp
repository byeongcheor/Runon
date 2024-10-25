<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<link rel="stylesheet" href="/css/login&join/ChangePw.css" type="text/css">
<script src="/js/login&join/ChangePw.js" type="text/javascript"></script>
<script>
    var username=`${username}`;
</script>
<div id="changePwForm">


        <div class="oneline"><div> 비밀번호 입력:</div><input type="password" id="newpw" placeholder="새로운 비밀번호를 입력해주세요"></div>
        <div class="oneline"><div>비밀번호 재입력:</div><input type="password" id="newpw2" placeholder="다시한번 입력해주세요"></div>
            <button type="button" onclick="changePw()">등록하기</button>




</div>