var CertificateSearchType=null;
var CertificateSearchValue=null;
var CertificateSearchType2=null;
var page=0;
var now;
setTimeout(function(){
    CertificateList(page);

},400);
function CertificateList(page,CertificateSearchType,CertificateSearchType2,CertificateSearchValue){
    if (page==0){
        page=1;
    }
    var CeriticateData={
        page:page
    }
    if (CertificateSearchType&&CertificateSearchValue){
        CeriticateData.searchKey=CertificateSearchType;
        CeriticateData.searchWord=CertificateSearchValue;
    }
    if (CertificateSearchType2){
        CeriticateData.searchKey2=CertificateSearchType2;
    }
    if (usercode1){
        CeriticateData.usercode=usercode1;
    }
    $.ajax({
        url:"/adminPages/loadCertificateList",
        type:"post",
        data:CeriticateData,
        success:function(r){
            var Cvo=r.Cvo;
            var pVO=r.pvo;
            var avo=r.Avo;

            if (avo.role<2 ||avo.admin_code==0) {

                var downloadbuttontag=`<input type="button" value="인증신청리스트받기" onClick="excelDownload()"/>`;
                document.getElementById("downloadbutton").innerHTML = downloadbuttontag;
                document.getElementById("downloadbutton").style.display = "block";

            } if(avo.role<4||avo.admin_code==0){
                var tag = "<li>" +
                    "<div id='report_title2'>" +
                        "<div class='certificate_code'>고유번호</div>" +
                        "<div  class='username '>신청자 </div>" +
                        "<div id='content' class='content'>제목</div>";
                tag +=  "<div class='application_date'>신청일</div>" +
                        "<div class='result_status'>처리상태</div>";
                tag += "<div class='result_date'>처리완료일</div>";
                tag += "</div></li>";
                Cvo.forEach(function(Cvo){
                    var result_date=Cvo.result_date;
                    tag +="<li  onclick='detail(\""+Cvo.certificate_code+"\")'>" +
                                "<div class='report_title3'>" +
                                    "<div class='certificate_code'>"+Cvo.certificate_code+"</div>";
                    tag +=          "<div class='username'>"+Cvo.nickname+"</div>";
                    tag += "<div class='content'>"+Cvo.content+"</div>";
                    tag += "<div class='application_date'>"+Cvo.application_date+"</div>";
                    tag += "<div class='result_status'>"+Cvo.result_status+"</div>";
                    if (Cvo.result_date==null){
                        result_date="N/A";
                    }
                    tag += "<div class='result_date'>"+result_date+"</div></div></li>";
                });
                document.getElementById("CertificateList").innerHTML=tag;
                var paginationTag="";


                if (pVO.nowpage>1){
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:CertificateList(" + (pVO.nowPage - 1) +
                        ", CertificateSearchType,CertificateSearchType2,CertificateSearchValue);'>Previous</a></li>";
                }
                for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:CertificateList(" + p
                            + ",CertificateSearchType,CertificateSearchType2,CertificateSearchValue);'>" + p + "</a></li>";
                    }
                }
                if (pVO.nowPage < pVO.totalPage) {

                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:CertificateList(" + (pVO.nowPage + 1) +
                        ", CertificateSearchType,CertificateSearchType2,CertificateSearchValue);'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);
            }
        },
        error:function(e){
            console.error(e);
        }


    });


}

function closedetail(){
    document.getElementById("Certificatedetailbackground").style.display="none";
}

function enterKey(event) {

    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
function searchbutton(){
    CertificateSearchType=document.getElementById("CertificateSearchValue").value;
    CertificateSearchType2=document.getElementById("CertificateSearchValue2").value;
    CertificateSearchValue=document.getElementById("searchtext").value;
    alert(CertificateSearchType+":"+CertificateSearchValue);
    CertificateList(1,CertificateSearchType,CertificateSearchType2,CertificateSearchValue);


}
function detail(certificate_code){
    alert(certificate_code);
    $.ajax({
        url:"/adminPages/certificateDetail",
        type:"post",
        data:{
            certificate_code:certificate_code
        },
        success:function(r){
            var Cvo=r.Cvo;
            var tag=`
                <div><h3>상세내역</h3></div>
                <div id="Certificate">
                    <div>제목:`+Cvo.content+`</div>
                    <div>접수일:`+Cvo.application_date+`</div>
                    <div>신청자:`+Cvo.nickname+`</div>
                    
                    <div>인증사진:<div> <img style="width:150px;height: 150px" src="../resources/uploadCertificate/`+Cvo.proof_photo+`"></div></div>
                </div>
                <div onclick="updaterecordPoint('`+Cvo.username+`')"></div> 
            `;
            document.getElementById("CertificateDetails").innerHTML=tag;
            document.getElementById("Certificatedetailbackground").style.display="block";
            var buttonTag="<button type='button' onclick='blockbutton()'>승인하기</button>";
        }
    })


}