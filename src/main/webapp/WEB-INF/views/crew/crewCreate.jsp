<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
      crossorigin="anonymous"
    />
<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
      crossorigin="anonymous"
    ></script>
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
     <!-- Button to Open the Modal -->
     <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
       Open modal
     </button>

     <!-- The Modal -->
     <div class="modal" id="myModal">
       <div class="modal-dialog">
         <div class="modal-content">

           <!-- Modal Header -->
           <div class="modal-header">
             <h4 class="modal-title">Modal Heading</h4>
             <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
           </div>

           <!-- Modal body -->
           <div class="modal-body">
             Modal body..
           </div>

           <!-- Modal footer -->
           <div class="modal-footer">
             <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
           </div>

         </div>
       </div>
     </div>
</div>