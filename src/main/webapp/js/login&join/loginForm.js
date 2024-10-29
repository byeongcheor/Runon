function formCheck(event){
    event.preventDefault();
    const username = $('#username').val();
    const password = $('#password').val();
    //id
    if(username==""){
        alert("아이디를 입력하세요.");
        return false;
    }
    //password
    if(password==""){
        alert("비밀번호를 입력하세요.");
        return false;

    }
   /* $.ajax({
        url:"/login&join/userCheck",
        typ:"post",
        data:{
            username:username,
            password:password,
        },
        success:function(r){

        }
    })*/
        $.ajax({
            url:"/login&join/disableCheck",
            type:"post",
            data:{
                username:username,
                password:password,
            },
            success:function (r){

                if(r.result!=0){
                    $.ajax({
                        type: "post",
                        url:"/login",
                        data:{username:username,password:password },
                        //success:function (response){
                        success:function (response,status,xhr){
                            const token = xhr.getResponseHeader("Authorization");
                            const refreshToken = xhr.getResponseHeader('refreshToken');
                            localStorage.setItem("refresh",refreshToken);
                            localStorage.setItem("Authorization",token);


                            opener.window.location.reload();
                            window.close();
                                if (window.opener) {
                        const parentUrl = window.opener.location.href;
                        const parentFileName = parentUrl.substring(parentUrl.lastIndexOf('/') + 1);
                        console.log(parentFileName);
                        if(parentFileName=='crewList')crew();
                    }
                        },
                        error:function (e){
                            alert("아이디혹은 비밀번호가 틀렸습니다");
                        }

                    });

                }else if(r.result==0) {

                    alert("아이디가 정지되었습니다.\n시작일:"+r.disabled_start_date+"\n정지기한:"+r.disabled_date+"까지입니다.\n 문의사항이  있으시면  ictfinal@naver.com으로 문의주세요");
                }


            },
            error:function (e){

               /* console.log(e.message);*/
            }
        });




}
function joinPopup() {
    const popup = window.open('/JoinForm', 'JoinForm', 'width=600,height=980,left=1200,top=150,resizable=yes');
    if (popup) {
        popup.resizeTo(600, 980);
    }
}
function findIdPopup(){
    window.open('/login&join/FindId', 'FindIdPopup', 'width=465, height=525 ,left=1200, top=150');
}
function findPwdPopup(){
    window.open('/login&join/FindPw', 'FindIdPopup', 'width=465, height=525 ,left=1200, top=150');
}

function crew() {
    var Authorization=localStorage.getItem("Authorization");
    if(Authorization===null)Authorization='A';
    $.ajax({
        url: "/crew/go_crew", // 원하는 URL을 지정
        type: "post",
        data: { Authorization:Authorization },
        success: function (r) {
            window.location.href = '/crew/crewList';
        }
    });
}