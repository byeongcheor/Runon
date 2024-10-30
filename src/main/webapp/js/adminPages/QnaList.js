var qnaSearchType=null;
var qnaSearchValue=null;
var qnaSearchType2=null;
var page=0;
var now;
var cerate;
var deleted;
var edit;
var adminz;
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
                    loadQnaPage(page);
                }else{
                    window.location.href="/";
                }


            }
        })

    }else{
        window.location.href="/";
    }



},300);

function loadQnaPage(page,qnaSearchType,qnaSearchType2,qnaSearchValue){
    if (page==0){
        page=1;
    }
    var QnaData={
        page:page
    }
    if (qnaSearchType&&qnaSearchValue){
        QnaData.searchKey=qnaSearchType;
        QnaData.searchWord=qnaSearchValue;
    }
    if(qnaSearchType2){
        QnaData.searchKey2=qnaSearchType2;
    }
    now=page;
    if (usercode1){
        QnaData.usercode=usercode1;
    }
    $.ajax({
        url:"/adminPages/QnaLists",
        type:"post",
        data:QnaData,
        success:function(r){
            var QnaList=r.QnaList;
            var pVO=r.pvo;
            var admin=r.Avo;
            cerate=r.Avo.permission_add
            deleted=r.Avo.permission_delete;
            adminz=r.Avo.admin_code;
            edit=r.Avo.permission_edit;

            if(admin.role<4||admin.admin_code==0){
                var tag = "<li><div id='qna_title2'><div class='qna_code'>문의번호</div><div  class='nickname '>문의자 </div>";
                tag += "<div class='qna_subject'>제목</div><div class='writedate'>작성일</div>";
                tag += "<div class='qna_status'>처리상태</div><div class='process_date'>처리완료일</div>";
                tag += "</div></li>";
                QnaList.forEach(function(qnalist){
                  tag +="<li  onclick='detail(\""+qnalist.qna_code+"\")'><div class='report_title3'><div class='qna_code'>"+qnalist.qna_code+"</div>";
                    tag += "<div class='nickname'>" +qnalist.nickname+ "</div>";
                    tag += "<div class='qna_subject'>"+qnalist.qna_subject+"</div>";
                    tag += "<div class='writedate'>"+qnalist.writedate+"</div>";
                    if (qnalist.qna_status==0){
                        tag += "<div class='qna_status'>접수중</div>";
                    }
                    else {
                        tag += "<div class='qna_status'>답변완료</div>";
                    }
                    if (qnalist.answer_date!=null&&qnalist.answer_date!=""){
                        tag += "<div class='process_date'>"+qnalist.answer_date+"</div>";
                    }else{
                    tag += "<div class='process_date'>N/A</div>";
                    }
                });
                document.getElementById("QnaList").innerHTML=tag;
                var paginationTag="";


                if (pVO.nowPage>1){
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadQnaPage(" + (pVO.nowPage - 1) +
                        ", qnaSearchType,qnaSearchType2,qnaSearchValue);'>Previous</a></li>";
                }
                var startPage = Math.max(1, pVO.nowPage - 2); // 시작 페이지
                var endPage = Math.min(startPage + 4, pVO.totalPage); // 끝 페이지

                if (endPage - startPage < 4) {
                    startPage = Math.max(1, endPage - 4); // 시작 페이지가 1보다 작으면 조정
                }
                // 페이지 번호 출력
                for (var p = startPage; p <= endPage; p++){
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:loadQnaPage(" + p
                            + ", qnaSearchType,qnaSearchType2,qnaSearchValue);'>" + p + "</a></li>";
                    }
                }
                if (pVO.nowPage < pVO.totalPage) {

                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadQnaPage(" + (pVO.nowPage + 1) +
                        ", qnaSearchType,qnaSearchType2,qnaSearchValue);'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);




            }//success끝
        },
        error:function(e){
           /* console.log("에러발생"+e);*/

        }
    });


}

function searchbutton(){
    qnaSearchType=document.getElementById("reportSearchValue").value;
    qnaSearchType2=document.getElementById("reportSearchValue2").value;
    qnaSearchValue=document.getElementById("searchtext").value;
    /*alert(qnaSearchType+":"+qnaSearchValue);*/
    loadQnaPage(1,qnaSearchType,qnaSearchType2,qnaSearchValue);


}
//검색할때 input박스에서 엔터누르면 검색되는 함수
function enterKey(event) {

    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
function detail(qna_code){
    document.getElementById("qnareply").innerHTML="";
    $.ajax({
        url:"/adminPages/qnaDetail",
        type:"post",
        data: {
            qna_code:qna_code
        },
        success:function(r){
            var qvo=r.qvo;
            var answer=r.AnswerVO;

            var Dtag=`
             <div id="reportDetails">
                <div style="margin-bottom: 20px;"><h3>문의내역</h3></div>
                <div id="report">
                    <div><div>제목</div><div class="detailContent">`+qvo.qna_subject+`</div></div>
                    <div><div>닉네임</div><div class="detailContent">`+qvo.nickname+`</div></div>
                    <div><div>아이디</div><div class="detailContent">`+qvo.username+`</div></div>
                    `;
            if (qvo.qna_status==1){
                Dtag+= `<div><div>접수상태</div><div class="detailContent"><span style="color: tomato">답변완료</span></div></div>`;
            }else{
                Dtag+= `<div><div>접수상태</div><div class="detailContent"><span style="color: tomato">접수중</span></div></div>`;
            }
            Dtag+=`<div><div>접수일</div><div class="detailContent">`+qvo.writedate+`</div></div>
                    <div><div>내용</div>
                        <div class="detailContent" style="height: auto;">`+qvo.qna_content+`</div>
                    </div>
                </div>   
            </div>
            `;
            if (qvo.qna_status==0&&(cerate=="1"||adminz==0)){
                Dtag+="<div><button id='answerbutton' type='button' onclick='answer(\""+qvo.qna_code+"\")'>답변하기</button></div>"
            }else{
                document.getElementById("addreply").innerHTML="";
            }

            if (answer!=null&&answer!=""){
                var answertag= "<div>답변</div><div id='answercontent' class='detailContent'>"+answer.answer_content+"</div>";
                if (edit=="1"||adminz==0){
                   answertag += "<div><button type='button' id='editBtn' onclick='updateanswer(\""+qna_code+"\")'>수정하기</button></div>"


                }
                document.getElementById("qnareply").innerHTML=answertag;
            }
            document.getElementById("qnacontent").innerHTML=Dtag;
            document.getElementById("qnadetailbackground").style.display="block";
            loadQnaPage(now,qnaSearchType,qnaSearchType2,qnaSearchValue);
        },
        error:function(e){
          /*  console.log("예외발생"+e);*/
        }
    });
}
function answer(qna_code) {
    // 확인완료 alert(qna_code);
    document.getElementById("answerbutton").style.display="none";
    var buttonTag= " <div> <textarea id='answercontent' name='answercontent'></textarea> </div> <div> <button type='button' id='insertAnswer' onclick='insertAnswer(\""+qna_code+"\")'>확인</button> </div>";
    document.getElementById("addreply").innerHTML=buttonTag;
}
function insertAnswer(qna_code){
    //확인완료alert(qna_code);
    var content=document.getElementById("answercontent").value;
    //확인완 alert(content);
    
    $.ajax({
        url:"/adminPages/insertAnswer",
        type:"post",
        data:{
            qna_code:qna_code,
            usercode:usercode1,
            content:content
        }
        ,
        success:function(r){

            detail(qna_code);
            loadQnaPage(now,qnaSearchType,qnaSearchType2,qnaSearchValue);

        },
        error:function(e){
            /*console.log("예외발생"+e);*/
        }
    });
}

function reset(){
    loadQnaPage(1);
}
function closedetail(){
    document.getElementById("qnadetailbackground").style.display="none";
}
function updateanswer(qna_code){
    //오는것확인 alert(qna_code);
    var content=document.getElementById("answercontent").innerText;
    document.getElementById("qnareply").innerHTML="";
    var tag=`<div> <textarea id='updatecontent' name='updatecontent'>`+content+`</textarea> 
        </div> <div> <button type='button' id='updateAnswer' onclick='updateAnswer("`+qna_code+`")'>수정하기</button> </div>`
   /* alert(content);*/
    document.getElementById("addreply").innerHTML=tag;


}
function updateAnswer(qna_code){
    var newcontent = document.getElementById("updatecontent").value;
    $.ajax({
           url:"/adminPages/updateAnswer",
           type:"post",
           data:{
               qna_code:qna_code,
               usercode:usercode1,
               content:newcontent

           },
        success:function(r){
            detail(qna_code);
        },
        error:function(e){
           /* console.log(e);*/
        }

       });
}