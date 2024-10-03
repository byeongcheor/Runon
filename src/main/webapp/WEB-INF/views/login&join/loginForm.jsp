<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/loginForm.css" type="text/css">

<script src="../js/loginForm.js" type="text/javascript"></script>
    <div class="loginFrm">
        <h1 class="loginTop"><a href="/"><img src="/img/logo3.png"></a></h1>
        <form onsubmit="return formCheck(event)">
            <input type="text" name="username" id="username" placeholder="아이디 입력" />
            <input type="password" name="password" id="password" placeholder="비밀번호 입력"/>
            <input type="submit" class="loginbtn" value="로그인" />
        </form>
    <div class='find'>
        <a onclick="joinPopup()">회원가입</a>/<a onclick="findIdPopup()">아이디찾기</a>/<a onclick="findPwdPopup()">비밀번호찾기</a>
    </div>
</div>