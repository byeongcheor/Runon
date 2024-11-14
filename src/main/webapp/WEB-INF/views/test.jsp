<style>
    header,footer{
        display: none;
    }
</style>
    <h1>메인입니당 엑셀 업로드 테스트~</h1>

<input type="file" id="fileInput" name="file">
<input type="button" value="업로드!" onclick="uploadExcel()">
<div id="progressWrapper" style="width: 100%; background-color: #f3f3f3;">
    <div id="progressBar" style="width: 0%; height: 20px; background-color: #4caf50;"></div>
</div>
<p id="progressText">0%</p>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function uploadExcel() {
        var formData = new FormData();
        var fileInput = document.getElementById('fileInput');

        // 파일을 FormData에 추가
        formData.append("file", fileInput.files[0]);

        // Excel 파일 업로드 시작
        $.ajax({
            url: '/test/addExcel',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                console.log('파일 처리 시작');
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("파일 업로드 실패!");
            }
        });

        // 진행률 체크 시작 (1초마다 서버에 진행 상태 요청)
        var progressInterval = setInterval(function() {
            $.get('/test/progress', function(progress) {
                // 진행 상태 업데이트
                document.getElementById('progressBar').style.width = progress + '%';
                document.getElementById('progressText').innerText = progress + '%';

                // 진행률이 100%에 도달하면 완료
                if (progress >= 100) {
                    clearInterval(progressInterval);
                    alert('작업 완료!');
                }
            });
        }, 1000);  // 1초마다 진행 상태 확인
    }
</script>