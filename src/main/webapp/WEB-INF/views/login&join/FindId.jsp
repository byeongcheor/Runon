<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
</script>
<link rel="stylesheet" href="/css/login&join/FindId.css" type="text/css">
<script src="/js/login&join/FindId.js" type="text/javascript"></script>


<div class="findIdFrm">
    <h1 class="FindIdTop"><a>아이디찾기</a></h1>
        <input type="text" name="name" id="name" placeholder="이름 입력" />
        <input type="text" name="tel" id="tel" placeholder="핸드폰번호:010-0000-0000형식으로 입력"/>
        <input type="button" id="FindId" onclick="FindIds2()" value="아이디찾기" />
    <div class='find'>

        <div id="radiobuttons">

        </div>

    </div>
</div>




