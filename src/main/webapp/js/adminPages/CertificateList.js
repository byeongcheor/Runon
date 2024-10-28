var CertificateSearchType=null;
var CertificateSearchValue=null;
var CertificateSearchType2=null;
var cerate;
var deleted;
var edit;
var page=0;
var now;

setTimeout(function(){
    if (usercode1!=null &&usercode1!=0 &&usercode1!=""){
        $.ajax({
            url:"/adminPages/checkuser",
            type:"post",
            data:{
                usercode:usercode1
            },success:function(r){
                var role=r.role;
                if (role!="ROLE_USER"){
                    CertificateList(page);
                }else{
                    window.location.href="/";
                }


            }
        })

    }else{
        window.location.href="/";
    }


},400);
function CertificateList(page,CertificateSearchType,CertificateSearchType2,CertificateSearchValue){
    if (page==0){
        page=1;
    }
    var CeriticateData={
        page:page
    }
    now=page
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
            cerate=r.Avo.permission_add;
            deleted=r.Avo.permission_delete;
            edit=r.Avo.permission_edit;
         /*   if (avo.role<2 ||avo.admin_code==0) {

                var downloadbuttontag=`<input type="button" value="인증신청리스트받기" onClick="excelDownload()"/>`;
                document.getElementById("downloadbutton").innerHTML = downloadbuttontag;
                document.getElementById("downloadbutton").style.display = "block";

            }*/ if(avo.role<4||avo.admin_code==0){
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


                if (pVO.nowPage>1){
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:CertificateList(" + (pVO.nowPage - 1) +
                        ", CertificateSearchType,CertificateSearchType2,CertificateSearchValue);'>Previous</a></li>";
                }
                var startPage = Math.max(1, pVO.nowPage - 2); // 시작 페이지
                var endPage = Math.min(startPage + 4, pVO.totalPage); // 끝 페이지

                if (endPage - startPage < 4) {
                    startPage = Math.max(1, endPage - 4); // 시작 페이지가 1보다 작으면 조정
                }
                for (var p = startPage; p <= endPage; p++) {
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
    /*alert(CertificateSearchType+":"+CertificateSearchValue);*/
    CertificateList(1,CertificateSearchType,CertificateSearchType2,CertificateSearchValue);


}
function detail(certificate_code){
  /*  alert(certificate_code);*/
    $.ajax({
        url:"/adminPages/certificateDetail",
        type:"post",
        data:{
            certificate_code:certificate_code
        },
        success:function(r){
            var Cvo=r.Cvo;
            /*console.log(Cvo.result_status);*/

            var tag=`
                <div style="margin-bottom: 20px;"><h3>상세내역</h3></div>
                <div id="Certificate">
                    <div><div>제목</div><div class="detailContent">`+Cvo.content+`</div></div>
                    <div><div>접수일</div><div class="detailContent">`+Cvo.application_date+`</div></div>
                    <div><div>신청자</div><div class="detailContent">`+Cvo.nickname+`</div></div>`;
            if (Cvo.crew_member_code!=0) {
                tag += `<div><div>참여유형</div><div class="detailContent">크루</div></div>
                        <div><div>크루명</div><div class="detailContent">OOO크루</div></div>`;
            }else{
                tag += `<div><div>참여유형</div><div class="detailContent">개인</div></div>`;
            }
                    tag +=`<div><div>인증사진</div><div style="margin-bottom: 20px;"> <img style="width:150px;height: 150px; border-radius: 10px;" src="../resources/uploadCertificate/`+Cvo.proof_photo+`"></div></div>
                </div>
               
            `;
            document.getElementById("CertificateDetails").innerHTML=tag;
            document.getElementById("Certificatedetailbackground").style.display="block";
            if (Cvo.result_status=="처리중"){
                if (cerate=="1"&&edit=="1"&&deleted=="1") {
                    var buttonTag = "<button type='button' id='approveBtn' onclick='blockbutton(\"" + certificate_code + "\",\"" + Cvo.crew_member_code + "\")'>승인하기</button>";
                    var selectTag = `  <div>
                       <label class="form-label">점수부여</label>

                        <div id="radiobuttons">
                            <input type="radio" id="value10" name="point" value="10" />
                            <label class="form_label" for="value10">10Km</label>
                            <input type="radio" id="value20" name="point" value="20" />
                            <label class="form_label" for="value20">20Km</label>
                            <input type="radio" id="value30" name="point" value="30" />
                            <label class="form_label" for="value30">30Km</label>
                            <input type="radio" id="value40" name="point" value="30" />
                            <label class="form_label" for="value40">40Km</label>
                        </div>
                    </div>`;
                    document.getElementById("certificate").innerHTML = selectTag;
                    document.getElementById("addButton").innerHTML = buttonTag;
                }

            }else{   document.getElementById("Certificatedetailbackground").style.display="block";                document.getElementById("addButton").innerHTML=buttonTag;
                document.getElementById("addButton").innerHTML="";

                document.getElementById("certificate").innerHTML="<div class='detailContent' style='margin-top: 20px; color:darkblue;'>인증이 완료된 신청입니다</div>";

            }
        }
    })

}
function blockbutton(certificate_code,crew_member_code){
    const selectedValue = getSelectedRadioValue();
   /* console.log("Selected radio value is: " + selectedValue);
    console.log(crew_member_code);*/
    var datas={certificate_code:certificate_code,
        selectedValue:selectedValue

    }
    if (crew_member_code!=0){
        datas.crew_member_code=crew_member_code;
    }
    $.ajax({
        url:"/adminPages/recordPointUpdate",
        type:"post",
        data:datas,
        success:function(r){
         /*   console.log(r);*/
            if (r.a!=0){
                document.getElementById("certificate").innerHTML="<div style='margin-top: 20px; color: tomato;'>인증이 완료된 신청입니다</div>";
                document.getElementById("addButton").innerHTML="";
                CertificateList(now,CertificateSearchType,CertificateSearchType2,CertificateSearchValue);

            }
            alert("성공적으로 인증을 완료시켰습니다");
        }
    });

}

function getSelectedRadioValue() {
    const selectedRadio = document.querySelector('input[name="point"]:checked');
    return selectedRadio ? selectedRadio.value : null; // 선택된 값이 있으면 반환, 없으면 null
}

function reset(){
    CertificateList(1);
}