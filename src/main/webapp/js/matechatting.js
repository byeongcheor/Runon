//전역변수
let socket;//socket객체
let stompClient; //stomp를 이용하여 서버와 메시지를 주고 받는다.
let nickname;//닉네임
$(function(){
    //이미 연결된 서버가 있으면 초기화
    disabledChat();
    //서버연결
    $("#connectBtn").click(function(){
        //닉네임이 있는지 확인
        if($("#nickname").val()==""){
            alert("닉네임을 입력후 서버에 연결하세요.");
            return;
        }
        nickname = $("#nickname").val();
        //채팅서버 연결
        chatConnection();
    });
    //서버로 메시지 보내기
    $("#inputMsg").keyup(function(){

        //enter인지 확인 13, 10
        if(event.keyCode == 13){
            if($("#inputMsg").val()==""){
                return false;
            }
            //입력한값이 있으면
            sendMessage(nickname, 'all', $("#inputMsg").val());
            $("#inputMsg").val(''); //메시지 초기화
        }
        //연결끊기
        $("#disconnectBtn").click(function(){
            //퇴장알리기
            sendMessage(nickname, 'all', nickname+"님이 퇴장하였습니다.");

            nickname=null; //닉네임
            //stompClient
            if(stompClient != null){
                stompClient.disconnect();
                stompClient = null;
                socket = null;//socket객체
            }
            $("#connectBtn").prop("disabled","false");
            //뷰페이지 지우기
            disabledChat();
        });
    });
});//jquery

//채팅서버에 연결하기 -------------------------
function chatConnection(){
    //1. 서버연결
    socket = new SockJS("/chat");

    //2. socket객체를 이용하여 stomp객체를 생성
    stompClient = Stomp.over(socket);

    //3. stompClient의 메소드를 이용하여 서버와 통신한다.
    stompClient.connect({},function(frame){
        console.log('frame->',frame);
        console.log("----------------------------");
        //서버와 채팅서버연결하기, 닉네임입력 비활성화
        //연결상태, 채팅대화내용 보여주기
        setConnected();

        //다른접속자에게 접속자 알려주기 - 서버로 정보보내기
        //             누가, 누구에게, 무엇을
        sendMessage(nickname, 'all', nickname+"님이 접속하였습니다.");
        //서버에서 보낸정보 받기
        stompClient.subscribe("/topic/messages", function(receiveMsg){
            console.log('receiveMsg->',receiveMsg);
            //json을 문자열로 받아 json객체로 변환
            var jsonMsg = JSON.parse(receiveMsg.body);
            showCatMessage(jsonMsg);
        });
    });



}
//서버와 채팅서버연결하기, 닉네임입력 비활성화
//연결상태, 채팅대화내용 보여주기
function setConnected(){
    $("#connected").prop('disabled', true); //채팅연결하기 비활성화 attr() : 속성과 속성값, prop(): 속성과 속성값:true,
    $("#nickname").prop('disabled',true);//닉네임 비활성화
    $("#status").html(nickname+"님이 접속하였습니다.");//연결상태알림
    $("#showChat").css("display","block");//채팅대화내용 보여주기
}
//서버로 정보 보내기
function sendMessage(from, to, msg){
    //"{key:value, key:value,,,}"
    //서버로 보낼 데이터를  json으로 만들기
    let str = {
        from : from,
        to : to,
        msg : msg
    }
    // 클라이언트가 서버로 메시지 보내기
    //                    받는쪽주소    데이터
    stompClient.debug = null;
    stompClient.send("/message/chat",{},JSON.stringify(str));
}
function showCatMessage(data){//from,to,msg,datetime
    var tag = ``;
    //내가 보낸경우
    if(data.from==nickname){
        tag += `<div style="text-align:right; padding:10px;">
                        <span class="badge bg-success">`+data.from+`</span><br/>
                        <span class="rounded" style="background:#fff; padding:5px;">`+data.msg+`</span>
                        <div style="font-size:0.8em; color:gray">`+data.datetime+`</div>
                    </div>`;
    }else{ //상대방이 보낸경우
        tag += `<div style="text-align:left; padding:10px;">
                        <span class="badge bg-danger">`+data.from+`</span><br/>
                        <span class="rounded" style="background:#fff; padding:5px; ">`+data.msg+`</span>
                        <div style="font-size:0.8em; color:orange">`+data.datetime+`</div>
                    </div>`;
    }
    $("#taMsg").append(tag);
    //스크롤바 이동
    document.getElementById("taMsg").scrollTop=document.getElementById("taMsg").scrollHeight;



}
function disabledChat(){
    $("#nickname").val("");
    $("#status").html("연결후 채팅하세요....");
    $("#inputMsg").val("");
    $("#taMsg").html("");
    $("#showChat").css("display","none");
}