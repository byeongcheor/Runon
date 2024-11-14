function FindIds2(){
    event.preventDefault();
    var name=document.getElementById("name").value;
    var tel=document.getElementById("tel").value;
    if (name==null||name==""){
        alert("이름을 입력해주세요");
        return false;
    }
    if (tel==null||tel==""){
        alert("핸드폰번호를 010-0000-0000형식으로 입력해주세요");
        return false;
    }
    if(tel.length!="010-0000-0000".length){
        alert("핸드폰번호를 잘못입력하였습니다");
        alert("010-0000-0000".length);
        alert(tel.length);
        return false;
    }

    $.ajax({
        url:"/login&join/findId",
        type:"post",
        data:{
            name:name,
            tel:tel
        },
        success:function(r){
            var usernames=r.usernames;
            /*console.log(usernames);*/
            if (usernames!=null&&usernames!=""){
                var tag=" <ul class=radiobuttons_box>";
                usernames.forEach(function(usernames,index){
                    tag+=`
                    <div><input type="radio" id="`+index+`" name="point" value="`+usernames.username+`" />
                    <label class="findID" for="`+index+`">`+usernames.username+`</label></div>
                    `;
                });
                 tag+=" </ul>";
                tag+="  <input type=\"button\" class=\"findBtn\" onclick=\"findpw()\" value=\"비밀번호찾기\"> ";
                document.getElementById("radiobuttons").innerHTML=tag;

            }else{
                var tag="<h3 class=\"findID\">가입된 아이디가 없습니다.</h3>";
                document.getElementById("radiobuttons").innerHTML=tag;
            }

            },
        error:function(e){
          /*  console.log("예외발생",e);*/
        }

    });

}

function findpw(){
    emailjs.init("tC4QTbGfMO5fEZx63");
    const selectedRadio = document.querySelector('input[name="point"]:checked');
    if (selectedRadio) {
        const selectedValue = selectedRadio.value;
        $.ajax({
            url:"/login&join/changePw",
            type:"post",
            data: {
                username:selectedValue
            },
            success:function(r){
                var token=r.token;

                var username= selectedValue;
                var url="http://192.168.1.154:7942/loginjoin/changepw/"+token;
                console.log(url);
                emailjs.send('gmail',"template_2msjhhl", {
                    to_name:username,
                    message:url
                })   .then(function(response) {
                    alert("비밀번호 재설정 url이 발송되었습니다, 이메일을 확인해주세요. ")
                }, function(error) {

                });
            }
        });
    } else {
        alert("선택된 아이디가 없습니다.");
    }


}
