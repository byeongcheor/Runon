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
            console.log(usernames);
            if (usernames!=null&&usernames!=""){
                var tag=" <ul>";
                usernames.forEach(function(usernames,index){
                    tag+=`
                    <div><input type="radio" id="`+index+`" name="point" value="`+usernames.username+`" />
                    <label class="form_label" for="`+index+`">`+usernames.username+`</label></div>
                    `;
                });
                tag+="  <input type=\"button\" onclick=\"findpw()\" value=\"비밀번호찾기\"> </ul>";
                document.getElementById("radiobuttons").innerHTML=tag;

            }else{
                var tag="<h1>가입된 아이디가 없습니다.</h1>";
                document.getElementById("radiobuttons").innerHTML=tag;
            }

            },
        error:function(e){
            console.log("예외발생",e);
        }

    });

}

function findpw(){
    const selectedRadio = document.querySelector('input[name="point"]:checked');
    if (selectedRadio) {
        alert("선택된 값은: " + selectedRadio.value);
        const selectedValue = selectedRadio.value;
        $.ajax({
            url:"/login&join/changePw",
            type:"post",
            data: {
                selectedRadio:selectedValue
            },
            success:function(r){
                var token=r.token;
                console.log(token);
            }
        });
    } else {
        alert("선택된 값이 없습니다.");
    }


}
