var username1
var usercode1
var ToKen
var clickInProgress = false;
$(window).on('scroll',function(){
    if($(window).scrollTop()){
        $('#header').addClass('active');
    }else{
        $('#header').removeClass('active');
    }
});
function openLoginPopup() {
    window.open('/login&join/loginForm', 'LoginPopup', 'width=700, height=525 ,left=1200, top=150');
}
window.onload=function(){
 ToKen=localStorage.getItem("Authorization");
    if (ToKen!=null &&ToKen!="" ){
        ToKen=ToKen.substring(7);
        document.getElementById("login").style.display="none";
    $.ajax({
        url:"/setToKengetUsers",
        type:"POST",
        data:{
            ToKen:ToKen
        },
        success:function(r){
           // alert("Test");
            // 유저정보 담기
            usercode1=r.mvo.usercode;
            username1=r.mvo.username;
           /* console.log(r.mvo.role);*/
            if (r.mvo.role!="ROLE_USER"){
                var tag="<a class=\"menus\" href=\"/adminPages/adminHome\">ADMIN</a>";
                document.getElementById("as").innerHTML=tag;
            }
            var mypagTag="";
            if (r.mvo!=null &&r.mvo!="") {
                mypagTag='<a class="menus" href="/mypage/myHome">MY</a>';
                document.getElementById("mypage").innerHTML=mypagTag;
            }
            var tags=`<a onclick="logout2()" style="color: #d1ff33">LOGOUT</a>`;
            document.getElementById("logout").innerHTML=tags;
        }

    });

    } else {
        var loginTag=`<a onclick="openLoginPopup()" style="color: #d1ff33">LOGIN</a>`;
        document.getElementById("login").innerHTML=loginTag;



    }

    //a 태그 클릭 이벤트 핸들러
    $('.menus').click(function (event) {
        event.preventDefault(); // 링크의 기본 동작 방지
        if (clickInProgress) return;
        clickInProgress = true;
        if($(this).attr("href")!=null){

        $.ajax({
            url: $(this).attr('href'),
            type: 'GET',
            success: function (response) {
                // 정상적으로 권한이 확인되면 페이지 이동

               /* console.log(response);*/
                window.location.href = $(event.currentTarget).attr('href');
            },
            complete: function () {
                clickInProgress = false; // AJAX 완료 후 클릭 가능 상태로 설정
            }

        });
        }// 테스트용으로 클릭 확인
    });

    $(document).one('click', '.menus', function (event) {
        event.preventDefault(); // 링크의 기본 동작 방지

        if ($(this).attr("href") != null) {

            $.ajax({
                url: $(this).attr('href'),
                type: 'GET',
                success: function (response) {

                    window.location.href = $(event.currentTarget).attr('href');
                }
            });
        }
    });
};
function mypagelogin(){
    alert("로그인하신후 접근가능합니다 ");
    window.open('/login&join/loginForm', 'LoginPopup', 'width=700, height=525 ,left=1200, top=150');

}

