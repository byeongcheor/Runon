var username1
var usercode1
var ToKen
window.onload=function(){

}
$(window).on('scroll',function(){


    if($(window).scrollTop()){
        $('#header').addClass('active');
    }else{
        $('#header').removeClass('active');
    }
});
function openLoginPopup() {
    window.open('/login&join/loginForm', 'LoginPopup', 'width=465, height=525 ,left=1200, top=150');
}
$(document).ready(function() {
    ToKen=localStorage.getItem("Authorization");
    if (ToKen!=null &&ToKen!="" ){
        ToKen=ToKen.substring(7);}
    $.ajax({
        url:"/setToKengetUsers",
        type:"POST",
        data:{
            ToKen:ToKen
        },
        success:function(r){
            // 유저정보 담기
            usercode1=r.mvo.usercode;
            username1=r.mvo.username;

        }

    });




    // a 태그 클릭 이벤트 핸들러
    $('.memus').click(function (event) {
        event.preventDefault(); // 링크의 기본 동작 방지
        alert($(this).attr("href"));
        if($(this).attr("href")!=null){
            alert("넘어가기전");
        $.ajax({
            url: $(this).attr('href'),
            type: 'GET',
            success: function (response) {
                // 정상적으로 권한이 확인되면 페이지 이동
                alert("링크넘어가기!");
                console.log(response);
                window.location.href = $(event.currentTarget).attr('href');
            },error:function (e){
                console.error(e);
            }

        });
        }// 테스트용으로 클릭 확인
    });

    $(document).on('click', '.menus', function (event) {
        event.preventDefault(); // 링크의 기본 동작 방지
        alert($(this).attr("href"));
        if ($(this).attr("href") != null) {
            alert("넘어가기전");
            $.ajax({
                url: $(this).attr('href'),
                type: 'GET',
                success: function (response) {
                    // 정상적으로 권한이 확인되면 페이지 이동
                    alert("링크넘어가기!");
                    console.log(response);
                    window.location.href = $(event.currentTarget).attr('href');
                },
                error: function (e) {
                    console.error(e);
                }
            });
        }
    });
});
