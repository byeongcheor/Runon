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
        type: "post",
        url:"/login",
        data:{username:username,password:password },
        //success:function (response){
        success:function (response,status,xhr){
            alert("요청성공");
            const token = xhr.getResponseHeader("Authorization");
            const refreshToken = xhr.getResponseHeader('refreshToken');

            console.log(token);
            console.log(refreshToken);
            localStorage.setItem("refresh",refreshToken);
            localStorage.setItem("Authorization",token);

        },
        error:function (e){
            console.log(e);
            alert(e.message);
        }

    });

}
    function joinPopup(){
        $.ajax({
            type: "get",
           url:"/test",
            data: {username: "admin"},
            success:function (r){
               console.log("성공")

            }

        });
    }