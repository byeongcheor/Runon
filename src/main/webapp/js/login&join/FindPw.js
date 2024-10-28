function FindPws2(){
    var name=document.getElementById("name").value;
    var username=document.getElementById("username").value;
    if (name==null||name==""){
        alert("이름을 입력해주세요");
        return false;
    }
    if (username==null||username==""){
        alert("아이디를 입력해주세요");
        return false;
    }
    const regExpUsername = /^\w{4,12}[@][A-Za-z]{2,8}[.][A-Za-z]{2,3}([.][A-Za-z]{2,3})?$/;
    if(document.getElementById("username").value==""){//아이디를 입력하지않았을때
        alert("아이디를 입력후 찾기를 해주세요.");
        document.getElementById("username").focus();
        return false;

    }
    $.ajax({
        url:"/login&join/FindPwd",
        type:"post",
        data:{
            name:name,
            username:username
        },
        success:function(r){
            console.log(r.mvo);
            if (r.mvo!=null&&r.mvo!=""){
                findpw(r.mvo.username)
            }else{
                var tag="<h1>입력하신 정보와 일치하는 아이디가 없습니다.</h1>";
                document.getElementById("alerts").innerHTML=tag;
            }

        },
        error:function(e){
          /*  console.log("예외발생",e);*/
        }

    });

}
function findpw(username){
    emailjs.init("tC4QTbGfMO5fEZx63");

    if (username) {
        $.ajax({
            url:"/login&join/changePw",
            type:"post",
            data: {
                username:username
            },
            success:function(r){
                var token=r.token;
                /*console.log(token);*/
                var url="http://192.168.1.154:7942/loginjoin/changepw/"+token;
               /* console.log(url);*/
                          emailjs.send('gmail',"template_2msjhhl", {
                              to_name:username,
                              message:url
                          })   .then(function(response) {
                              console.log('SUCCESS!', response.status, response.text);
                          }, function(error) {
                              console.log('FAILED...', error);
                          });
                alert("이메일을 확인해주세요.");

            }
        });
       /* window.close();*/
    }


}