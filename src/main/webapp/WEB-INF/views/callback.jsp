<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>

    const urlParams = new URLSearchParams(window.location.search);
    const token = urlParams.get('Authorization');
    const refreshToken = urlParams.get('refreshToken');

    // 로컬 스토리지에 저장
    localStorage.setItem("Authorization", token);
    localStorage.setItem("refresh", refreshToken);

    // 부모 창 새로고침 후 현재 창 닫기
    opener.window.location.reload();
    window.close();
</script>