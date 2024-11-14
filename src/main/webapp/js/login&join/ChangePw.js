function changePw(){
    /*alert(username);*/
    var newpw=document.getElementById("newpw").value;
    var newpw2=document.getElementById("newpw2").value;
    if(newpw==''){
        alert("비밀번호를 입력하세요.");
        return false;
    }
    if (newpw!=newpw2){
        alert("비밀번호와 재입력된 비밀번호가 다릅니다");
        return false;
    }

    console.log("아이디"+username+"비밀번호"+newpw+"두번째"+newpw2);
    $.ajax({
        url:"/login&join/updatepw",
        type:"post",
        data:{
            username:username,
            password:newpw,
        },success:function(r){
            alert("비밀번호가 재설정되었습니다");
            window.location.href="/";
        },error:function(e){
           /* console.log("예외"+e);*/
        }
    });
}