var searchType=null;
var searchValue=null;
var searchType2=null;
var searchValue2=null;
setTimeout(function(){
    var page;
    reloadPage(page);

},100)

function reloadPage(page,searchType,searchValue,searchType2,searchValue2){

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
    if(searchType2&&searchValue2){
        Data.searchType2=searchType2;
        Data.searchValue2=searchValue2;
    }
    if (usercode1){
        Data.usercode=usercode1;
    }

    $.ajax({
        url:"/adminPages/RoleCheck",
        type:"post",
        data:{
            usercode:usercode1
        },
        success:function(r){
            var role=r.Avo.role
            var Avo=r.Avo;
            if(role<2||Avo.admin_code==0) {



                var checkboxlisttag= '<button type="button" className="clickbox" onClick="blockhidden()">체크표시</button>';
                checkboxlisttag+= '<button type="button" className="clickbox" onClick="checkAll()">일괄체크</button>';
                checkboxlisttag+='<button type="button" className="clickbox" onClick="selectExcel()">선택엑셀</button>';
                document.getElementById("checkboxlist").style.display = "block";
                document.getElementById("checkboxlist").innerHTML=checkboxlisttag;
                var AdminRole2tag=`<button type="button"  onclick="selectList('2')">유저만 보기</button><button  onclick="selectList('1')" type="button">관리자만 보기</button><button onclick=" selectList('0')">전체보기</button>`;
                document.getElementById("AdminRole2").style.display = "block";
                document.getElementById("AdminRole2").innerHTML=AdminRole2tag;
                var hiddendowntag= `<input type="button" value="전체유저정보받기" onclick="excelDownload()"/>`;
                document.getElementById("hiddendown").style.display = "block";
                document.getElementById("hiddendown").innerHTML=hiddendowntag;

            }
            if (role < 3 || Avo.admin_code == 0) {

                $.ajax({
                    url: "/adminPages/selectmlist",
                    type: "POST",
                    data: Data,
                    success: function (r) {
                        var Avo = r.Avo;
                        var members = r.list;  // 회원 목록
                        var pVO = r.pvo;  // 페이징 정보

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
                            if (Avo.role<2||Avo.admin_code==0){
                                tag += "<button class='btn btn-outline-secondary buttonline' type='button' style='flex-shrink: 0;' onclick='userdetail(" + member.usercode + ")'>상세보기</button></div></li>";
                            }else {
                                tag += "<button class='btn btn-outline-secondary buttonline' type='button' style='flex-shrink: 0;' onclick='userdetail(" + ((member.role=="ROLE_USER") ? member.usercode :'"n"' ) + ")'>상세보기</button></div></li>";
                            }
                        });

                        $("#userList").html(tag);

                        // 2. 페이징 정보 렌더링
                        var paginationTag = "";

                        // 이전 버튼
                        if (pVO.nowPage > 1) {
                            paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage - 1) + ", searchType, searchValue,searchType2,searchValue2);'>Previous</a></li>";
                        }

                        // 페이지 번호 출력
                        for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
                            if (p <= pVO.totalPage) {
                                paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:reloadPage(" + p + ", searchType, searchValue,searchType2,searchValue2);'>" + p + "</a></li>";
                            }
                        }

                        // 다음 버튼
                        if (pVO.nowPage < pVO.totalPage) {
                            paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage + 1) + ", searchType, searchValue,searchType2,searchValue2);'>Next</a></li>";
                        }

                        $(".pagination").html(paginationTag);


                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }else{
                alert("권한이 없습니다.");
            }

        }


    })

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
    if (usercode!="n"){
        userCode=usercode;
    }else{
        alert("권한이 없습니다");
        return false;
    }
    document.getElementById("userdetailbackground").style.display="block";
    $.ajax({
        url:"/adminPages/userdetail",
        type:"post",
        data:{usercode:userCode,
            adminusercode:usercode1
        },
        success:function(r){
            var rlist=r.rlist;
            var users=r.mvo;
            var recordlist=r.recordlist;
            var payVo=r.payVo;
            var AdminRole=r.Avo.role;
            var Admincode=r.Avo.admin_code;
            var delete_role=r.Avo.permission_delete;


            var usertag = `<div id='userprofile'><img src="/resources/uploadfile/` + users.profile_img + `"/>`;

            if ((AdminRole<2&&delete_role==1&&users.role!="ROLE_ADMIN" )||Admincode==0  && users.usercode!=104){

                usertag+=`<div><input type="button" value="탈퇴시키기" onclick="userdel(` + users.usercode + `)"></div>`;
            }
                usertag+=`<div>`;
            if (users.is_disabled==0&&users.role=="ROLE_USER"){
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

            }else if(users.role=="ROLE_USER"){
                usertag+=`
                <div>정지된 유저입니다 <br/>
                정지시작:`+users.disabled_start_date+`<br/>
                남은시간:`+users.disabled_date+`</div>
                <button onclick="enableUser(`+users.usercode+`)">정지해제</button>
                    
               
                `;
            } if (Admincode==0){
                if(users.role=="ROLE_USER"){
                    usertag+="<button type='button' onclick='roleUp(\""+users.usercode+"\")'>관리자 승격</button>";
                }else if (users.role=="ROLE_ADMIN"){

                    usertag +="<h2>관리자👑</h2>";
                    if (users.usercode!=104){
                    usertag +="<button type='button' onclick='roleDown(\""+users.usercode+"\",\""+users.nickname+"\")'>관리자 박탈</button>";
                    }
                }
            }


            usertag+= `
                </div>
            </div>
            <div id="userstatus">
                <div class="onelow">
                    <div id="name"><b>이름:</b>`+users.name+`</div>
                    <div id="username"><b>아이디:</b>`+users.username+ `</div>
                </div>
                <div class="onelow">
                    <div id="nickname"><b>닉네임:</b>`+users.nickname+`</div>
                    <div id="birthday"><b>생년월일:</b>`+users.birthdate+`</div>
                </div>
                <div class="onelow">
                    <div id="tel"><b>핸드폰번호:</b>`+users.tel+`</div>
                    <div id="reportcnt"><b>신고당한횟수:</b>`+rlist.length+`</div>
                </div>
                `;

            if (users.zip_code!=null &&(AdminRole<2||Admincode==0)){

                usertag+=`
                    <div class="onelow">
                        <div id="zipcode"><b>우편번호:</b>`+users.zip_code+`</div>
                        <div id="addr"> <b>주소:</b>`+users.addr+` </div>    
                    </div>
                    <div class="onelow">
                        <div id="addrdetail"><b>상세주소:</b>`+users.addr_details+`</div>
                    </div>`;
            }else if (users.zip_code!=null&&(AdminRole<2||Admincode==0)&& users.addr!=null &&users.addr_details!=null){
                if (users.addr.length>5) {
                    var userAddr = users.addr.substring(0, users.addr.length - 5) + '*****';
                }else{
                    userAddr="*****";
                }
                if(users.addr_details.length>5){
                    var addrDetails=users.addr_details.substring(0,users.addr_details-5)+"*****";
                }else{
                    addrDetails="*****";
                }
                var zip_code = users.zip_code.substring(0, 2) + '**' + users.zip_code.substring(4);
                usertag +=`
                    <div class="onelow">
                        <div id="zipcode"><b>우편번호:</b>`+zip_code+`</div>
                        <div id="addr"> <b>주소:</b>`+userAddr+` </div>    
                    </div>
                    <div class="onelow">
                        <div id="addrdetail"><b>상세주소:</b>`+userAddr+`</div>
                    </div>`;
            }else{
                usertag +=`
                    <div class="onelow">
                        <div id="zipcode"><b>우편번호:</b>`+users.zip_code+`</div>
                        <div id="addr"> <b>주소:</b>`+users.addr+` </div>    
                    </div>
                    <div class="onelow">
                        <div id="addrdetail"><b>상세주소:</b>`+users.addr_details+`</div>
                    </div>`;
            }

            
            usertag+=`</div>`;
            document.getElementById("usermain").innerHTML=usertag;
            var totalscore=0;
            recordlist.forEach(function(recordlist){
                totalscore += recordlist.score_change;
            });
            var recordtag="<h1>총점수:"+totalscore+"km</h1><ul>";


            if (recordlist==null || recordlist==""){
                recordtag +="<h2 style='text-align: center; font-size: 13pt;'>아직 기록이 없습니다.</h2>";
            }else{
                recordlist.forEach(function(recordlist){
                    recordtag += "<li> 점수변동 "+recordlist.score_change+"km 현재점수:"+recordlist.now_score+"km 변동일:"+recordlist.changedate.substring(0,10)+"</li>"
                });
            }
            recordtag += "</ul>";
            document.getElementById("userrecord").innerHTML=recordtag;

            var totalamont=0;
            payVo.forEach(function(payVo){
               totalamont +=payVo.total_amount ;
            });
            var paytag="<h1 style='text-align: center'>총결제액:"+totalamont.toLocaleString('ko-KR')+"</h1><ul>";
            if (payVo==null||payVo==""){
                paytag +="<h2 style='text-align: center; font-size: 13pt;'>결제내역이 없습니다</h2>";
            }else{
                payVo.forEach(function(payVo){
                    paytag += "<li><div class='paycontent' style='text-align: center'>대회명:"+payVo.marathon_name;
                    paytag += "결제액:"+(payVo.total_amount).toLocaleString('ko-KR')+"원";
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
    document.getElementById("searchtext").value="";
    reloadPage(1,searchType,searchValue,searchType2,searchValue2);


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
function selectList(role){

    if (role==1) {
        searchType2="role";
        role = "ROLE_ADMIN";
    }else if (role==0){
       ;
        reloadPage(1,null,null,null,null);
        return false;
    }
    else{
        searchType2="role";
        role="ROLE_USER";
    }
    searchValue2=role;
    reloadPage(1,searchType,searchValue,searchType2,searchValue2);
}
function roleUp(code){


    $.ajax({
        url:"/adminPages/roleUp",
        type:"post",
        data:{
            usercode:code
        },
        success:function(r){

            document.getElementById("userdetailbackground").style.display="none";
            userdetail(code);
        },error:function(e){
            console.error(e);
        }

    })
}
function roleDown(code,nickname){
    if (confirm(nickname+"님의 권한을 박탈하시겠습니까?")){
        if(confirm("정말 박탈하시겠습니까?")){
            $.ajax({
                url:"/adminPages/roleDown",
                type:"post",
                data:{
                    usercode:code
                },
                success:function(r){
                    document.getElementById("userdetailbackground").style.display="none";
                    userdetail(code);
                }
                ,error:function(e){
                    console.error(e);
                }
            })
        }
    }
}
function changeOption(){
    document.getElementById("searchtext").focus();
}