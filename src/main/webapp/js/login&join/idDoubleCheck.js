var r="";
var username;
function idCheck(){
     username=document.getElementById("username").value;
    const regExpUsername = /^\w{4,12}[@][A-Za-z]{2,8}[.][A-Za-z]{2,3}([.][A-Za-z]{2,3})?$/;
    if(document.getElementById('username').value==""){
        alert("아이디를 입력후 중복검사하세요.");
        document.getElementById("username").focus();
        return false;
    } else if (!regExpUsername.test(username)) {
        alert( "아이디를 이메일로 입력해주세요");
        return false;
    }

    return true;
}
function setUserid(){
    if($("#hiddenbox").css("display")=="none") {
        $("#hiddenbox").css("display", "block");
    }else {
        $("#hiddenbox").css("display", "none");
    }

}
function emailauthentication(){
    var button = document.getElementById("sendButton");
    button.disabled = true; // 버튼 비활성화
    button.value = "60초후 재시도";

    var timeLeft = 60;
    var countdown = setInterval(function() {
        timeLeft--;
        button.value = timeLeft + "초후 재시도";

        if (timeLeft <= 0) {
            clearInterval(countdown); // 타이머 중지
            button.disabled = false; // 버튼 활성화
            button.value = "인증번호받기"; // 원래 버튼 값으로 변경
        }
    }, 1000);
    let characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    let length = 6; // 6자리

    for (var i = 0; i < length; i++) {
        var randomIndex = Math.floor(Math.random() * characters.length);
        result += characters[randomIndex];
    }r=result
    console.log(result);
    //opener인 join.jsp에 있는 userid필드의 값을 셋팅
    emailjs.send('gmail', 'template_nqlgrpr', {
        to_name: username,
        message: result
    })
        .then(function(response) {
            console.log('SUCCESS!', response.status, response.text);
        }, function(error) {
            console.log('FAILED...', error);
        });
    if($("#hiddenbox2").css("display")=="none") {
        $("#hiddenbox2").css("display", "block");
    }


}
function useemail(){
    if ($("#emailcode").val() !="" &&$("#emailcode").val() ==r){
        opener.document.getElementById("chk").value='Y';
        opener.document.getElementById("username").readOnly=true;
        opener.document.getElementById("username").value= username; // 배경색 설정


        self.close(); //window.close();
    }else {
        alert("유효한번호가 아닙니다");
        return false;
    }
}
window.onload = function() {
    emailjs.init("tC4QTbGfMO5fEZx63");
    window.resizeTo(460, 300);
    window.addEventListener('resize', function() {
        window.resizeTo(460, 300);  // 창 크기를 다시 강제로 고정
    });// 올바른 User ID로 초기화
};