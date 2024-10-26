<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
</script>
<link rel="stylesheet" href="/css/login&join/FindPw.css" type="text/css">
<script src="/js/login&join/FindPw.js" type="text/javascript"></script>

<div class="findPwFrm">
    <h1 class="FindPwTop"><a>비밀번호 재설정</a></h1>
    <input type="text" name="username" id="username" placeholder="아이디 입력해주세요" />
    <input type="text" name="name" id="name" placeholder="성함을 입력해주세요"/>
    <input type="button" id="FindPw" onclick="FindPws2()" value="비밀번호 재설정"/>
</div>
<div id="alerts">

</div>
