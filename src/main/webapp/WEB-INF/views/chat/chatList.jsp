<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Bootstrap JS 연결 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery 연결 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="/css/chatList.css" type="text/css">
<!-- 채팅창 영역 -->
<c:forEach var="uvo" items="${userselect}"><!--유저 정보 가져오기 아이디값은 무조건 줘야 된다.-->
	<input type='hidden' id=usercode value=${uvo.usercode}>
	<input type='hidden' id=nickname value=${uvo.nickname}>
	<input type='hidden' id=gender value=${uvo.gender}>
</c:forEach>
<%--<button id="chatButton" class="image-button"></button>--%>
<div id="chatbox" >
	<div class="chatbox-header">
		<button id="closeChatBtn" class="close-chat-btn">×</button>
		<img src="/img/bell.png"
			 alt="신고"
			 class="bell-icon"
			 onmouseover="this.src='/img/bell2.png';"
			 onmouseout="this.src='/img/bell.png';"
			 onclick="toggleCheckBoxes()">
		<button id="reportHistoryBtn" style="display: none; margin-left: 10px;
    border-radius: 10px;
    background-color: #ddd;" onclick="showReportHistory()">신고 내역 보기</button>
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
<%--	<!-- 메이트 방 -->--%>
<%--	<div class="chat-item mate-item" id="mateChatButton">--%>
<%--		<img src="/img/man0.png" alt="메이트 이미지" class="chat-img">--%>
<%--		<div id="mate_chat" class="chat-info">--%>
<%--			<div class="chat-text">메이트 채팅방</div>--%>
<%--			<div class="chat-date">2024-10-13</div>--%>
<%--		</div>--%>
<%--	</div>--%>

	<!-- 크루 방 리스트 -->

<%--	<c:forEach var="crewchat" items="${chatList}">--%>
<%--		<div class="chat-item">--%>
<%--			<img src="/crew_upload/${crewchat.logo}" alt="${crewchat.crew_name} 이미지" class="chat-img">--%>
<%--			<div class="chat-info">--%>
<%--				<div class="chat-text">${crewchat.crew_name}</div>--%>
<%--				<div class="chat-date">2024-10-12</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--	</c:forEach>--%>
</div>
<!-- 더 많은 크루들 추가 -->
<!-- 신고하기 모달 -->
<div id="reportModal" class="ChatReportModal">
	<div class="ChatReport_modal-content">
		<span class="chatModalClose" id="chatCloseModal">&times;</span>
		<h1 class="reportT">신고하기</h1>
		<div id="reportUserInfo">
			<p><span id="victimUserCode" style="display:none;"></span></p>
			<p><span id="victimNickname" style="display:none;"></span></p>
			<p><span id="matchingRoomCode" style="display:none;"></span></p>
		</div>
		<div id="selectedMessages">
			<h1>선택한 메시지:</h1>
			<textarea id="messageList" rows="3" cols="35" ></textarea>
		</div>
		<div class="reportTT">
			<label for="reportReason" class="reportR">신고 사유:</label><br/>
			<textarea id="reportReason" placeholder="신고 사유를 입력해 주세요" rows="3" cols="35"></textarea>
		</div>
		<div class="reportButton-container">
			<button id="submitReportBtn" class="report-btn">신고접수</button>
		</div>
	</div>
</div>
<!--신고내역 -->
<div id="reportHistoryModal" class="ChatReportModal">
	<div class="ChatReport_modal-content1">
		<span class="chatModalClose" id="chatCloseModal1">&times;</span>
		<h1 class="reportT">신고 내역</h1>
		<div id="reportList">
			<!-- 신고 내역이 여기에 추가됩니다 -->
		</div>
	</div>
</div>


<script>
	/*console.log("Chat List Size: ${chatList.size()}");*/
</script>
<script>
	var match_yn="${vo.match_yn}";
	let socket; // socket 객체
	let stompClient; // stomp를 이용하여 서버와 메시지를 주고 받는다.
	var nickname=$('#nickname').val();
	var token = localStorage.getItem("Authorization");
	var usercode=usercode1;
	var gender;
	var Authorization = localStorage.getItem("Authorization");
	/*	var usercode=usercode1;*/

	//채팅연결공통


		setTimeout(function () {

		/*	console.log('User Code:', usercode); // 디버깅용 로그 추가
			console.log('gender:', gender);*/

			// 매칭 방 코드 설정 (필요한 로직으로 대체 가능)
			if (!match_yn || match_yn === "undefined") {
				let storedRoomCode = localStorage.getItem("matchedRoomCode");
				if (storedRoomCode && storedRoomCode !== "undefined") {
					match_yn = storedRoomCode;
				} else {
					/*console.warn("저장된 방 코드가 없습니다.");*/
					return; // 방 코드가 없으면 종료
				}
			} else {
				// 방 코드가 있을 경우, 로컬 저장소에 저장
				localStorage.setItem("matchedRoomCode", match_yn);
			}

			// 최종적으로 확인할 방 코드
			/*console.log("유효한 방 코드: ", match_yn);*/

			// 채팅 서버 연결하기
			chatConnection(usercode, nickname, match_yn, gender);
			// 이전 채팅 내역 불러오기
			loadChatMessages(usercode, match_yn);


			// 서버로 메시지 보내기 (Enter 키)
			$("#inputMsg").keyup(function (event) {
				if (event.keyCode === 13) {
					sendMessageFromInput(usercode, nickname, match_yn, gender);
				}
			});

			// 서버로 메시지 보내기 (전송 버튼)
			$("#sendBtn").click(function () {
				sendMessageFromInput(usercode, nickname, match_yn, gender);
			});

		}, 300);



	// 채팅 서버와 연결하는 함수
	function chatConnection() {
		/*console.log('채팅서버 연결:', usercode);*/ // 디버깅용 로그 추가


		if (!usercode) {
			/*console.error("usercode를 가져올 수 없습니다.");*/
			return;
		}
		// 매칭 방 코드가 0일 경우 채팅 연결 차단
		if (match_yn === 0) {
		/*	console.warn("매칭을 완료한 후 채팅을 이용할 수 있습니다.");*/
			alert("매칭을 완료한 후 채팅을 이용할 수 있습니다.");
			return; // 채팅 연결을 막음
		}

		/*console.log("매칭 방 코드: ", match_yn);*/
		socket = new SockJS("/chat"); // WebSocket 엔드포인트와 연결
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
		/*	console.log('WebSocket 연결 성공:', frame);
			console.log(usercode, nickname);*/



			// 방 코드에 따라 구독 경로 설정
		/*	console.log('방 코드에 따라:', usercode); // 디버깅용 로그 추가*/
			stompClient.subscribe("/topic/messages/"+match_yn, function(receiveMsg) {
			/*	console.log('receiveMsg->',receiveMsg);*/
				var jsonMsg = JSON.parse(receiveMsg.body);
			/*	console.log("서버에서 수신한 메시지:", jsonMsg);*/ // 수신한 메시지 확인


				showCatMessage(jsonMsg);
			});
			// 서버로 메시지 전송 (닉네임 접속 알림)
			sendMessage(usercode, nickname, match_yn, nickname + "님이 접속하였습니다.");
		}, function(error) {
			/*console.error("WebSocket 연결 실패:", error);*/
		});
	}




	// 메시지를 입력창에서 가져와 서버로 전송하는 함수
	function sendMessageFromInput(usercode, nickname, match_yn, gender) {

	/*	console.log('채팅 입력창:', usercode); // 디버깅용 로그 추가*/

		var inputMsg = $("#inputMsg").val(); // 입력한 메시지
		if (inputMsg === "") return false; // 빈 메시지 전송 방지


		sendMessage(usercode, nickname, match_yn, inputMsg, gender); // 로그인한 회원의 닉네임과 방 코드로 메시지 전송
		$("#inputMsg").val(''); // 입력창 초기화
	}

	// 메시지 불러오기 함수
	function loadChatMessages() {

	/*	console.log('메시지 불러오기:', usercode); // 디버깅용 로그 추가*/

		if (match_yn === 0) {
		/*	console.warn("매칭 방 코드가 0이므로 이전 메시지를 불러오지 않습니다.");*/
			return; // 함수 종료
		}

		$.ajax({
			url: "/message/chat/" + match_yn, // match_yn은 매칭된 방 코드
			type: "GET",
			success: function(data) {
			/*	console.log("서버에서 받은 메시지들:", data);*/
				// 받은 메시지를 화면에 표시
				data.forEach(function(message) {
					showCatMessage(message); // 각 메시지를 화면에 표시
				});
			},
			error: function(error) {
				/*console.error("메시지 불러오기 실패:", error);*/
			}
		});
	}


	// 서버로 메시지 전송 함수
	function sendMessage(usercode, nickname,recipient, content, add_date ,gender) {
	/*	console.log('메시지 전송:', usercode); // 디버깅용 로그 추가
		console.log("Sending gender:", gender); // gender 값 확인*/

		let messageData = {
			usercode:usercode,
			nickname: nickname, // 전역 변수 nickname 사용
			recipient: recipient, // 방 코드 (방 구분을 위한 식별자)
			content: content,    // 메시지 내용
			add_date: add_date,
			gender: gender // 로그인한 사용자의 성별 추가
		};
		stompClient.debug = null;
		// WebSocket이 연결되었는지 확인 (readyState가 OPEN인지 확인)
		if (socket.readyState === WebSocket.OPEN) {
			// 각 방 코드에 맞는 경로로 메시지 전송
			stompClient.send("/message/chat/" + match_yn, {}, JSON.stringify(messageData));
			/*console.log("메시지가 전송되었습니다.");*/
		} else {
		/*	console.error("WebSocket 연결이 완료되지 않았습니다. 연결 상태:", socket.readyState);*/
		}

	}



	// 서버에서 받은 메시지를 화면에 표시하는 함수
	function showCatMessage(data) {
		setTimeout(function() {
			// 현재 사용자의 유저코드 가져오기
			var usercode2 = data.usercode; // 메시지를 보낸 사용자의 유저코드 가져오기

			// 닉네임을 수신한 데이터에서 가져오기
			var nickname = data.nickname; // 메시지 데이터에서 닉네임을 추출

			var gender = data.gender;

			// 메시지를 화면에 렌더링하기 위한 HTML 태그 생성
			var tag = '';

			// 내가 보낸 메시지인 경우 (오른쪽에 표시)
			if (usercode2 == usercode) {
				let profileImage = gender === '남' ? '/img/man0.png' : '/img/woman0.png'; // 메시지의 성별에 따라 이미지 선택
				tag += `
    <div class="chat-message">
        <input type="checkbox" style="display: none;" value='{"message_code": "` + data.message_code + `", "content": "` + data.content + `"}'>
        <img src =` + profileImage + `  class="profile-img">
        <div class="message-info">
            <span class="nickname" data-usercode=` + data.usercode + ` style="display: none;">` + data.nickname + `</span>
            <span class="nickname">` + nickname + `</span>
            <p>` + data.content + `</p>
            <div class="timestamp">` + data.add_date + `</div>
        </div>
    </div>`;
			} else {
				// 다른 사람이 보낸 메시지인 경우 (왼쪽에 표시)
				let profileImage = data.gender === '남' ? '/img/man0.png' : '/img/woman0.png'; // 메시지의 성별에 따라 이미지 선택
				tag += `
    <div class="chat-message-left">
        <input type="checkbox" class="message-checkbox" style="display: none;" value='{"message_code": "` + data.message_code + `", "content": "` + data.content + `"}'>
         <img src =` + profileImage + `  class="profile-img">
        <div class="message-info">
            <span class="nickname" data-usercode=` + data.usercode + ` style="display: none;">` + data.nickname + `</span>
            <span class="nickname">` + nickname + `</span>
            <p>` + data.content + `</p>
            <div class="timestamp-left">` + data.add_date + `</div>
        </div>
    </div>`;
			}


			// 메시지를 채팅창에 추가
			$("#taMsg").append(tag);

			// 스크롤을 최신 메시지로 자동 이동
			var chatbox = document.getElementById("taMsg");
			chatbox.scrollTop = chatbox.scrollHeight;

			// 채팅방 목록에서 해당 채팅방의 날짜 업데이트
			updateChatRoomDate(data.add_date); // 메시지가 수신된 날짜로 업데이트
		}, 200); // 0ms 후에 실행
	}

	// 채팅방 목록에서 해당 채팅방의 날짜 업데이트 함수
	function updateChatRoomDate(latestDate) {
		$('#mate_chat .chat-date').text(latestDate); // 메이트 채팅방의 날짜를 최신 날짜로 변경
	}

	//신고하기부분
	// 체크박스를 표시하거나 숨길 때 이벤트 리스너를 추가하는 함수
	function toggleCheckBoxes() {
		const checkboxes = document.querySelectorAll('.message-checkbox');
		const reportHistoryBtn = document.getElementById('reportHistoryBtn')
		checkboxes.forEach(checkbox => {
			// 체크박스를 보이거나 숨기기
			checkbox.style.display = checkbox.style.display === 'none' ? 'inline' : 'none';

			// 체크박스가 보일 때 change 이벤트 리스너 추가
			if (checkbox.style.display === 'inline') {
				reportHistoryBtn.style.display = 'inline';
				checkbox.addEventListener('change', toggleSendReportButton);
			} else {
				// 체크박스가 숨겨질 때 체크 상태 해제 및 리스너 제거
				checkbox.checked = false; // 체크 해제
				reportHistoryBtn.style.display = 'none';
				checkbox.removeEventListener('change', toggleSendReportButton); // 리스너 제거
			}
		});

		// 체크박스 상태에 따라 버튼 전환
		toggleSendReportButton();
	}

	//신고내역보기
	function showReportHistory() {
		if (!usercode) {
			/*console.error('User code is not defined.');*/
			return; // usercode가 정의되지 않은 경우 함수를 종료
		}


		// 사용자 코드를 파라미터로 전송
		fetch('/chat/reportHistory?usercode=' + usercode)
				.then(response => response.json())
				.then(data => {
					let reportList = document.getElementById('reportList');
					reportList.innerHTML = ''; // 이전 내용 삭제

					data.forEach(report => {
						const reportItem = document.createElement('div');
						reportItem.classList.add('report-item'); // 클래스를 추가합니다.

						// 신고 내용
						const contentElement = document.createElement('div');
						contentElement.innerHTML = '<strong>신고 내용: </strong>' + report.report_content;

						// 신고 이유
						const reasonElement = document.createElement('div');
						reasonElement.innerHTML = '<strong>신고 이유: </strong>' + report.report_reason;

						// 신고 날짜
						const dateElement = document.createElement('div');
						dateElement.innerHTML = '<strong>신고 날짜: </strong>' + report.report_date;

						// 신고 상태
						const statusElement = document.createElement('div');
						const statusText = report.report_status === 1 ? '처리 완료' : '처리 중';
						statusElement.innerHTML = '<strong>신고 내역 상황: </strong> <span>' + statusText + '</span>';

						// 색상 설정: 처리 완료는 파란색, 처리 중은 빨간색
						statusElement.querySelector('span').style.color = report.report_status === 1 ? 'blue' : 'red';
						// // 신고 처리 버튼 추가 (처리 중인 경우)
						// if (report.report_status === 0) { // 0은 '처리 중' 상태를 나타낸다고 가정
						// 	const processButton = document.createElement('button');
						// 	processButton.innerText = '처리하기'; // 버튼 텍스트
						// 	processButton.classList.add('btn', 'btn-warning'); // Bootstrap 스타일 클래스 추가
						// 	processButton.onclick = function() {
						// 		// 신고 처리 로직 (예: API 호출)
						// 		handleReport(report.report_id); // report_id가 필요하다고 가정
						// 	};
						// 	statusElement.appendChild(processButton);
						// }

						// 각각의 요소를 reportItem에 추가
						reportItem.appendChild(contentElement);
						reportItem.appendChild(reasonElement);
						reportItem.appendChild(dateElement);
						reportItem.appendChild(statusElement);

						// 최종적으로 reportList에 추가
						reportList.appendChild(reportItem);
					});



					document.getElementById('reportHistoryModal').style.display = 'block';


					reportHistoryModal.style.display = 'block';
				})
				.catch(error => {
				/*	console.error('신고 내역 로딩 중 오류 발생:', error);*/
				});

// 신고 처리 로직 함수 예시


	}
	function handleReport(reportId) {
		// 신고 처리 API 호출 예시
		fetch('/chat/processReport?id=' + reportId, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			}
		})
				.then(response => response.json())
				.then(data => {
					if (data.success) {
						alert('신고가 처리되었습니다.');
						// 여기에서 필요한 후처리 (예: 모달 닫기, 상태 업데이트 등)
						$('#reportHistoryModal').modal('hide');
						// 다시 신고 내역을 불러오거나 상태를 업데이트하는 로직 추가 가능
					} else {
						/*alert('신고 처리에 실패했습니다: ' + data.message);*/
					}
				})
				.catch(error => {
				/*	console.error('신고 처리 중 오류 발생:', error);*/
				});
	}

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
	const closeReportHistoryModalButton = document.getElementById('chatCloseModal1');

	function reportMessages() {

		const checkedMessages = document.querySelectorAll('.message-checkbox:checked'); // 체크된 메시지들
		const messageDetails = Array.from(checkedMessages).map(checkbox => {
			const messageData = JSON.parse(checkbox.value); // 메시지 데이터를 가져옴
			const messageElement = checkbox.closest('.chat-message, .chat-message-left'); // 부모 요소 찾기
			const nickname = messageElement.querySelector('.nickname').innerText; // 닉네임 추출
			// const usercode = messageElement.querySelector('.nickname').dataset.usercode; // 유저코드 추출

			// 닉네임과 메시지 데이터를 함께 반환
			return {
				message_code: messageData.message_code,
				content: messageData.content,
				nickname: nickname, // 닉네임 추가
				usercode: usercode // 유저코드 추가
			};
		});

		if (checkedMessages.length > 0) {
			// 신고 모달 열기
			reportModal.style.display = 'block';

			/*console.log('Selected messages:', messageDetails); // 체크된 메시지 내용을 확인*/


			// 첫 번째 선택된 메시지 가져오기
			const firstCheckedMessage = checkedMessages[0];
			const messageElement = firstCheckedMessage.closest('.chat-message, .chat-message-left');


			// 실제 피해자 정보 설정
			const offenderCode = messageElement.querySelector('.nickname').dataset.usercode; // 신고당한 유저코드
			const victimUserCode = usercode; // 현재 로그인한 유저코드 설정
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
			messageList.value = '닉네임: ' + messageNicknames.join(', ') + '\n메시지 내용: ' + messageContents.join('\n');
			// messageDetails.forEach(detail => {
			// 	messageList.value += `닉네임:` + messageNicknames.join(', ') + '\n메시지 내용: ' + messageContents.join('\n');
			// });

			// 신고 접수 버튼 클릭 시 처리
			submitReportBtn.onclick = function () {
				// 신고 사유 입력 필드의 값 확인
				const reportReasonInput = document.getElementById('reportReason');
				const reportReason = reportReasonInput.value.trim(); // 신고 사유 가져오기


				// 신고 데이터 구성
				const reportData = {
					offender_code: offenderCode, // 신고당한 유저코드
					report_reason: reportReason, // 신고 사유
					victim_code: victimUserCode, // 피해자 유저코드
					crew_history_code: "", // 필요한 경우 추가
					matching_room_code: match_yn, // 매칭 방 코드
					report_status: 0, // 초기 상태
					report_content: JSON.stringify(messageDetails) // 선택한 메시지 내용
				};


				// 신고를 서버로 전송
				/*console.log('Report Data:', reportData);*/
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
							alert('신고가 완료되었습니다.');
							closeModal(); // 모달 닫기 및 초기화

							// // 여기에 추가: 신고 내역 보기
							// showReportHistory(); // 신고 내역 보여주기
						})
						.catch(error => {
							/*console.error('Error:', error);*/
							alert('신고 접수에 실패했습니다.');
						});


			}
		}

		// 모달 닫기

		// 외부 클릭 시 신고 모달 닫기
		window.onclick = function(event) {
			if (event.target === reportModal) {
				closeModal();
			} else if (event.target === reportHistoryModal) { // 신고 내역 모달 외부 클릭 시
				closeReportHistoryModal();
			}
		};



		// 외부 클릭 시 모달 닫기
		window.onclick = function (event) {
			if (event.target === reportModal) {
				closeModal();
			}
		};
	}
	$(document).ready(function() {
		// 채팅 아이콘 클릭 시 채팅창 표시 및 숨기기
		$('#chatButton').click(function () {
			// 매칭 방 코드가 0일 경우 알림창을 띄우고 채팅을 막음
			if (match_yn === "0") {
				alert("매칭을 완료한 후 채팅을 이용할 수 있습니다.");
				return; // 채팅 연결 및 메시지 불러오기를 막음
			}

			// 채팅창의 현재 상태 확인 후 보이거나 숨기기
			if ($('#chatbox').is(':visible')) {
				$('#chatbox').hide(); // 채팅창 숨기기
			} else {
				$('#chatbox').css('display', 'flex'); // 채팅창을 flex로 보이기
			}
		});

		// 닫기 버튼 클릭 시 채팅창 숨기기
		$('#closeChatBtn').click(function () {
			$('#chatbox').hide(); // 채팅창 숨기기
		});
	});


	function closeReportHistoryModal() {
		const reportHistoryModal = document.getElementById('reportHistoryModal');


		reportHistoryModal.style.display = 'none'; // 신고 내역 모달 숨기기
	}


	function closeModal() {
		reportModal.style.display = 'none';

		// 체크박스 해제
		const checkboxes = document.querySelectorAll('.message-checkbox');
		checkboxes.forEach(checkbox => {
			checkbox.checked = false;
			checkbox.style.display = 'none';  // 신고 후 다시 숨기기
		});

		// 신고 사유 필드 초기화
		document.getElementById('reportReason').value = '';

		// 신고 버튼 다시 전송 버튼으로 변경
		document.getElementById('sendBtn').style.display = 'inline';
		reportBtn.style.display = 'none';
	}

	// X 버튼 클릭 시 모달 닫기 (기존 코드)
	closeModalButton.onclick = function() {
		closeModal(); // 이미 정의된 closeModal 함수 호출
	};
	// 신고 내역 모달의 X 버튼 클릭 시 닫기
			closeReportHistoryModalButton.onclick = function() {
                closeReportHistoryModal(); // 신고 내역 모달 닫기 함수 호출
            };
	// 신고 내역 모달의 X 버튼 클릭 시 닫기
/*	if (closeReportHistoryModalButton) { // 버튼이 존재하는지 확인
		closeReportHistoryModalButton.onclick = function() {
			closeReportHistoryModal(); // 신고 내역 모달 닫기 함수 호출
		};
	} else {
		console.error('신고 내역 모달 닫기 버튼이 존재하지 않습니다.'); // 디버깅 메시지
	}*/
</script>