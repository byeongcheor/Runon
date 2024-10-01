// // AJAX 요청을 보낼 때마다 헤더에 토큰 추가
// function addTokenToHeaders(headers) {
//     const token = localStorage.getItem('Authorization');  // 로컬 스토리지에서 저장된 'Authorization' 토큰 가져오기
//     console.log('로컬 스토리지에서 가져온 토큰:', token);
//     if(token==null){
//         obtainNewAccessToken();
//         return headers;
//     }
//     if (token) {
//         headers['Authorization'] = token;  // Bearer를 포함한 토큰을 그대로 추가
//         console.log('헤더에 추가된 토큰:', headers['Authorization']);
//         return headers;
//
//     }
//
// }
//
// // 리프레시 토큰으로 새로운 액세스 토큰을 받기
// async function obtainNewAccessToken() {
//     try {
//         const refreshTokenValue = localStorage.getItem('refresh');  // 리프레시 토큰 가져오기
//         console.log('리프레시 토큰:', refreshTokenValue);
//
//         if (!refreshTokenValue) {
//             throw new Error('리프레시 토큰이 없습니다.');
//         }
//
//         const result = await new Promise((resolve, reject) => {
//             console.log("promise  호출");
//             $.ajax({
//                 url: "/axiosApi",  // 리프레시 토큰 유효성 검증 API 호출
//                 type: "post",
//                 data: { refreshToken: refreshTokenValue },
//                 success: function (r) {
//                     console.log("result = "+r);
//                     resolve(r);
//                 },
//                 error: function (err) {
//                     reject(err);
//                 }
//             });
//         });
//         console.log("db에서 값 넘어오는지 확인 ->"+result);
//
//         if (result == 1) {
//             console.log("result가 1인지 확인"+result);// 리프레시 토큰이 유효하면 액세스 토큰 재발급 요청
//             return new Promise((resolve, reject) => {
//                 $.ajax({
//                     url: "/reissue",  // 액세스 토큰 재발급 API 호출
//                     type: "post",
//                     data: {
//                         refreshToken: refreshTokenValue
//                     },
//                     success: function (response, status, xhr) {
//                         console.log("reissue+",response);
//                         const token = xhr.getResponseHeader('Authorization');
//                         console.log("토큰 추가성공")
//                         if (token) {
//                             localStorage.setItem('Authorization', token);  // 새로운 액세스 토큰 저장
//                             console.log('새로 받은 토큰:', token);
//                             resolve(token);
//                         } else {
//                             reject(new Error('토큰 재발급 실패'));
//                         }
//                     },
//                     error: function (err) {
//                         reject(err);
//                     }
//                 });
//             });
//         } else {
//             throw new Error('리프레시 토큰이 유효하지 않습니다.');
//         }
//     } catch (error) {
//         console.error("토큰 갱신 중 오류 발생:", error);
//         return null;
//     }
// }
//
// // 로그아웃 처리 함수
// function logout() {
//     localStorage.clear();
//     window.location.href = '/login&join/loginForm';  // 로그인 페이지로 리다이렉트
// }
//
// // AJAX 요청을 처리하는 함수
// function sendAjaxRequest(options) {
//     let headers = addTokenToHeaders(options.headers || {});
//
//     console.log('AJAX 요청에 사용된 헤더:', headers);
//     $.ajax({
//         url: options.url,
//         type: options.type || 'GET',
//         headers: headers,
//         data: options.data || {},
//         success: function (response, status, xhr) {
//             if (options.success) options.success(response, status, xhr);
//         },
//         error: async function (xhr, status, error) {
//             if (xhr.status === 401 && !options._retry) {
//                 console.log('401 에러 발생, 토큰 갱신 시도 중...');
//                 // 401 오류 발생 시 토큰 갱신 후 재시도
//                 options._retry = true;
//                 const newAccessToken = await obtainNewAccessToken();
//
//                 if (newAccessToken) {
//                     options.headers = addTokenToHeaders(options.headers || {});  // 갱신된 토큰으로 헤더 다시 설정
//                     sendAjaxRequest(options);  // 다시 요청
//                 } else {
//                     console.log('토큰 갱신 실패, 로그아웃 처리 중...');
//                     logout();  // 토큰 갱신 실패 시 로그아웃
//                 }
//             } else if (xhr.status === 403 && !options._retry) {
//                 console.log('403 에러 발생, 토큰 확인 후 재시도...');
//                 // 403 오류 발생 시 토큰 갱신 후 재시도
//                 options._retry = true;
//                 headers = addTokenToHeaders(options.headers || {});  // 헤더에 토큰 추가
//
//                 if (headers['Authorization']) {
//                     sendAjaxRequest(options);  // 다시 요청
//                 } else {
//                     logout();  // 토큰이 없으면 로그아웃
//                 }
//             } else {
//                 console.error(`AJAX 요청 실패: ${xhr.status}`, error);
//                 if (options.error) options.error(xhr, status, error);  // 다른 에러 처리
//             }
//         }
//     });
// }
//
// // 페이지가 로드될 때 AJAX 설정 적용
// $(document).ready(function () {
//     // 모든 AJAX 요청에 Authorization 헤더 추가
//     $.ajaxSetup({
//         beforeSend: function (xhr, settings) {
//             let headers = addTokenToHeaders({});
//             for (let key in headers) {
//                 xhr.setRequestHeader(key, headers[key]);
//             }
//         }
//     });
//
//     // 전역적으로 AJAX 에러 처리 (401, 403 에러)
//     $(document).ajaxError(async function (event, xhr, settings, error) {
//         if (xhr.status === 401 || xhr.status === 403) {
//             console.log(`${xhr.status} 에러 발생, 토큰 갱신 시도 중...`);
//
//             if (!settings._retry) {
//                 settings._retry = true;
//
//                 // 토큰 갱신 시도
//                 const newAccessToken = await obtainNewAccessToken();
//
//                 if (newAccessToken) {
//                     // 갱신된 토큰으로 헤더 설정 후 재시도
//                     $.ajax({
//                         url: settings.url,  // 이전에 실패했던 요청의 URL
//                         type: settings.type,  // 이전 요청의 타입 (GET, POST 등)
//                         data: settings.data,  // 이전 요청의 데이터
//                         headers: { 'Authorization': newAccessToken },  // 새로운 토큰 추가
//                         success: function (response, status, xhr) {
//                             console.log('재시도 성공:', response);
//                         },
//                         error: function (xhr, status, error) {
//                             console.error('재시도 실패:', status, error);
//                             logout();  // 재시도 실패 시 로그아웃
//                         }
//                     });
//                 } else {
//                     console.log('토큰 갱신 실패, 로그아웃 처리');
//                     logout();  // 토큰 갱신 실패 시 로그아웃 처리
//                 }
//             }
//         }
//     });
// });
