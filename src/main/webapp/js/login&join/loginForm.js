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


                        window.close();
                        opener.window.location.reload();
                    },
                    error:function (e){
                        console.log(e);
                        alert(e.message);
                    }

                });

            }else if(r.result==0) {

                alert("아이디가 정지되었습니다.\n시작일:"+r.disabled_start_date+"\n정지기한:"+r.disabled_date+"까지입니다.");
            }


        },
        error:function (e){

            console.log(e.message);
        }
    });


}
    function joinPopup(){
        window.open('/JoinForm', 'JoinForm', 'width=600, height=850 ,left=1200, top=150');


    }