<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/css/login&join/JoinForm.css" type="text/css">
<script src="/js/login&join/JoinForm.js" type="text/javascript"></script>
<div class="joinFrm">
    <h1 class="loginTop"><img src="/img/logo3.png"></h1>
    <form method="post"  action="/joins" onsubmit="return formCheck()">
        <div class="joinMain">
            <div class="joinN">아이디<span>(이메일)</span></div>
            <div class="joinI">
                <input type="text" name="username" id="username" minlength="8" maxlength="30" placeholder="이메일 주소를 입력해 주십시오." onkeyup="setKeyCheck()" />
                <input type="button" id="idCheck" value="아이디중복검사" onclick="idDoubleCheck()"/>
                <input type="hidden" id="chk" value="N"><!-- N: 중복검사안함, Y 중복검사함 -->
            </div>
            <div class="joinN">비밀번호</div>
            <div class="joinI">
                <input type="password" name="password" id="password" minlength="8" maxlength="15" placeholder="비밀번호를 입력해주세요"/>
            </div>
            <div class="joinN">비밀번호확인</div>
            <div class="joinI">
                <input type="password" name="password2" id="password2" placeholder="비밀번호를 재입력해주세요"/>
            </div>
            <div class="joinN">이름</div>
            <div class="joinI">
                <input type="text" name="name" id="name" placeholder="이름을 입력해주세요"/>
                <input type="button" value=" 남 " id="genderm" onclick="gendercheck(this.value)"/>
                <input type="button" value=" 여 " id="genderw" onclick="gendercheck(this.value)"/>
                <input type="hidden" name="gender" id="gender" value=""/>
            </div>
            <div class="joinN">생년월일</div>
            <div class="joinI">
                <input type="text" name="birthdate" id="birthdate" placeholder="yyyymmdd형식으로 입력해주세요."/>
            </div>
            <div class="joinN">닉네임</div>
            <div class="joinI">
                <input type="text" name="nickname" id="nickname" onblur="nicknamecheck()" placeholder="닉네임을 입력해주세요."/>
                <input type="hidden" name="nickChk" id="nickChk" value="N">
            </div>
            <div id="nickCheck" style="font-size: 0.8em;"></div>
            <div class="joinN">연락처</div>
            <div class="joinT">
                <select name="tel1" id="tel1">
                    <option>010</option>
                    <option>02</option>
                    <option>031</option>
                    <option>051</option>
                </select> -
                <input type="text" name="tel2" id="tel2" size="4"  minlength="3" maxlength="4"/> -
                <input type="text" name="tel3" id="tel3" size="4" maxlength="4"/>
                <input type="hidden" name="tel" id="tel">
            </div>
            <div class="joinN">우편번호</div>
            <div class="joinZ">
                <input type="text" name="zip_code" id="zip_code" size="5" placeholder="우편번호를 입력해주세요"/>
                <input type="button" id="zipSearch" value="우편변호찾기" onclick="daumPostcode()"/>
            </div>
            <div class="joinN">주소</div>
            <div class="joinI">
                <input type="text" name="addr" id="addr" style="width:70%" placeholder="주소를 입력해주세요"/>
            </div>
            <div class="joinN">상세주소</div>
            <div class="joinI">
                <input type="text" name="addr_details" id="addr_details" placeholder="상세주소를 입력해주세요"/>
            </div>
            <div class="joinN info">개인정보 공개여부
                <div class="form-check">
                    <input type="radio" class="form-check-input" id="radio1" name="is_info_disclosure" value="Y" >공개
                    <label class="form-check-label" for="radio1"></label>
                </div>
                <div class="form-check">
                    <input type="radio" class="form-check-input" id="radio2" name="is_info_disclosure" value="N">비공개
                    <label class="form-check-label" for="radio2"></label>
                </div>
            </div>
            <input type="hidden" name="role" id="role" value="ROLE_USER">
            <div class="joinS">
                <input type="submit" value="회원가입" />
            </div>
        </div>
    </form>
</div>