<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    body{
        background-color: #F8FAFB;
    }
    #bannerBox{
        width:100%;
        height:200px;
        margin: 0 auto;
    }
    #bannerImg{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .body_container{
        background-color: white;
        width: 1024px;
        height: 900px;
        margin: 0 auto;
        border-radius: 10px 10px 0 0;
    }
    .page_title{
        font-size: 18pt;
        text-align: center;
        margin: 30px;
        font-weight: 500;
    }
</style>
<div id="bannerBox">
    <img src="/img/러닝고화질.jpg" id="bannerImg"/>
</div>
<div>
    <div class="page_title">마라톤신청서 작성</div>
    <div class="body_container">
        <form action="/submitMarathonForm" method="POST">
            <div>
                <label for="name">이름:</label>
                <input type="text" id="name" name="name" maxlength="30" required />
            </div>
            <div>
                <label for="tel">전화번호:</label>
                <input type="tel" id="tel" name="tel" maxlength="15" required />
            </div>
            <div>
                <label for="addr">주소:</label>
                <input type="text" id="addr" name="addr" maxlength="100" required />
            </div>
            <div>
                <label for="addr_details">상세 주소:</label>
                <input type="text" id="addr_details" name="addr_details" maxlength="300" required />
            </div>
            <div>
                <label for="gender">성별:</label>
                <select id="gender" name="gender" required>
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>
            <div>
                <label for="birth_date">생년월일:</label>
                <input type="date" id="birth_date" name="birth_date" required />
            </div>
            <div>
                <label for="size">사이즈:</label>
                <input type="text" id="size" name="size" maxlength="30" required />
            </div>
            <div>
                <label for="terms_agreement">이용약관 동의:</label>
                <input type="checkbox" id="terms_agreement" name="terms_agreement" required />
            </div>
            <div>
                <label for="privacy_consent">개인정보 수집 동의:</label>
                <input type="checkbox" id="privacy_consent" name="privacy_consent" required />
            </div>
            <div>
                <label for="media_consent">미디어 사용 동의:</label>
                <input type="checkbox" id="media_consent" name="media_consent" />
            </div>
            <div>
                <button type="submit">신청하기</button>
            </div>
        </form>
    </div>
</div>
