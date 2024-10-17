setTimeout(function(){
    $.ajax({
        url:"/order/selectmypoint",
        type:"post",
        data:{
            usercode:usercode1,
        },
        success:function(r){
            var pvo=r.pvo;
            console.log(" ㅁ"+r);
            var tag=`<input type="text" id="pointInput" placeholder="100p부터 사용가능"/>
                <button type="button" onclick="usePoints()">사용</button>
                <button type="button" onclick="useAllPoints()">전액 사용</button>
                <div>보유 포인트: <span id="userPoints">`+pvo.mypoint.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' })+`원</span></div>`;
            document.getElementById("pointTable").innerHTML=tag;
        }
    });

},300);