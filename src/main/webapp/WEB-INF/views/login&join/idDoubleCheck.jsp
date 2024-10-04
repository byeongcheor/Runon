<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
</script>
<script src="/js/login&join/idDoubleCheck.js" type="text/javascript"></script>
<link rel="stylesheet" href="/css/login&join/idDoubleCheck.css" type="text/css">
<script>
    var username="${username}";
</script>
<div class="idCheck1">
    <!-- 아이디 중복 검사 한 결과 -->
    <!-- 사용가능한 아이디 -->
    <c:if test="${result==0 }">
        <b>${username }</b>는 사용가능한 아이디 입니다.
        <input type= "button" value="사용하기" onclick="setUserid()"/>
        <div id="hiddenbox">

            <input type="button" id="sendButton" value="인증번호받기" onclick="emailauthentication()">
        </div>
        <div id="hiddenbox2">
            <form method="get" onsubmit="return useemail()" >
                <input type="text" id="emailcode">
                <input type="submit" value="인증번호확인">
            </form>

        </div>

    </c:if>
    <!-- 사용불가능한 아이디 -->
    <c:if test="${result>0}">
        <div style='color:red'>${username}는 사용중 혹은 사용불가능한 아이디입니다</div>
    </c:if>
    <hr/>
    <!-- 새로운 아이디 중복검사 폼을 만들기-->
    <div class="idCheck2">
        <form method="get" action="/idDoubleCheck" onsubmit="return idCheck()">
            아이디 입력 : <input type="text" name="username" id="username"/>
            <input type="submit" value="아이디중복검사하기"/>
        </form>
    </div>
</div>
