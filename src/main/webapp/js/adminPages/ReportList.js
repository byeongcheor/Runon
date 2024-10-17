var reportSearchType=null;
var reportSearchValue=null;
var reportSearchType2=null;

setTimeout(function(){
   var page;
    loadReportPage(page);

},300);
function loadReportPage(page,reportSearchType,reportSearchType2,reportSearchValue){

    if(page==null){
        page=1;
    }
    var ReportData={
        page:page
    }
    if(reportSearchType && reportSearchValue){
        ReportData.searchKey=reportSearchType;
        ReportData.searchWord=reportSearchValue;
    }
    if(reportSearchType2 && reportSearchValue2){
        ReportData.searchKey2=reportSearchType2;

    }

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
                    tag +="<li><div class='report_title3'><div class='report_code'>"+report.report_code+"</div>";
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
                if (pVO.nowpage>1){
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadReportPage(" + (pVO.nowPage - 1) +
                        ", reportSearchType,reportSearchType2,reportSearchValue);'>Previous</a></li>";
                }
                for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
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
//닉네임 클릭시 함수 호출
// var viccount=0;
// var offcount=0;
// function hideenboxs(type,usercode){
//
//
//     if (type === "victim") {
//         viccount++;
//         console.log(viccount);
//         if (viccount%2==1){
//             var hiddenDiv = document.querySelector(".hiddendiv"); // hiddendiv 요소 선택
//             hiddenDiv.style.display = "block"; // 요소를 표시 (display: block)
//         }else{
//             var hiddenDiv = document.querySelector(".hiddendiv"); // hiddendiv 요소 선택
//             hiddenDiv.style.display = "none";
//         }
//     } else if (type === "offender") {
//         offcount++;
//         if (offcount%2==1){
//
//             var hiddenDiv = document.querySelector(".hiddendiv"); // hiddendiv 요소 선택
//             hiddenDiv.style.display = "block"; // 요소를 표시 (display: block)
//         }else{
//             var hiddenDiv = document.querySelector(".hiddendiv"); // hiddendiv 요소 선택
//             hiddenDiv.style.display = "none";
//
//         }
//     }
// }
function reset(){
    loadReportPage(1);
}