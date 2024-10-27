var reportSearchType=null;
var reportSearchValue=null;
var reportSearchType2=null;
var page=0;
var now;
setTimeout(function(){

    loadReportPage(page);

},300);
function loadReportPage(page,reportSearchType,reportSearchType2,reportSearchValue){

    if(page==0){
        page=1;
    }
    var ReportData={
        page:page
    }
    if(reportSearchType && reportSearchValue){
        ReportData.searchKey=reportSearchType;
        ReportData.searchWord=reportSearchValue;
    }
    if(reportSearchType2){
        ReportData.searchKey2=reportSearchType2;

    }
    now=page;
    console.log(page);
    if (usercode1){
        ReportData.usercode=usercode1;
    }
    $.ajax({
        url:"/adminPages/ReportList",
        type:"post",
        data:ReportData,
        success:function(r){
            var ReportList=r.list;
            var pVO=r.pvo;
            var logininfo=r.Avo;
            if (logininfo.role<2 ||logininfo.admin_code==0) {

                var downloadbuttontag=`<input type="button" value="신고리스트받기" onClick="excelDownload()"/>`;
                document.getElementById("downloadbutton").innerHTML = downloadbuttontag;
                document.getElementById("downloadbutton").style.display = "block";

            }
            if(logininfo.role<3||logininfo.admin_code==0){
                var tag = "<li><div id='report_title2'><div class='report_code'>신고번호</div><div  class='username '>신고자 </div><div id='offender_code' class='username'>가해자</div>";
                tag += "<div class='report_reason'>신고사유</div><div class='report_date'>신고일</div>";
                tag += "<div class='report_status'>처리상태</div><div class='process_date'>처리완료일</div>";
                tag += "</div></li>";
                ReportList.forEach(function(report){
                    tag +="<li  onclick='detail(\""+report.report_code+"\")'><div class='report_title3'><div class='report_code'>"+report.report_code+"</div>";
                    tag += "<div class='victim_username username'><div onclick='hideenboxs(\"victim\",\""+report.victim_code+"\")'>"+report.victim_nickname+"</div></div>";

                    tag += "<div class='offender_username username' onclick='hideenboxs(\"offender\",\""+report.offender_code+"\")'>"+report.offender_nickname+"</div>";
                    tag += "<div class='report_reason'>"+report.report_reason+"</div>";
                    tag += "<div class='report_date'>"+report.report_date+"</div>";
                    if (report.report_status==0){
                        report.report_status="접수중";
                        tag += "<div class='report_status'>"+report.report_status+"</div>";
                    }else{
                        report.report_status="처리완료"
                        tag += "<div class='report_status'>"+report.report_status+"</div>";
                    }
                    tag += "<div class='process_date'>";
                    if (report.report_status=="처리완료"){
                        var now = new Date();

                        var year = now.getFullYear();
                        var month = ('0' + (now.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 해줍니다.
                        var day = ('0' + now.getDate()).slice(-2);
                        var hours = ('0' + now.getHours()).slice(-2);
                        var minutes = ('0' + now.getMinutes()).slice(-2);
                        var seconds = ('0' + now.getSeconds()).slice(-2);
                        var formattedTime = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
                        tag += formattedTime+"</div></div></li>";
                    }else{
                        tag += "N/A</div></div></li>";
                    }
                }
                );

                document.getElementById("ReportList").innerHTML = tag;
                var paginationTag="";


                if (pVO.nowPage>1){
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadReportPage(" + (pVO.nowPage - 1) +
                        ", reportSearchType,reportSearchType2,reportSearchValue);'>Previous</a></li>";
                }
                var startPage = Math.max(1, pVO.nowPage - 2); // 시작 페이지
                var endPage = Math.min(startPage + 4, pVO.totalPage); // 끝 페이지

                if (endPage - startPage < 4) {
                    startPage = Math.max(1, endPage - 4); // 시작 페이지가 1보다 작으면 조정
                }
                // 페이지 번호 출력
                for (var p = startPage; p <= endPage; p++) {
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:loadReportPage(" + p
                            + ", reportSearchType,reportSearchType2,reportSearchValue);'>" + p + "</a></li>";
                    }
                }
                if (pVO.nowPage < pVO.totalPage) {

                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadReportPage(" + (pVO.nowPage + 1) +
                        ", reportSearchType,reportSearchType2,reportSearchValue);'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);
            }
        },
        error:function(e){
            console.error(e);
        }
    });
}
function searchbutton(){
    reportSearchType=document.getElementById("reportSearchValue").value;
    reportSearchType2=document.getElementById("reportSearchValue2").value;
    reportSearchValue=document.getElementById("searchtext").value;
    alert(reportSearchType2+":"+reportSearchValue);
    loadReportPage(1,reportSearchType,reportSearchType2,reportSearchValue);


}
//검색할때 input박스에서 엔터누르면 검색되는 함수
function enterKey(event) {

    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
function changeOption(){
    var selectOption= document.getElementById("reportSearchValue2");
    var value=selectOption.value;

    if (value=="report_status"){
        document.getElementById("reportSearchValue").value="all_code";
        document.getElementById("reportSearchValue").style.display="none";
        document.getElementById("searchtext").placeholder = "0:접수중 1:처리완료";
        document.getElementById("searchtext").style.width="400px";
    }
    else{ document.getElementById("searchtext").removeAttribute("placeholder");
        document.getElementById("reportSearchValue").style.display="block";
        document.getElementById("searchtext").style.width="300px";
    }
    document.getElementById("searchtext").focus();
}

function reset(){
    loadReportPage(1);
}
var reports;
function detail(report_code){
    alert(report_code);
    $.ajax({
        url:"/adminPages/reportDetail",
        type:"post",
        data:{
            report_code:report_code
        },
        success:function(r) {
            document.getElementById("reportreply").innerHTML="";
            reports = r.rvo;
            var replys=r.reply;

            var tag ="  <div id=\"reportDetails\"><div style='margin-bottom: 20px;'><h3>상세내역</h3></div>";
            tag+="<div><div class='detailTitle'>신고이유</div><div class='detailContent'>"+reports.report_reason+"</div></div>";
            tag+=" <div><div class='detailTitle'>접수일</div><div class='detailContent'>"+reports.report_date+"</div></div>";
            tag+="  <div>" +
                "<div><div class='detailTitle'>신고자</div><div class='detailContent'>"+reports.victim_nickname+"</div></div>" +
                "<div><div class='detailTitle'>가해자</div><div class='detailContent'>"+reports.offender_nickname+"</div></div>" +
                "</div>";
            tag+="<div><div class='detailTitle'>신고내용</div><div class='detailContent'>"+reports.report_content+"</div></div>";
            if (reports.proof_img!=null){
                tag+=` <div>첨부사진:</div><div style="width:150px;height: 150px">
                <img style="width:150px;height: 150px" src="../resources/uploadReport/`+reports.proof_img+`"></div>`
            }else{
                tag+="<div>첨부사진:없음</div>";
            }
            if (reports.report_status!=1){
                tag+="</div><div class='handleBtn' onclick='reportReply()'>처리하기</div></div>"
            }
            document.getElementById("reportdetailbackground").style.display="block";
            document.getElementById("addreply").style.display="none";
            document.getElementById("reportcontent").innerHTML=tag;
            if (reports.report_status!=1){
            var addreplyTag=` 
            <div id="replyFrm">
                <div style="margin-bottom: 10px;">신고당한횟수:<span style="color: tomato;">`+reports.report_count+`</span></div>
                <div><div>정지</div>
                   <select id="is_disabled" name="is_disabled">
                        <option value="0">무죄</option>
                        <option value="1">7일</option>
                        <option value="2">14일</option>
                        <option value="3">30일</option>
                        <option value="4">영구정지</option>
                    </select>
                </div>
                <div>
                <textarea id="content" name="content"></textarea>
                </div>
                 <div><button style='background-color: #d1ff33' onclick="addreply()">확인</button><button style='background-color: lightgray'>취소</button></div>
            </div>
            `;}
            if (reports.report_status==1){
                var tag=`
                  <div style="margin-top: 10px;"><h4>신고결과</h4></div>
           
                    <div>신고 결과<span style="color: tomato;">`+replys.report_result+`</span></div>
                    <div><div>답변</div><div class="detailContent" style="height: auto;">`+replys.content+`<br/>지금까지 운영자 `+replys.admin_nickname+`었습니다.</div></div>
                    <div>답변작성일:`+replys.process_date+`</div>
                  <!--  <div><div id="updateReply" ><button>확인</button><button>취소</button>
                   </div><button id="updatebutton" onclick="updateReply()">수정</button></div>-->`;

                document.getElementById("reportreply").innerHTML=tag;
            }
            document.getElementById("addreply").innerHTML=addreplyTag;


        }
    });
}

function closedetail(){
    document.getElementById("reportdetailbackground").style.display="none";
}
function reportReply(){

    document.getElementById("addreply").style.display="block";

}
//리플 달기
function addreply(){

    var is_disabled = document.getElementById("is_disabled").value
    var content = document.getElementById("content").value
    console.log("테스트:"+is_disabled);
    console.log("테스트2:"+content);
    var reply={}
    reply=reports;
    reply.is_disabled=is_disabled;
    reply.content=content;
    reply.loginCode=usercode1
    $.ajax({
        url:"/adminPages/ReportReply",
        type:"post",
        data:reply,
        success:function(r){
            console.log("성공");
            var rvo=r.rvo;
            var tag=`
            <div><h3>신고결과</h3></div>
            
            <div>신고 결과:`+rvo.report_result+`</div>
            <div>답변:<div>`+rvo.content+`<br/>지금까지 운영자 `+rvo.admin_nickname+`었습니다</div></div>
            <div>답변작성일:`+rvo.process_date+`</div>
           <!-- <div><div id="updateReply" ><button>확인</button><button>취소</button></div><button id="updatebutton" onclick="updateReply()">수정</button></div>-->`;
            document.getElementById("reportreply").innerHTML=tag;
            document.getElementById("addreply").style.display="none";
            console.log("왜 null이야"+now);
            loadReportPage(now,reportSearchType,reportSearchType2,reportSearchValue);
        }
    });
}
/*
function updateReply(){
    document.getElementById("updateReply").style.display="block";
    document.getElementById("updatebutton").style.display="none";
    var tag=`<div>
        <div>신고당한횟수:<div>`+reports.report_count+`</div></div>
        <div>정지:
            <select id="is_disabled" name="is_disabled">
                <option value="0">무죄</option>
                <option value="1">7일</option>
                <option value="2">14일</option>
                <option value="3">30일</option>
                <option value="4">영구정지</option>
            </select>
        </div>
        <div>
            <textarea id="content" name="content"></textarea>
        </div>
       <!-- <div><button onclick="addreply()">확인</button><button>취소</button></div>-->
    </div>
        `;

}



*/
