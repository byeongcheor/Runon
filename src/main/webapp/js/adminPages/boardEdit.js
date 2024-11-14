window.onload = () => {
    CKEDITOR.ClassicEditor.create(document.getElementById("marathonContent"), option);
}

    function updateImage(event) {
    var reader = new FileReader();
    reader.onload = function(){
    var output = document.getElementById('marathonPoster');
    output.src = reader.result; // 선택한 파일로 이미지 src 속성 업데이트
};
    reader.readAsDataURL(event.target.files[0]); // 파일 읽기
}

document.querySelector('.tnwjdBtn').addEventListener('click', function(event) {
    var marathonName = document.getElementById('marathonName').value;
    var eventDate = document.querySelector('input[name="event_date"]').value;
    var addr = document.querySelector('input[name="addr"]').value;
    var totalDistance = document.querySelector('select[name="total_distance"]').value;

    // 필수 필드 검증
    if (!marathonName || !eventDate || !addr || totalDistance === "0") {
        alert("모든 필수 필드를 입력해주세요.");
        event.preventDefault();  // 폼 제출 중지
    }
});
// 폼이 성공적으로 제출되었을 때 알림 표시
function showSuccessMessage() {
    alert("마라톤 정보가 성공적으로 수정되었습니다.");
}

// 페이지 이동 후 알림
window.onload = function() {
    if (window.location.href.includes('success')) {
        showSuccessMessage();
    }
};
