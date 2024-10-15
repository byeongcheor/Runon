var searchType=null;
var searchValue=null;
setTimeout(function(){
    var page;
    reloadPage(page);

},100)

function reloadPage(page,searchType,searchValue){
    if (page==null){
        page=1;
    }
    var Data={
        page:page

    }
    if (searchType&&searchValue){
        Data.searchType=searchType;
        Data.searchValue=searchValue;
    }
    $.ajax({
        url:"/adminPages/selectmlist",
        type:"POST",
        data:Data,
        success:function(r){

            var members = r.list;  // 회원 목록
            var pVO = r.pvo;  // 페이징 정보
            var role=r.role
            // 1. 회원 목록 렌더링

                var tag = "<li><div id='usertitle2'><div class='username '>아이디 </div><div class='name'>이름</div>";
                tag += "<div class='nickname'>닉네임</div><div class='is_google'>소셜로그인여부</div><div class='is_info_disclosure'>정보공개여부</div>";
                tag += "<div class='tel'>전화번호</div><div class='birthdate'>생년월일</div>";
                tag += "<div class='creation_date'>가입일</div><div class='buttonline'></div></div></li>";

                members.forEach(function (member) {
                    tag += "<li><div class='usertitle3'><input type='checkbox' name='test[]' class='checkbox' style='display: none;' value='" + member.usercode + "'/>";
                    tag += "<div class='username'>" + member.username + "</div><div class='name'>" + member.name + "</div>";
                    tag += "<div class='nickname'>" + member.nickname + "</div><div class='is_google'>" + member.is_google + "</div><div class='is_info_disclosure'>";
                    tag += member.is_info_disclosure + "</div>";
                    tag += "<div class='tel'>" + member.tel + "</div>";
                    tag += "<div class='birthdate'>" + member.birthdate + "</div><div class='creation_date'>" + (member.creation_date).substring(0, 10) + "</div>";
                    tag += "<button class='btn btn-outline-secondary buttonline' type='button' style='flex-shrink: 0;' onclick='userdetail(" + member.usercode + ")'>상세보기</button></div></li>";
                });

                $("#userList").html(tag);

                // 2. 페이징 정보 렌더링
                var paginationTag = "";

                // 이전 버튼
                if (pVO.nowPage > 1) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage - 1) + ", searchType, searchValue);'>Previous</a></li>";
                }

                // 페이지 번호 출력
                for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:reloadPage(" + p + ", searchType, searchValue);'>" + p + "</a></li>";
                    }
                }

                // 다음 버튼
                if (pVO.nowPage < pVO.totalPage) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage + 1) + ", searchType, searchValue);'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);


        },
        error: function (e) {
            console.log(e);
        }
    });
}
function excelDownload(){
    $.ajax({
        url:"/adminPages/uListDownload",
        type:"post",
        success:function(r){
            console.log("서버에서 받아온 값 ",r);
            download(r);
        }
    });

}
function download(data){

    const ws = XLSX.utils.json_to_sheet(data.list);  // JSON 데이터를 Worksheet로 변환
    const wb = XLSX.utils.book_new();  // 새로운 Workbook 생성
    XLSX.utils.book_append_sheet(wb, ws, "Sheet1");  // 워크시트를 Workbook에 추가
    XLSX.writeFile(wb, "data.xlsx");  // Excel
}
function userdetail(usercode){
    document.getElementById("userdetailbackground").style.display="block";
    $.ajax({
        url:"/adminPages/userdetail",
        type:"post",
        data:{usercode:usercode
        },
        success:function(r){
            var rlist=r.rlist;
            var users=r.mvo;
            var recordlist=r.recordlist;
            var payVo=r.payVo;
            var usertag=`
            
            <div id="userprofile">
                <img src="../../profileImg/`+users.profile_img+`"/>
               <div><input type="button" value="탈퇴시키기" onclick="userdel(` + users.usercode + `)"></div>

                <div>`;
            if (users.is_disabled==0){
            usertag+= `
                    <form method="post"  onsubmit="return disableUser(`+users.usercode+`)">
                        <select id="stopDuration">
                            <option value="7">7일</option>
                            <option value="14">14일</option>
                            <option value="30">30일</option>
                            <option value="999">영구</option>    
                        </select>
                        <input type="submit" value="정지" />
                    </form>
                    `;
            }else{
                usertag+=`
                <div>정지된 유저입니다 <br/>
                정지시작:`+users.disabled_start_date+`<br/>
                남은시간:`+users.disabled_date+`</div>
                <button onclick="enableUser(`+users.usercode+`)">정지해제</button>
                    
               
                `;
            }


            usertag+= `
                </div>
            </div>
            <div id="userstatus">
                <div class="onelow">
                    <div id="name">이름:`+users.name+`</div>
                    <div id="username">아이디:`+users.username+ `</div>
                </div>
                <div class="onelow">
                    <div id="nickname">닉네임:`+users.nickname+`</div>
                    <div id="birthday">생년월일:`+users.birthdate+`</div>
                </div>
                <div class="onelow">
                    <div id="tel">핸드폰번호:`+users.tel+`</div>
                    <div id="reportcnt">신고당한횟수:`+rlist.length+`</div>
                </div>
                <div class="onelow">
                    <div id="zipcode">우편번호:`+users.zip_code+`</div>
                    <div id="addr"> 주소:`+users.addr+` </div>
                </div>
                <div class="onelow">
                    <div id="addrdetail">상세주소:`+users.addr_details+`</div>
                </div>
            </div>`;
            document.getElementById("usermain").innerHTML=usertag;
            var totalscore=0;
            recordlist.forEach(function(recordlist){
                totalscore += recordlist.score_change;
            });
            var recordtag="<h1>총점수:"+totalscore+"km</h1><ul>";


            if (recordlist==null || recordlist==""){
                recordtag +="<h2 style='text-align: center'>아직 기록이 없습니다.</h2>";
            }else{
                recordlist.forEach(function(recordlist){
                    recordtag += "<li> 점수변동 "+recordlist.score_change+"km 현재점수:"+recordlist.now_score+"km 변동일:"+recordlist.changedate.substring(0,10)+"</li>"
                });
            }
            recordtag += "</ul>";
            document.getElementById("userrecord").innerHTML=recordtag;

            var totalamont=0;
            payVo.forEach(function(payVo){
               totalamont +=payVo.real_amount ;
            });
            var paytag="<h1 style='text-align: center'>총결제액:"+totalamont.toLocaleString('ko-KR')+"</h1><ul>";
            if (payVo==null||payVo==""){
                paytag +="<h2 style='text-align: center'>결제내역이 없습니다</h2>";
            }else{
                payVo.forEach(function(payVo){
                    paytag += "<li><div class='paycontent' style='text-align: center'>대회명:"+payVo.marathon_name+"수량:"
                    paytag += payVo.quantity+"장 단가:"+(payVo.price).toLocaleString('ko-KR')+"원 ";
                    paytag += "결제액:"+(payVo.real_amount).toLocaleString('ko-KR')+"원";
                    paytag += "<span>구매일:"+payVo.completed_date+"</span></div></li>";


                });

            }
            paytag+= "</ul>";
            document.getElementById("userpay").innerHTML=paytag;

        },error:function(e){
            console.log("에러발생"+e);
        }


    })
}
function closedetail(){
    document.getElementById("userdetailbackground").style.display="none";
}
function userdel(delusercode){
    alert(delusercode);
    $.ajax({
        url:"/adminPages/deluser",
        type:"post",
        data:{
            usercode:delusercode,
        },
        success:function(r){
            //오는것 확인
            alert("삭제상태:"+r);

        },
        error:function(e){
            console.log(e);
            alert("실패");
        }
    });
}
function disableUser(disablecode){
    event.preventDefault();
    var disableday = document.getElementById('stopDuration').value;
    // alert("이벤트발생 x");
    // alert(disablecode);
    // alert("선택된 기간: " + disableday);
    // 값오는것 확인완료
    $.ajax({
        url:"/adminPages/disableUser",
        type:"post",
        data:{
            usercode:disablecode,
            disableday:disableday
        },
        success:function(r){
            window.location.reload();
            alert("정지되었습니다");


        },error:function(e){
            console.log("예외발생"+e);
        }



    });
}
function enableUser(enableUsercode){
    alert(enableUsercode);
    $.ajax({
        url:"/adminPages/enableUser",
        type:"post",
        data:{
            usercode:enableUsercode
        },
        success:function(r){
            window.location.reload();
            alert("정지가 풀렸습니다.");
        }
        ,error:function (e){
            console.log(e);
        }
    })

}

function searchbutton(){
    searchType=document.getElementById("searchvalue").value;
    searchValue=document.getElementById("searchtext").value;
    if (searchValue.length<1){
        alert("검색어를 입력해주세요");
        return false;
    }
    reloadPage(1,searchType,searchValue);


}
function enterKey(event) {

    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
let boxCount=0;


function blockhidden(){
    boxCount++;
    document.querySelectorAll('.checkbox').forEach(function(checkbox) {
        if (boxCount%2==1){
        checkbox.style.display="block"; // 마우스를 올렸을 때 포인터 모양
        }else{
            checkbox.style.display="none";
            checkbox.checked = false;
        }
    });
}
let checkCount=0;
function checkAll(){
    checkCount++;
    document.querySelectorAll('.checkbox').forEach(function(checkbox) {
        if (checkCount % 2 == 1) {
            checkbox.checked = true; // 모든 체크박스를 선택
        } else {
            checkbox.checked = false; // 모든 체크박스를 선택 해제
        }
    });
}
function selectExcel(){
    event.preventDefault();
    let selectedVlaues=[];
    document.querySelectorAll(".checkbox:checked").forEach(function(checkbox){
       selectedVlaues.push(checkbox.value);
    });
    console.log("선택된값 체크"+selectedVlaues);
    console.log(selectedVlaues);
    if (selectedVlaues.length==0){
        alert("선택된값이 없습니다");
        return false;
    }
    $.ajax({
        url:"/adminPages/selectExcel",
        type:"post",
        contentType:"application/json",
        data:JSON.stringify({usercodes:selectedVlaues}),
        success:function(r){
            console.log("서버에서 받아온 값 ",r);
            download(r);
        },
        error:function(e){
           console.log(e);
        }

    });

}