var tokenRequestInProgress = false; // 토큰 갱신 중 여부 확인

$(document).ready(function () {

    // 모든 AJAX 요청에 Authorization 헤더 추가
    $.ajaxSetup({
        beforeSend: async function (xhr, settings) {
            // 재시도 여부를 확인하여 무한 루프 방지
            if (!settings._retry) {
                let headers = await addTokenToHeaders({});

                // 반환된 headers의 값을 AJAX 요청에 설정
                for (let key in headers) {
                    xhr.setRequestHeader(key, headers[key]);
                }
            }
        }
    });

    // 전역적으로 AJAX 에러 처리 (401, 403 에러)
    $(document).ajaxError(async function (event, xhr, settings, error) {
        if (xhr.status === 401 || xhr.status === 403) {
            console.log(`${xhr.status} 에러 발생, 토큰 갱신 시도 중...`);

            if (!settings._retry) {
                settings._retry = true; // 재시도 플래그 설정
                let newAccessToken;

                // 토큰 갱신 시도
                let atoken = localStorage.getItem("Authorization");
                if (atoken != null) {
                    newAccessToken = atoken;
                } else {
                    newAccessToken = await obtainNewAccessToken();
                }

                if (newAccessToken) {
                    // 갱신된 토큰으로 헤더 설정 후 재시도
                    $.ajax({
                        url: settings.url,  // 이전에 실패했던 요청의 URL
                        type: settings.type,  // 이전 요청의 타입 (GET, POST 등)
                        data: settings.data,  // 이전 요청의 데이터
                        headers: { 'Authorization': newAccessToken },  // 새로운 토큰 추가
                        _retry: true,  // 재시도 시 _retry 설정 방지

                        success: function (response, status, xhr) {
                            document.cookie = `Authorization=${newAccessToken}; path=/; Secure; HttpOnly`;
                            alert("성공");
                            console.log("상태:", status);
                            //console.log("xhr:", xhr);
                            $('body').html(response);
                        },
                        error: function (xhr, status, error) {
                            console.error('재시도 실패:', status, error);
                            alert("재시도 실패");
                            logout();  // 재시도 실패 시 로그아웃
                        }
                    });
                } else {
                    console.log('토큰 갱신 실패, 로그아웃 처리');
                    logout();  // 토큰 갱신 실패 시 로그아웃 처리
                }
            }
        }
    });
});

// AJAX 요청을 보낼 때마다 헤더에 토큰 추가
async function addTokenToHeaders(headers) {
    // 로컬 스토리지에서 저장된 'Authorization' 토큰 가져오기
    let token = localStorage.getItem('Authorization');
    //console.log('로컬 스토리지에서 가져온 토큰:', token);
    if (token) {
        //console.log("토큰 있음, 바로 헤더에 추가");
        headers['Authorization'] = token;
        return headers;
    }

    // 토큰이 없고, 다른 갱신 요청이 진행 중이지 않으면
    if (!token && !tokenRequestInProgress) {
        console.log("토큰 없음, 갱신 시도");
        tokenRequestInProgress = true;  // 토큰 갱신 중 상태로 설정

        token = await obtainNewAccessToken();  // 토큰 갱신 함수 호출
        tokenRequestInProgress = false;  // 토큰 갱신 완료 상태로 설정

        if (!token) {
            //console.log("토큰 갱신 실패, 헤더 그대로 반환");
            //console.log(headers);
            return headers;  // 토큰을 가져오지 못하면 헤더 그대로 반환
        }

        // 토큰 갱신 성공 시 로컬 스토리지에 저장
        localStorage.setItem('Authorization', token);
    }

    // Bearer를 포함한 토큰을 그대로 추가
    headers['Authorization'] = token;
    //console.log('헤더에 추가된 토큰:', headers['Authorization']);
    return headers;
}

// 토큰 갱신 함수
async function obtainNewAccessToken() {
    return new Promise((resolve, reject) => {
        // 리프레시 토큰을 로컬 스토리지에서 가져오기
        let rtoken = localStorage.getItem("refresh");
        if (rtoken != null) {
            // 리프레시 토큰이 있으면 서버로 갱신 요청
            $.ajax({
                url: "/axiosApi",
                type: "post",
                data: { refreshToken: rtoken },
                success: function (response) {
                    //console.log("리프레시 토큰으로 엑세스 토큰 발급 성공");

                    // 서버로부터 새 토큰을 받아 로컬 스토리지에 저장
                    if (response) {
                        localStorage.setItem("Authorization", response);
                        resolve(response);  // 새 토큰 반환
                    } else {
                        resolve(null);  // 응답에 토큰이 없으면 null 반환
                    }
                },
                error: function (e) {
                    console.log("토큰 갱신 실패", e);
                    resolve(null);  // 에러 발생 시 null 반환
                }
            });
        } else {
            console.log("리프레시 토큰이 없습니다.");
            resolve(null);  // 리프레시 토큰이 없으면 null 반환
        }
    });
}

// 로그아웃 함수 정의
function logout() {
    console.log("사용자를 로그아웃 처리합니다.");
    // 여기서 실제로 로그아웃 처리 (예: 로컬 스토리지 제거, 페이지 리다이렉트 등)
    localStorage.removeItem('Authorization');
    localStorage.removeItem('refresh');
    localStorage.removeItem("matchedRoomCode");
    localStorage.removeItem("userNickname");
    localStorage.removeItem("usercode");
    window.location.href = "/"; // 로그인 페이지로 리다이렉트
}
