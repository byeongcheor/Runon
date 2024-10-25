
//닉네임 중복여부검사(db)
function nicknamecheck(){
    var nickname=document.getElementById("nickname").value;
    if (nickname!=""&&nickname!=null){
        $.ajax({
            url:"/nickCheck",
            data:{
                nickname:nickname
            },
            success:function (r){
                if (r==0){
                    var nickname= document.getElementById("nickCheck");

                    nickname.style.color="green"
                    tag="닉네임 사용가능합니다";
                    nickname.innerText=tag;
                    document.getElementById("nickChk").value="Y";

                }else {
                    tag="닉네임을 이미 사용중입니다";
                    document.getElementById("nickCheck").style.color="red"
                    document.getElementById("nickChk").value="N";
                    document.getElementById("nickCheck").innerText=tag;
                }
            },
            error:function(e){
                console.log("예외발생:",e);
            }


        });
    }
    document.getElementById("nickCheck").style.color="red";
    document.getElementById("nickCheck").innerText="닉네임을 입력해주세요";

}

//주소api사용해 주소입력
function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {

            var addr = '';
            var extraAddr = '';


            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            if(data.userSelectedType === 'R'){

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }

                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                extraAddr = ' (' + extraAddr + ')';

            } else {

            }
            document.getElementById("zip_code").value = data.zonecode;
            document.getElementById("addr").value = addr;
            document.getElementById("addr_details").focus();
        }
    }).open();
}
//아이디 중복검사
function idDoubleCheck(){
    document.getElementById("username").readOnly=false;
    var username=document.getElementById("username").value;
    const regExpUsername = /^\w{4,12}[@][A-Za-z]{2,8}[.][A-Za-z]{2,3}([.][A-Za-z]{2,3})?$/;
    if(document.getElementById("username").value==""){//아이디를 입력하지않았을때
        alert("아이디를 입력후 중복검사하세요.");
        document.getElementById("username").focus();
        return false;

    }
    else if (!regExpUsername.test(username)) {
        alert( "아이디를 이메일로 입력해주세요");
        return false;
    }

    else{//아이디를 입력했을때
        var username = document.getElementById("username").value;
        //           "매핑주소?username=ddd"                          창이름       옵션
        window.open("/idDoubleCheck?username="+username, "idCheck","width=460, height=300, left=700,top=100,resizable=no");
    }
}

function setKeyCheck(){
    if (!opener.document.getElementById("username").readOnly) {
        document.getElementById("chk").value = "N";
    }
}

//form 유효성검사하기
function formCheck(){
    var tel1=document.getElementById("tel1").value;
    var tel2=document.getElementById("tel2").value;
    var tel3=document.getElementById("tel3").value
    if (tel2.length!=4||tel3.length!=4){
        alert("핸드폰번호를 제대로 입력해주세요");
        return false;
    }
    if (tel2 !=""&&tel2!=null&&tel3 !=""&&tel3!=null) {
        var tel = tel1+tel2+tel3;
        document.getElementById("tel").value = tel;
    }else{
        document.getElementById("tel").value=null;
        alert("핸드폰번호를 입력해주세요");
        return false;
    }


    if(document.getElementById("username").value == ''){
        alert("아이디를 입력하세요.");
        return false;
    }
    if(document.getElementById("chk").value!='Y'){
        alert("아이디 중복검사를 하세요.")
        return false;
    }
    //비밀번호
    if(document.getElementById("password").value==''){
        alert("비밀번호를 입력하세요.");
        return false;
    }
    if(document.getElementById("password").value!=document.getElementById("password2").value){
        alert("비밀번호가 다릅니다.");
        return false;
    }
    if( document.getElementById("gender").value==""){
        alert("성별을 골라주세요");
        return false;
    }
    if(document.getElementById("nickChk").value!="Y"){
        alert("이미 사용인 닉네임이거나 닉네임을 입력해주세요");
        return false;
    }
    if (document.getElementById("addr").value==""){
        alert("주소를 입력해주세요");
        return false;
    }
    if (document.getElementById("addr_details").value==""){
        alert("상세주소를 입력해주세요");
        return false;
    }
    if (document.getElementById("zip_code").value==""){
        alert("우편번호를 입력해주세요");
        return false;
    }
    const selectedValue = document.querySelector('input[name="is_info_disclosure"]:checked');
    if (!selectedValue){
        alert("개인정보 공개여부를 선택해주세요.");
        return false;
    }

        //이름
        var name = document.getElementById("name").value;
    var regEx = /^[가-힣]{2,15}$/;
    var username = document.getElementById("username").value;

    if(!regEx.test(name)){
        alert("이름을 잘못입력하였습니다.");
        return false;
    }
    var birthdate = document.getElementById("birthdate").value;

    var brrthregEx=/^(\d{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/;
    if (!brrthregEx.test(birthdate)){
        alert("생년월일이 잘못되었습니다.");
        return false;
    }
    return true;
}
function gendercheck(gender){

    if (gender==" 남 "){
        document.getElementById("genderm").style.background="#FFA500";
        document.getElementById("genderw").style.background="#FFCC66";
        document.getElementById("gender").value="남";
    }else if (gender==" 여 "){
        document.getElementById("genderw").style.background="#FFA500";
        document.getElementById("genderm").style.background="#FFCC66";
        document.getElementById("gender").value="여";
    }

}
