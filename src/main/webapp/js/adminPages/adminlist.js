var adminSearchType=null;
var adminSearchValue=null;
var adminSearchType2=null;
var adminSearchValue2=null;
setTimeout(function(){
    var page;
    if (usercode1!=null &&usercode1!=0 &&usercode1!=""){
        $.ajax({
            url:"/adminPages/checkuser",
            type:"post",
            data:{
                usercode:usercode1
            },success:function(r){
                var role=r.role;
                if (role!="ROLE_USER"){
                    loadAdminPage(page);
                }else{
                    window.location.href="/";
                }


            }
        })

    }else{
        window.location.href="/";
    }



                    },100);
function loadAdminPage(page,adminSearchType,adminSearchValue,adminSearchType2,adminSearchValue2){
    cnt=0;
    if(page==null){
        page=1;
    }
    var AdminData={
        page:page
    }
    if (adminSearchType&& adminSearchValue){
        AdminData.adminSearchType=adminSearchType;
        AdminData.adminSearchValue=adminSearchValue;
    }
    if(adminSearchType2 &&adminSearchValue2 ){
        AdminData.adminSearchValue2=adminSearchValue2;
        AdminData.adminSearchType2=adminSearchType2;
    }
    if(usercode1){
        AdminData.usercode=usercode1;
    }
    $.ajax({
        url:"/adminPages/adminlist",
        type:"post",
        data:AdminData,
        success:function(r){
            var admins=r.list;
            var pVO=r.pvo;
            var loginAdminRole=r.Avo.role;
            var loginId=r.Avo.admin_code;

            var edit=r.Avo.permission_edit;

            if (loginAdminRole<2 ||loginId==0) {
                //권한 수정  새로고침
                var buttontag = '<button type="button" className="clickbox" onClick="blockhidden()">권한수정</button>';
                buttontag += '<button type="button" className="clickbox" onClick="refresh()">새로고침</button>';
                document.getElementById("checkboxlist").innerHTML = buttontag;
                document.getElementById("checkboxlist").style.display = "block";
                //재직자 퇴사자구분
                var selectbutton = '<button type="button" onclick="inOut(\`0\`)">재직자</button><button onclick="inOut(\`1\`)" type="button">퇴사자</button>';
                document.getElementById("selectbutton").innerHTML = selectbutton;
                document.getElementById("selectbutton").style.display = "block";

                //전체 인원 엑셀 다운로드
                var downloadbuttontag=`<input type="button" value="전체관리자정보받기" onClick="excelDownload()"/>`;
                document.getElementById("downloadbutton").innerHTML = downloadbuttontag;
                document.getElementById("downloadbutton").style.display = "block";

                //리스트 시작
                var tag = "<li><div id='usertitle2'><div class='username '>아이디 </div><div class='name'>이름</div>";
                tag += "<div class='role'>등급</div><div class='permission_add'>쓰기권한</div><div class='permission_edit'>수정권한</div>";
                tag += "<div class='permission_delete'>삭제권한</div><div class='created_date'>입사일</div>";
                tag += "<div class='deleted_date'>퇴사일</div><div class='buttonline'></div></div></li>";
                admins.forEach(function (admin) {
                    if (admin.permission_add == 1) {
                        admin.permission_add = "Y";
                    } else {
                        admin.permission_add = "N";
                    }
                    if (admin.permission_edit == 1) {
                        admin.permission_edit = "Y";
                    } else {
                        admin.permission_edit = "N";
                    }
                    if (admin.permission_delete == 1) {
                        admin.permission_delete = "Y";
                    } else {
                        admin.permission_delete = "N";
                    }
                    if (admin.role == 0) {
                        admin.role = "SUPER_ADMIN";
                    } else if (admin.role == 1) {
                        admin.role = "ADMIN";
                    } else if (admin.role == 2) {
                        admin.role = "MODERATOR";
                    } else if (admin.role == 3) {
                        admin.role = "SUPPORT";
                    }
                    if (admin.deleted_date != null) {
                        admin.deleted_date = admin.deleted_date.substring(0, 10);
                    } else {
                        admin.deleted_date = "N/A";
                    }
                    tag += "<li><div class='usertitle3'><input type='hidden' value='" + admin.admin_code + "' />";
                    tag += "<div class='username'>" + admin.username + "</div><div class='name'>" + admin.name + "</div>";
                    if ((loginAdminRole == 0 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0) {
                        tag += "<div class='AdminRole'><select class='updated_role'>";
                        tag += "<option value='0'" + (admin.role === 'SUPER_ADMIN' ? " selected" : "") + ">SUPER_ADMIN</option>";
                        tag += "<option value='1'" + (admin.role === 'ADMIN' ? " selected" : "") + ">ADMIN</option>";
                        tag += "<option value='2'" + (admin.role === 'MODERATOR' ? " selected" : "") + ">MODERATOR</option>";
                        tag += "<option value='3'" + (admin.role === 'SUPPORT' ? " selected" : "") + ">SUPPORT</option></select></div>";
                    } else {

                    }
                    tag += "<div class='role " + ((loginAdminRole == 0 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0 ? "premissions" : "") + "'>";
                    tag += admin.role + "</div>";
                    if ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0) {
                        tag += "<div class='updateRole'><select class='updated_add'>";
                        tag += "<option value='Y'" + (admin.permission_add === 'Y' ? " selected" : "") + " >Y</option>";
                        tag += "<option value='N'" + (admin.permission_add === 'N' ? " selected" : "") + ">N</option></select></div>";
                    }
                    tag += "<div class='permission_add " + ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0 ? "premissions" : "") + "'>" + admin.permission_add + "</div>";
                    if ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0) {
                        tag += "<div class='updateRole'><select class='updated_edit'>";
                        tag += "<option value='Y'" + (admin.permission_edit === 'Y' ? " selected" : "") + ">Y</option>";
                        tag += "<option value='N'" + (admin.permission_edit === 'N' ? " selected" : "") + ">N</option></select></div>"
                    }
                    tag += "<div class='permission_edit " + ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0 ? "premissions" : "") + "'>" + admin.permission_edit + "</div>";
                    if ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0) {
                        tag += "<div class='updateRole'><select class='updated_delete'>";
                        tag += "<option value='Y'" + (admin.permission_delete === 'Y' ? " selected" : "") + ">Y</option>";
                        tag += "<option value='N'" + (admin.permission_delete === 'N' ? " selected" : "") + ">N</option></select></div>";
                    }
                    tag += "<div class='permission_delete " + ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0 ? "premissions" : "") + "'>" + admin.permission_delete + "</div>";

                    tag += "<div class='created_date'>" + admin.created_date.substring(0, 10) + "</div>";
                    if ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0) {
                        tag += "<div class='updateDelDate'><select class='updated_Deldate'>";
                        tag += "<option value='Y'" + (admin.deleted_date != 'N/A' ? " selected" : "") + " >Y</option>";
                        tag += "<option value='N'" + (admin.deleted_date === 'N/A' ? " selected" : "") + ">N</option></select></div>";
                    }
                    tag += "<div class='deleted_date " + ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0 ? "premissions" : "") + "'>" + admin.deleted_date + "</div>";
                    tag += "<button style='display: none' " + ((edit == 1 && loginId != admin.admin_code && admin.role != "SUPER_ADMIN") || loginId == 0 ? "id='saveRole'" : "") + " class='btn btn-outline-secondary buttonline' type='button' style='flex-shrink: 0;' onclick='adminRoleUpdate(" + admin.admin_code +`,"`+admin.usercode+'"'+ ")'>저장</button></div></li>";


                });
                $("#AdminList").html(tag);


                // 2. 페이징 정보 렌더링
                var paginationTag = "";

                // 이전 버튼
                if (pVO.nowPage > 1) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadAdminPage(" + (pVO.nowPage - 1) + ", adminSearchType, adminSearchValue);'>Previous</a></li>";
                }

                // 페이지 번호 출력
                var startPage = Math.max(1, pVO.nowPage - 2); // 시작 페이지
                var endPage = Math.min(startPage + 4, pVO.totalPage); // 끝 페이지

                if (endPage - startPage < 4) {
                    startPage = Math.max(1, endPage - 4); // 시작 페이지가 1보다 작으면 조정
                }
                // 페이지 번호 출력
                for (var p = startPage; p <= endPage; p++) {
                    if (p <= pVO.totalPage) {
                        paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:loadAdminPage(" + p + ", adminSearchType, adminSearchValue);'>" + p + "</a></li>";
                    }
                }

                // 다음 버튼
                if (pVO.nowPage < pVO.totalPage) {
                    paginationTag += "<li class='page-item'><a class='page-link' href='javascript:loadAdminPage(" + (pVO.nowPage + 1) + ", adminSearchType, adminSearchValue);'>Next</a></li>";
                }

                $(".pagination").html(paginationTag);


            } else {

                document.getElementById("checkboxlist").style.display = "none";
                document.getElementById("downloadbutton").style.display = "none";
                alert("권한이 없습니다.");
            }
        }
    });
}


var cnt=0;
function blockhidden(){
    cnt++;
    document.querySelectorAll('#saveRole,.updateDelDate ,.updateRole, .premissions,.AdminRole').forEach(function(element) {
        if (element.classList.contains('premissions')) {
            // premissions 클래스는 반대로 처리
            if (cnt % 2 == 1) {
                element.style.display = "none"; // 숨기기
            } else {
                element.style.display = "block"; // 보이기
            }
        } else {
            // hiddenbox, updateRole 클래스 처리
            if (cnt % 2 == 1) {
                element.style.display = "block"; // 보이기
            } else {
                element.style.display = "none"; // 숨기기
            }
        }
    });


}
//검색하기
function searchbutton(){
    adminSearchType=document.getElementById("adminSearchValue").value;
    adminSearchValue=document.getElementById("searchtext").value;
/*    alert(adminSearchType+":"+adminSearchValue);*/
    loadAdminPage(1,adminSearchType,adminSearchValue,adminSearchType2,adminSearchValue2);
    document.getElementById("searchtext").value="";


}
//검색할때 input박스에서 엔터누르면 검색되는 함수
function enterKey(event) {

    if (event.key === 'Enter') {
        event.preventDefault();
        document.getElementById('searchbutton').click();
    }
}
function refresh(page){
    adminSearchType2=null;
    adminSearchValue2=null;
    adminSearchType=null;
    adminSearchValue=null;
    adminSearchType=document.getElementById("adminSearchValue").value;
    adminSearchValue=document.getElementById("searchtext").value;
    cnt=0;
    loadAdminPage(1,adminSearchType,adminSearchValue,adminSearchType2,adminSearchValue2);

}
function excelDownload(){
    $.ajax({
        url:"/adminPages/AdminListDownload",
        type:"post",
        success:function(r){
            /*console.log("서버에서 받아온 값 ",r);*/
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
function adminRoleUpdate(admincode,usercode){
    var adminElement = document.querySelector(`input[type='hidden'][value='${admincode}']`).closest('li');
    // 변경된 role 값 가져오기
    var role = adminElement.querySelector('.updated_role').value;
    // 변경된 permission_add 값 가져오기
    var permission_add = adminElement.querySelector('.updated_add').value;
    // 변경된 permission_edit 값 가져오기
    var permission_edit = adminElement.querySelector('.updated_edit').value;
    // 변경된 permission_delete 값 가져오기
    var permission_delete = adminElement.querySelector('.updated_delete').value;
    // 변경된 updated_Deldate 값 가져오기
    var updated_Deldate = adminElement.querySelector('.updated_Deldate').value;

    if (permission_add=="Y"){
        permission_add=1;
    }else{
        permission_add=0;
    }
    if(permission_edit=="Y"){
        permission_edit=1;
    }else{
        permission_edit=0;
    }
    if (permission_delete=="Y"){
        permission_delete=1;
    }else{
        permission_delete=0;
    }
    //값가져오는지 전부 확인 완료
    $.ajax({
        url:"/adminPages/AdminRoleUpdate",
        type:"post",
        data:{
            role:role,
            permission_add:permission_add,
            permission_delete:permission_delete,
            permission_edit:permission_edit,
            admin_code:admincode,
            is_deleted:updated_Deldate,
            usercode:usercode
        },
        success:function(r){
          /*  alert(adminSearchType);
            alert(adminSearchValue+"1"+adminSearchType2+"3"+adminSearchValue2);*/

            loadAdminPage(1,adminSearchType,adminSearchValue,adminSearchType2,adminSearchValue2);

        },error:function(e){
            console.error(e);
        }
    });
}
function inOut(inOut){

    adminSearchValue2=inOut;
    adminSearchType2="is_deleted";
    loadAdminPage(1,adminSearchType,adminSearchValue,adminSearchType2,adminSearchValue2);
}
function changeOption(){
    document.getElementById("searchtext").focus();
}