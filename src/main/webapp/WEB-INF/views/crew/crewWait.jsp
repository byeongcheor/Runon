<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="${pageContext.request.contextPath}/js/crew.js" type="text/javascript"></script>
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
<link rel="stylesheet" href="/css/crewWait.css" type="text/css">

<div>
    <div id="bannerBox">
        <img src="/img/러닝고화질.jpg" id="bannerImg" />
    </div>
    <div class="content-body">
        <div class="content-full">
            <div class="join-container">
                <section class="menu-container">
                    <div class="menu-title">
                        <p class="menu-title-name"> 📝 가입 신청 내역</p>
                    </div>
                    <div class="menu-desc">
                        <p>14일 동안 팀에서 확인하지 않으면</p>
                        <p>자동으로 신청서가 취소돼요</p>
                    </div>
                </section>
                <section class="team-container">
                    <ul class="team-list" id='team_list'>
                    </ul>
                </section>
            </div>
        </div>
    </div>
</div>

<script>
var Authorization = localStorage.getItem("Authorization");


    $(document).ready(function() {
        crew_wait_select();
    });

function crew_wait_select(){
        var list ='';
        $.ajax({
            url: '/crew/crew_wait_select',
            type: 'post',
            async: false,
            data: {
                Authorization : Authorization,
            },
            success: function(response) {
                for (var i in response) {
                    var font_color = response[i].a_n > 1? "red":"blue";
                    list += '<li class="team-item" style="display: flex; justify-content: space-between; width: 100%;"> ';
                    list += '<a class="team-link" style="flex-grow: 1;"> ';
                    list += '<img src="/crew_upload/'+response[i].logo+'" class="team-emblem"> ';
                    list += '<div class="team-content"> ';
                    list += '<div style="display: flex; align-items: center;"> ';
                    list += '<span class="team-name" style="font-size: 18px; font-weight: bold;">'+response[i].crew_name+'</span> ';
                    list += '<span class="cancel-notice" style="font-size: 16px; color: '+font_color+'; margin-left: 10px;"> ';
                    if (response[i].a_n == 0) list += '승인을 기다리고있어요';
                    if (response[i].a_n == 1) list += '가입을 승인했어요 ';
                    if (response[i].a_n == 9) list += '팀에서 신청을 취소했어요 ';
                    list += '</span> ';
                    list += '</div> ';
                    list += '</div> ';
                    list += '</a> ';
                    list += '<div class="join-check-button" style="display: flex; justify-content: flex-end; align-items: center;"> ';
                    list += '<button type="submit" class="btn btn-outline-secondary" onClick="join_write_check()"> ';
                    list += '신청 확인 ';
                    list += '</button> ';
                    list += '</div> ';
                }   list += '</li> ';
                $('#team_list').append(list);

            },
            error: function(e) {
                console.error('Error: ', e);
            }
        });
    }
    function join_write_check(){
        clog('아기영선이!');
    }


</script>