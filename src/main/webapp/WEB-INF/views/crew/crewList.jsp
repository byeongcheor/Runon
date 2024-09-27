<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    #crew_body{
        width: 60%;
        margin: 0 auto;
    }

    #bannerBox{
        width:100%;
        height:400px;
        margin: 0 auto;
    }
    #bannerImg{
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    #crew_nav{
        height:100px;
    }
    #crew_nav ul, #crew_nav li{
        float:left;
        list-style: none;
    }
    #crew_nav li{
        font-size: 18pt;
        color:grey;
        margin: 20px;
    }
    #crew_nav li:hover{
        color: black;
        font-size: 18pt;
    }
</style>
    <div class="container">
        <div id="bannerBox">
            <img src="/img/크루배너.jpg" id="bannerImg"/>
        </div>
        <div id="crew_body">
            <div id="crew_nav">
                <ul>
                    <li>크루모집</li>
                    <li>크루생성</li>
                    <li>나의크루</li>
                </ul>
            </div>
        </div>

    </div>
