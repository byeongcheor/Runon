<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/chatList.css" type="text/css">
<!-- 채팅창 영역 -->
<c:forEach var="uvo" items="${userselect}"><!--유저 정보 가져오기 아이디값은 무조건 줘야 된다.-->
	<input type='hidden' id=usercode value=${uvo.usercode}>
	<input type='hidden' id=nickname value=${uvo.nickname}>
</c:forEach>

<div id="chatbox" >
	<div class="chatbox-header">
		<button id="closeChatBtn" class="close-chat-btn">×</button>
		<img src="/img/bell.png"
			 alt="신고"
			 class="bell-icon"
			 onmouseover="this.src='/img/bell2.png';"
			 onmouseout="this.src='/img/bell.png';"
			 onclick="toggleCheckBoxes()">
	</div>
	<!-- 대화내용 -->
	<div id="taMsg">
		<!-- 여기에 메시지들이 표시됩니다 -->
	</div>
	<!-- 메시지입력 -->

	<div class="chat-input">
		<input type="text" id="inputMsg" placeholder="채팅을 입력해 주세요">
		<button id="sendBtn">전송</button>
		<button id="reportBtn" style="display: none;" onclick="reportMessages()">신고하기</button>
	</div>
</div>
<!--채팅방 리스트 영역-->
<div id="chatList" class="chat-list hidden">
	<!-- 메이트 방 -->
	<div class="chat-item mate-item" id="mateChatButton">
		<img src="/img/man0.png" alt="메이트 이미지" class="chat-img">
		<div id="mate_chat" class="chat-info">
			<div class="chat-text">메이트 채팅방</div>
			<div class="chat-date">2024-10-13</div>
		</div>
	</div>

	<!-- 크루 방 리스트 -->

	<c:forEach var="crewchat" items="${chatList}">
		<div class="chat-item">
			<img src="/crew_upload/${crewchat.logo}" alt="${crewchat.crew_name} 이미지" class="chat-img">
			<div class="chat-info">
				<div class="chat-text">${crewchat.crew_name}</div>
				<div class="chat-date">2024-10-12</div> <!-- 크루 생성일 또는 방 생성일 -->
			</div>
		</div>
	</c:forEach>
</div>
<!-- 더 많은 크루들 추가 -->
<!-- 신고하기 모달 -->
<div id="reportModal" class="ChatReportModal">
	<div class="ChatReport_modal-content">
		<span class="chatModalClose" id="chatCloseModal">&times;</span>
		<h1 class="reportT">신고하기</h1>
		<div id="reportUserInfo">
			<p>피해자 유저코드: <span id="victimUserCode"></span></p>
			<p>피해자 닉네임: <span id="victimNickname"></span></p>
			<p>메이트 채팅방 코드: <span id="matchingRoomCode"></span></p>
		</div>
		<div id="selectedMessages">
			<h1>선택한 메시지:</h1>
			<textarea id="messageList" rows="3" cols="35" ></textarea>
		</div>
		<div>
			<label for="reportReason" class="reportR">신고 사유:</label><br/>
			<textarea id="reportReason" placeholder="신고 사유를 입력해 주세요" rows="3" cols="35"></textarea>
		</div>
		<div class="reportButton-container">
			<button id="submitReportBtn" class="report-btn">신고접수</button>
		</div>
	</div>
</div>


<script>
	var usercode=$('#usercode').val();
	var token = localStorage.getItem("Authorization");
	var match_yn="${vo.match_yn}";
	var nickname=$('#nickname').val();
	let socket; // socket 객체
	let stompClient; // stomp를 이용하여 서버와 메시지를 주고 받는다.


	//채팅연결공통

	$(document).ready(function() {

		if (!match_yn || match_yn === "undefined") {
			let storedRoomCode = localStorage.getItem("matchedRoomCode");
			if (storedRoomCode && storedRoomCode !== "undefined") {
				match_yn = storedRoomCode;
			} else {
				console.warn("저장된 방 코드가 없습니다.");
				return; // 방 코드가 없으면 종료
			}
		} else {
			// 방 코드가 있을 경우, 로컬 저장소에 저장
			localStorage.setItem("matchedRoomCode", match_yn);
		}

		// 로컬 저장소에서 닉네임을 가져옴
		let nickname = localStorage.getItem("userNickname");
		console.log("로컬 저장소에서 가져온 닉네임:", nickname); // 닉네임 확인용

// 닉네임이 없거나 "undefined"인 경우 hidden 필드에서 가져오기
		if (!nickname || nickname === "undefined") {
			nickname = $('#nickname').val(); // hidden 필드에서 닉네임 가져오기
			console.log("닉네임 필드에서 가져온 값:", nickname); // 닉네임 필드 값 확인

			// 닉네임이 유효한 경우 로컬 저장소에 저장
			if (nickname) {
				localStorage.setItem("userNickname", nickname);
				console.log("닉네임이 로컬 저장소에 저장되었습니다:", nickname);
			} else {
				console.warn("닉네임을 가져오지 못했습니다.");
			}
		}

// 최종적으로 확인할 닉네임
		console.log("최종 닉네임:", nickname);
		console.log("유효한 방 코드: ", match_yn);


		// 채팅 서버 연결하기
		chatConnection();
		// 이전 채팅 내역 불러오기
		loadChatMessages();


		// 서버로 메시지 보내기 (Enter 키)
		$("#inputMsg").keyup(function(event) {
			if (event.keyCode === 13) {
				sendMessageFromInput();
			}
		});

		// 서버로 메시지 보내기 (전송 버튼)
		$("#sendBtn").click(function() {
			sendMessageFromInput();
		});
	});


	// 채팅 서버와 연결하는 함수
	function chatConnection() {

		if (!usercode || !nickname) {
			console.error("usercode 또는 nickname을 가져올 수 없습니다.");
			return;
		}
		// 매칭 방 코드가 0일 경우 채팅 연결 차단
		if (match_yn === 0) {
			console.warn("매칭을 완료한 후 채팅을 이용할 수 있습니다.");
			alert("매칭을 완료한 후 채팅을 이용할 수 있습니다.");
			return; // 채팅 연결을 막음
		}

		console.log("매칭 방 코드: ", match_yn);
		socket = new SockJS("/chat"); // WebSocket 엔드포인트와 연결
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('WebSocket 연결 성공:', frame);

			console.log(usercode, nickname);


			// 방 코드에 따라 구독 경로 설정
			stompClient.subscribe("/topic/messages/"+match_yn, function(receiveMsg) {
				console.log('receiveMsg->',receiveMsg);
				var jsonMsg = JSON.parse(receiveMsg.body);
				console.log("서버에서 수신한 메시지:", jsonMsg); // 수신한 메시지 확인
				showCatMessage(jsonMsg);
			});
			// 서버로 메시지 전송 (닉네임 접속 알림)
			sendMessage(usercode, nickname, match_yn, nickname + "님이 접속하였습니다.");

			// 방 코드가 새로 설정되었을 때 localStorage에 저장
			localStorage.setItem("matchedRoomCode", match_yn);
		});
	}



	// 메시지를 입력창에서 가져와 서버로 전송하는 함수
	function sendMessageFromInput() {

		var inputMsg = $("#inputMsg").val(); // 입력한 메시지
		if (inputMsg === "") return false; // 빈 메시지 전송 방지


		sendMessage(usercode, nickname, match_yn, inputMsg); // 로그인한 회원의 닉네임과 방 코드로 메시지 전송
		$("#inputMsg").val(''); // 입력창 초기화
	}

	// 메시지 불러오기 함수
	function loadChatMessages() {
		if (match_yn === 0) {
			console.warn("매칭 방 코드가 0이므로 이전 메시지를 불러오지 않습니다.");
			return; // 함수 종료
		}

		$.ajax({
			url: "/message/chat/" + match_yn, // match_yn은 매칭된 방 코드
			type: "GET",
			success: function(data) {
				console.log("서버에서 받은 메시지들:", data);
				// 받은 메시지를 화면에 표시
				data.forEach(function(message) {
					showCatMessage(message); // 각 메시지를 화면에 표시
				});
			},
			error: function(error) {
				console.error("메시지 불러오기 실패:", error);
			}
		});
	}


	// 서버로 메시지 전송 함수
	function sendMessage(usercode, nickname,recipient, content, add_date) {
		let messageData = {
			usercode: usercode, // 전역 변수 usercode 사용
			nickname: nickname, // 전역 변수 nickname 사용
			recipient: recipient, // 방 코드 (방 구분을 위한 식별자)
			content: content,    // 메시지 내용
			add_date: add_date
		};
		stompClient.debug = null;
		// WebSocket이 연결되었는지 확인 (readyState가 OPEN인지 확인)
		if (socket.readyState === WebSocket.OPEN) {
			// 각 방 코드에 맞는 경로로 메시지 전송
			stompClient.send("/message/chat/" + match_yn, {}, JSON.stringify(messageData));
			console.log("메시지가 전송되었습니다.");
		} else {
			console.error("WebSocket 연결이 완료되지 않았습니다. 연결 상태:", socket.readyState);
		}

	}


	// 서버에서 받은 메시지를 화면에 표시하는 함수
	function showCatMessage(data) {
		console.log("서버에서 받은 메시지:", data); // 수신한 메시지 출력
		var currentUserCode = localStorage.getItem("usercode"); // 현재 사용자의 유저코드 가져오기
		var usercode = data.usercode; // 메시지를 보낸 사용자의 유저코드 가져오기

		// 유저코드가 로컬 저장소에 저장되어 있지 않다면 저장
		if (!currentUserCode  || currentUserCode  !== usercode) {
			localStorage.setItem("usercode", usercode);
			console.log("유저코드가 로컬 저장소에 저장되었습니다:", usercode);
		}

		// 닉네임을 수신한 데이터에서 가져오기
		var nickname = data.nickname; // 메시지 데이터에서 닉네임을 추출

		console.log("닉네임:", nickname); // 닉네임 확인
		console.log("usercode:", usercode); // 발신자 유저코드 확인
		console.log("currentUserCode:", currentUserCode); // 현재 유저코드 확인

		//메시지를 화면에 렌더링하기 위한 HTML 태그 생성
		var tag = '';

		// 내가 보낸 메시지인 경우 (오른쪽에 표시)
		if (data.usercode == currentUserCode) {
			tag += `
        <div class="chat-message">
            <input type="checkbox" class="message-checkbox" style="display: none;" value='{"message_code": "` + data.message_code + `", "content": "` + data.content + `"}'>
            <img src="/img/man0.png" alt="프로필 이미지" class="profile-img">
            <div class="message-info">
                <span class="nickname">`+nickname+`</span>
                <p>`+data.content+`</p>
                <div class="timestamp">`+data.add_date+`</div>
            </div>
        </div>`;
		} else {
			// 다른 사람이 보낸 메시지인 경우(왼쪽에 표시)
			tag += `
        <div class="chat-message-left">
            <input type="checkbox" class="message-checkbox" style="display: none;" value='{"message_code": "` + data.message_code + `", "content": "` + data.content + `"}'>
            <img src="/img/woman0.png" alt="프로필 이미지" class="profile-img">
            <div class="message-info">
                <span class="nickname">`+nickname+`</span>
                <p>`+data.content+`</p>
                <div class="timestamp-left">`+data.add_date+`</div>
            </div>
        </div>`;
		}
		// 메시지를 채팅창에 추가
		$("#taMsg").append(tag);

		// 스크롤을 최신 메시지로 자동 이동
		var chatbox = document.getElementById("taMsg");
		chatbox.scrollTop = chatbox.scrollHeight;
	}

	//신고하기부분
	// 체크박스를 표시하거나 숨길 때 이벤트 리스너를 추가하는 함수
	function toggleCheckBoxes() {
		const checkboxes = document.querySelectorAll('.message-checkbox');
		checkboxes.forEach(checkbox => {
			// 체크박스를 보이거나 숨기기
			checkbox.style.display = checkbox.style.display === 'none' ? 'inline' : 'none';

			// 체크박스가 보일 때 change 이벤트 리스너 추가
			if (checkbox.style.display === 'inline') {
				checkbox.addEventListener('change', toggleSendReportButton);
			} else {
				// 체크박스가 숨겨질 때 체크 상태 해제 및 리스너 제거
				checkbox.checked = false; // 체크 해제
				checkbox.removeEventListener('change', toggleSendReportButton); // 리스너 제거
			}
		});

		// 체크박스 상태에 따라 버튼 전환
		toggleSendReportButton();
	}

	// 체크박스 상태에 따라 전송 버튼과 신고 버튼을 전환하는 함수
	function toggleSendReportButton() {
		const checkboxes = document.querySelectorAll('.message-checkbox:checked'); // 체크된 체크박스 탐색
		const sendButton = document.getElementById('sendBtn');
		const reportButton = document.getElementById('reportBtn');

		// 체크박스가 하나 이상 체크된 경우 신고하기 버튼 표시
		if (checkboxes.length > 0) {
			sendButton.style.display = 'none';
			reportButton.style.display = 'inline';
		} else {
			// 체크된 것이 없으면 신고 버튼 숨기고 전송 버튼 표시
			sendButton.style.display = 'inline';
			reportButton.style.display = 'none';
		}
	}

	// 모달 관련 코드
	const reportModal = document.getElementById('reportModal');
	const closeModalButton = document.getElementById('chatCloseModal');
	const reportBtn = document.getElementById('reportBtn');
	const submitReportBtn = document.getElementById('submitReportBtn');


	function reportMessages() {
		const checkedMessages = document.querySelectorAll('.message-checkbox:checked'); // 체크된 메시지들
		const messageDetails = Array.from(checkedMessages).map(checkbox => {
			const messageData = JSON.parse(checkbox.value); // 메시지 데이터를 가져옴
			const messageElement = checkbox.closest('.chat-message, .chat-message-left'); // 부모 요소 찾기
			const nickname = messageElement.querySelector('.nickname').innerText; // 닉네임 추출
			const usercode = messageElement.querySelector('.nickname').dataset.usercode; // 유저코드 추출

			// 닉네임과 메시지 데이터를 함께 반환
			return {
				message_code: messageData.message_code,
				content: messageData.content,
				nickname: nickname, // 닉네임 추가
				usercode: usercode // 유저코드 추가
			};
		});

		if (checkedMessages.length > 0) {
			// 첫 번째 선택된 메시지 가져오기
			const firstCheckedMessage = checkedMessages[0];
			const messageElement = firstCheckedMessage.closest('.chat-message, .chat-message-left');

			// 실제 피해자 정보 설정
			const offenderCode = messageElement.querySelector('.nickname').dataset.usercode; // 유저코드 설정
			const victimUserCode = messageElement.querySelector('.nickname').dataset.usercode || " "; // 유저코드 설정
			const victimNickname = messageElement.querySelector('.nickname').innerText || '알수없음'; // 닉네임 설정
			const matchingRoomCode = match_yn; // 매칭 방 코드

			// 신고 모달의 상단에 피해자 유저코드, 닉네임, 매칭 방 코드 설정
			document.getElementById('victimUserCode').innerText = victimUserCode;
			document.getElementById('victimNickname').innerText = victimNickname;
			document.getElementById('matchingRoomCode').innerText = matchingRoomCode;

			// 메시지 리스트 초기화
			const messageList = document.getElementById('messageList');
			messageList.value = ''; // textarea 초기화

			// // 메시지 코드를 따로 가져오기
			// const messageCodes = messageDetails.map(detail => detail.message_code);

			// 메시지 내용을 따로 가져오기
			const messageContents = messageDetails.map(detail => detail.content);

			// 닉네임을 따로 가져오기
			const messageNicknames = messageDetails.map(detail => detail.nickname);

			// 유저코드를 따로 가져오기
			const messageUserCodes = messageDetails.map(detail => detail.usercode);

			// 신고 처리 로직 (textarea에 출력)
			messageList.value = '닉네임: ' + messageNicknames.join(', ')  + '\n메시지 내용: ' + messageContents.join('\n');
			// messageDetails.forEach(detail => {
			// 	messageList.value += `닉네임:` + messageNicknames.join(', ') + '\n메시지 내용: ' + messageContents.join('\n');
			// });

			// 신고 데이터 구성
			const reportData = {
				offender_code: offenderCode, // 신고당한 유저코드
				report_reason: document.getElementById('reportReason').value, // 신고 사유
				victim_code: victimUserCode, // 피해자 유저코드
				crew_history_code: "", // 필요한 경우 추가
				matching_room_code: match_yn, // 매칭 방 코드
				report_status: 0, // 초기 상태
				report_content: JSON.stringify(messageDetails) // 선택한 메시지 내용
			};

			// 신고를 서버로 전송
			console.log('Report Data:', reportData);
			fetch('/chat/report', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(reportData)
			})
					.then(response => {
						if (!response.ok) {
							throw new Error('Network response was not ok ' + response.statusText);
						}
						return response.json();
					})
					.then(data => {
						alert('신고가 접수되었습니다: ' + data.report_content);
						closeModal(); // 모달 닫기
					})
					.catch(error => {
						console.error('Error:', error);
						alert('신고 접수에 실패했습니다.');
					});

			// 모달 열기
			reportModal.style.display = 'block';
		} else {
			alert('신고할 메시지를 선택하세요.');
		}
	}

	// 모달 닫기
	function closeModal() {
		reportModal.style.display = 'none';

		// 체크박스 해제
		const checkboxes = document.querySelectorAll('.message-checkbox');
		checkboxes.forEach(checkbox => {
			checkbox.checked = false;
			checkbox.style.display = 'none';  // 신고 후 다시 숨기기
		});

		// 신고 버튼 다시 전송 버튼으로 변경
		document.getElementById('sendBtn').style.display = 'inline';
		reportBtn.style.display = 'none';
	}

	// X 버튼과 신고 접수 버튼 클릭 시 모달 닫기
	closeModalButton.onclick = closeModal;
	submitReportBtn.onclick = function() {
		alert("신고가 접수되었습니다.");
		closeModal();
	};

	// 외부 클릭 시 모달 닫기
	window.onclick = function(event) {
		if (event.target === reportModal) {
			closeModal();
		}
	};

























</script>