
window.onload = () => {
    CKEDITOR.ClassicEditor.create(document.getElementById("marathon_content"), option);
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
    var marathonName = document.getElementById('marathon_name').value;
    var marathonContent = document.getElementById('marathon_content').value;
    var eventDate = document.querySelector('input[name="event_date"]').value;
    var addr = document.querySelector('input[name="addr"]').value;
    var totalDistance = document.querySelector('input[name="total_distance"]').value; // select에서 input으로 변경
    var entryFee = document.querySelector('input[name="entry_fee"]').value; // select에서 input으로 변경
    var posterImage = document.getElementById('posterImage').files.length; // 이미지 파일 수 체크
    var lat = document.getElementById('latitude').value;
    var lon = document.getElementById('longitude').value;

    // 필수 필드 검증
    if ( !marathonContent|| !marathonName || !eventDate || !addr || !totalDistance || entryFee === "0" || posterImage === 0 || !lat || !lon) {
        alert("모든 필수 필드를 입력해주세요.");
        event.preventDefault();  // 폼 제출 중지
    }
});



