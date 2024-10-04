<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
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
    #crew_nav li a{
        text-decoration: none;
        color: black;
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
    #crew_body{
        width: 50%;
        margin: 0 auto;
    }
</style>
<div>
     <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg"/>
     </div>
     <div id="crew_body">
         <div id="crew_nav">
             <ul>
                 <li><a href="/crew/crewList">크루모집</a></li>
                 <li><a href="/crew/crewCreate">크루생성</a></li>
                 <li><a href="/crew/crewManage">나의크루</a></li>
             </ul>
         </div>
     </div>
</div>