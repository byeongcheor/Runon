package com.ict.finalproject.controller;

import com.ict.finalproject.dao.AdminPagesDAO;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.AdminPagesService;
import com.ict.finalproject.service.MarathonService;
import com.ict.finalproject.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/adminPages")
public class AdminController {
    @Autowired
    AdminPagesService service;
    @Autowired
    JWTUtil jwtUtil;
    @Autowired
    private AdminPagesDAO adminPagesDAO;
    @Autowired
    MarathonService marathonservice;

    @GetMapping("/adminHome")
    public String admin(Model model){
        return "adminPages/adminHome";

    }
    @GetMapping("memberlist")
    public String memberlist(){

        return "adminPages/memberlist";
    }
    //Members(db)
   @PostMapping("/selectmlist")
   @ResponseBody
   public Map<String, Object> adminPages(
           @RequestParam(value = "page", defaultValue = "1") int page,
           @RequestParam(value = "searchType", required = false) String searchKey,
           @RequestParam(value = "searchValue", required = false) String searchWord,
           @RequestParam(value = "searchType2", required = false) String searchKey2,
           @RequestParam(value = "searchValue2", required = false) String searchWord2,
           @RequestParam(value = "usercode", required = false) int usercode,

           PagingVO pvo) {

       if(searchWord != null){
           if (searchKey.equals("is_disabled") && (searchWord.equals("Y")||searchWord.equals("y"))){
               searchWord="1";
               System.out.println("왔는지 확인");

           }else if (searchKey.equals("is_disabled") &&(searchWord.equals("N")||searchWord.equals("n"))){
               searchWord="0";
           }
       }
       AdminsVO Avo= service.selectAdminRole(usercode);
       Map<String, Object> map = new HashMap<>();
       pvo.setNowPage(page);
       int Record = 15; // 페이지당 레코드 수
       pvo.setOnePageRecord(Record);
       if (searchWord != null && !searchWord.isEmpty()) {
           pvo.setSearchWord(searchWord);
           pvo.setSearchKey(searchKey);
       }
       if (searchKey2 != null && !searchKey2.isEmpty()) {
           pvo.setSearchKey2(searchKey2);
           pvo.setSearchWord2(searchWord2);
       }


       // 검색 여부에 따라 전체 레코드 수 설정
       int totalRecord;
       if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
           totalRecord = service.getTotalRecordWithSearch(pvo); // 검색된 레코드 수
       }else if(pvo.getSearchKey2() != null && !pvo.getSearchKey2().isEmpty()) {
            totalRecord = service.getTotalRecordWithSearch(pvo);
       }else {
           totalRecord = service.getTotalRecord(); // 전체 레코드 수
       }

       pvo.setTotalRecord(totalRecord);
       int totalPage = (int) Math.ceil((double) totalRecord / Record);
       pvo.setTotalPage(totalPage);
       pvo.setOffset((pvo.getNowPage() - 1) * pvo.getOnePageRecord());

       // 검색 여부에 따라 회원 목록 가져오기
       List<MemberVO> memList;
       if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
           memList = service.selectUserWithSearch(pvo); // 검색된 회원 목록 조회
       }else if(pvo.getSearchKey2() != null && !pvo.getSearchKey2().isEmpty()) {
           memList = service.selectUserWithSearch(pvo);
       }
       else {
           memList = service.selectAllUser(pvo); // 전체 회원 목록 조회
       }

       map.put("list", memList);
       map.put("pvo", pvo);
       map.put("Avo", Avo);
       return map;
   }

    //정보받아서 엑셀로 뽑기(db)
    @PostMapping("/uListDownload")
    @ResponseBody
    public Map<String,Object> uListDownload(){
        Map<String, Object> map = new HashMap<String, Object>();
        String role ="ROLE_USER";
        List<MemberVO> memList = service.selectMembers(role);
        map.put("list", memList);
        return map;
    }

    //유저상세페이지 db
    @PostMapping("userdetail")
    @ResponseBody
    public Map<String,Object> userdetail(@RequestParam("usercode") int usercode,
                                        @RequestParam("adminusercode")int adminusercode){
        System.out.println(usercode);
        //유저 인적사항
        Map<String,Object> map=new HashMap<String,Object>();
        //유저전적
        List<RecordVO>recordlist=service.getRecord(usercode);
        System.out.println(recordlist);
        MemberVO mvo=service.selectOneUser(usercode);
        //유저가 결제한 내용
        List<AdminPaymentVO> payVo =service.selectInPay(usercode);
        System.out.println(payVo);
        //신고당한횟수확인이랑 해당 신고리스트로 이동
        List<ReportVO> rlist = service.getUserReport(usercode);
        AdminsVO Avo=service.selectAdminRole(adminusercode);
        System.out.println(Avo);
        map.put("mvo", mvo);
        map.put("recordlist", recordlist);
        map.put("rlist", rlist);
        map.put("payVo", payVo);
        map.put("Avo", Avo);
        return map;
    }
    //유저탈퇴
    @PostMapping("/deluser")
    @ResponseBody
    public int deluser(@RequestParam("usercode") int usercode){
        //System.out.println("오는값확인"+usercode);확인
        int result=service.insertAndDel(usercode);

        return result;
    }
    //유저 정지
    @PostMapping("/disableUser")
    @ResponseBody
    public int disableuser(@RequestParam("usercode") int usercode,
                           @RequestParam("disableday")int disableday){
        int result= service.setDisableUserTime(usercode,disableday);

        return result;
    }
    //유저 오정지 풀어주기
    @PostMapping("/enableUser")
    @ResponseBody
    public int enableUser(@RequestParam("usercode")int usercode){

        int result =service.setEnableUser(usercode);

        return result;
    }
    //선택된 인원 엑셀 다운로드
    @PostMapping("/selectExcel")
    @ResponseBody
    public Map<String,Object> selectExcel(@RequestBody Map<String,Object> Rusercodes){
        List<String> usercodes=(List<String>) Rusercodes.get("usercodes");
        List<MemberVO> selectedMembers=service.selectedMembers(usercodes);
        Map<String,Object> map=new HashMap<>();
        map.put("list", selectedMembers);
        return map;


    }
    // 관리자 리스트가기
    @GetMapping("/adminlist")
    public String adminlist(){
       return "adminPages/adminlist";
    }
    // 관리자 리스트 (db)
    @PostMapping("/adminlist")
    @ResponseBody
    public Map<String,Object> adminlist(
            @RequestParam(value = "page",defaultValue = "1")int page,
            @RequestParam(value = "adminSearchType",required = false)String searchKey,
            @RequestParam(value = "adminSearchValue",required = false)String searchWord,
            @RequestParam(value = "usercode",required = false)Integer usercode,
            @RequestParam(value = "adminSearchType2",required = false)String searchKey2,
            @RequestParam(value = "adminSearchValue2",required = false)String searchWord2,
            PagingVO pvo

    ){
        System.out.println(searchKey);
        System.out.println(searchWord);



        if (searchWord != null && !searchWord.isEmpty()) {
            if (searchKey.equals("role")){
                if (searchWord.equals("SUPER_ADMIN")||searchWord.equals("0")||searchWord.equals("SUPER")) {
                    searchWord="0";
                    System.out.println(searchWord);
                }else if (searchWord.equals("ADMIN")||searchWord.equals("1")) {
                    searchWord="1";
                    System.out.println(searchWord);
                }else if (searchWord.equals("MODERATOR")||searchWord.equals("2")||searchWord.equals("MD")) {
                    searchWord="2";
                    System.out.println(searchWord);
                }else if(searchWord.equals("SUPPORT")||searchWord.equals("3")||searchWord.equals("SUP")) {
                    searchWord="3";
                    System.out.println(searchWord);
                }else{
                    searchWord="4";
                }
            }else if (searchKey.equals("permission_edit") ||
                    searchKey.equals("permission_add") ||
                    searchKey.equals("permission_delete")||
                    searchKey.equals("is_disabled")) {
                if (searchWord.equals("Y")||searchWord.equals("y")) {
                    searchWord = "1";
                } else if (searchWord.equals("N")||searchWord.equals("n")) {
                    searchWord = "0";
                }else{
                    searchWord="3";
                }
            }
            pvo.setSearchWord(searchWord);
            pvo.setSearchKey(searchKey);
        }
        if(searchKey2 != null && !searchKey2.isEmpty()) {
            pvo.setSearchKey2(searchKey2);
            pvo.setSearchWord2(searchWord2);

        }


        Map<String, Object> map = new HashMap<>();
       if(usercode!=null) {
           int usercodevlaue=usercode.intValue();
           AdminsVO AdminRole = service.selectAdminRole(usercodevlaue);
           map.put("Avo", AdminRole);

       }


        pvo.setNowPage(page);
        int Record = 15;
        pvo.setOnePageRecord(Record);

        int totalRecord;
        if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
            totalRecord=service.getSearchAdminTotalRecord(pvo);
        }else if(pvo.getSearchKey2() != null && !pvo.getSearchKey2().isEmpty()) {
            totalRecord=service.getSearchAdminTotalRecord(pvo);
        }
        else{
            totalRecord=service.getAdminTotalRecord();
        }
        pvo.setTotalRecord(totalRecord);
        int totalPage = (int) Math.ceil((double) totalRecord / Record);
        pvo.setTotalPage(totalPage);
        pvo.setOffset((pvo.getNowPage()-1)*pvo.getOnePageRecord());

        List<AdminsVO> adminsList;
        if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
            adminsList=service.selectAdminWithSearch(pvo);
            System.out.println("확인용");
        }else if(pvo.getSearchKey2() != null && !pvo.getSearchKey2().isEmpty()) {
            adminsList=service.selectAdminWithSearch(pvo);
        }
        else{

            adminsList=service.selectAllAdmin(pvo);


        }

        map.put("list", adminsList);
        map.put("pvo", pvo);
        return map;


    }
    //관리자 정보 엑셀로 담기
    @PostMapping("/AdminListDownload")
    @ResponseBody
    public  Map<String,Object> AdminListDownload(){
       Map<String,Object> map=new HashMap<>();
       String role="ROLE_ADMIN";
       List<MemberVO>list=service.selectMembers(role);
       map.put("list", list);
       return map;
    }
    //관리자 업데이트
    @PostMapping("/AdminRoleUpdate")
    @ResponseBody
    public int AdminRoleUpdate(AdminsVO vo){
        System.out.println(vo);

          service.updateRole(vo);
        return 1;
    }
    //Members에서 관리자 권한체크
    @PostMapping("/RoleCheck")
    @ResponseBody
    public Map<String,Object> RoleCheck(AdminsVO vo){
       System.out.println(vo.getUsercode());
       AdminsVO Avo=service.selectAdminRole(vo.getUsercode());
       System.out.println(Avo);
       Map<String,Object> map=new HashMap<>();
       map.put("Avo", Avo);
       return map;
    }
    //Members에서 유저를 관리자로 승격
    @PostMapping("/roleUp")
    @ResponseBody
    public int roleUp(@RequestParam("usercode")int usercode,AdminsVO Avo,MemberVO mvo){
        Avo.setUsercode(usercode);
        mvo.setUsercode(usercode);
        int result=service.UpdateUser(Avo,mvo);

        return result;
    }
    //Members에서 관리자를 유저로 강등
    @PostMapping("/roleDown")
    @ResponseBody
    public int roleDown(@RequestParam("usercode")int usercode,MemberVO mvo,AdminsVO Avo){
        Avo.setUsercode(usercode);
        mvo.setUsercode(usercode);
        int result = service.roleDown(mvo,Avo);

        return result;
    }
    //신고관리 접속
    @GetMapping("/ReportList")
    public String ReportList(){
        return "adminPages/ReportList";
    }
    //신고관리 db
    @PostMapping("/ReportList")
    @ResponseBody
    public Map<String,Object> ReportLists(
        PagingVO pvo,@RequestParam(value = "usercode",required = false) Integer usercode,
        @RequestParam(value = "page",defaultValue = "1")int page){

        Map<String,Object> map=new HashMap<>();
        if (usercode !=null){
            int usercodevlaue=usercode.intValue();
            AdminsVO AdminRole = service.selectAdminRole(usercodevlaue);
            map.put("Avo", AdminRole);
        }
        pvo.setNowPage(page);
        int Record = 15;
        pvo.setOnePageRecord(Record);
        int totalRecord;
        if(pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
            totalRecord=service.getSearchReportRecord(pvo);
        }else if(pvo.getSearchKey2() != null && !pvo.getSearchKey2().isEmpty()) {
            totalRecord=service.getSearchReportRecord(pvo);
        }else{
            totalRecord=service.getReportTotalRecord();
        }
        pvo.setTotalRecord(totalRecord);
        int totalPage = (int) Math.ceil((double) totalRecord / Record);
        pvo.setTotalPage(totalPage);
        pvo.setOffset((pvo.getNowPage()-1)*pvo.getOnePageRecord());
        List<ReportVO> ReportList;
        if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
            ReportList=service.selectReportWithSearch(pvo);
        }else if(pvo.getSearchKey2() != null && !pvo.getSearchKey2().isEmpty()) {
            ReportList=service.selectReportWithSearch(pvo);
        }else{
            ReportList=service.selectAllReport(pvo);
        }
        map.put("list", ReportList);
        map.put("pvo", pvo);

        return map;
    }

    @PostMapping("/getUserHistory")
    @ResponseBody
    public Map<String,Object> getUserHistory(@RequestParam("period")String period){
        Map<String,Object> map=new HashMap<>();
        List<AllCountVO> CountList= service.getVisitorsByDateRange(period);

        map.put("list", CountList);

        return map;
    }

    @PostMapping("/adminCharts")
    @ResponseBody
    public Map<String,Object> marathonCount(){
        Map<String,Object> map=new HashMap<>();
        List<MarathonCountVO>McountList=service.getCountregistration();

        List<MemCountVO>MemCountList=service.getCountMemlist();
        map.put("MemList",MemCountList);
        map.put("list", McountList);


        return map;
    }
    @PostMapping("/AgeCount")
    @ResponseBody
    public Map<String,Object> AgeCount(@RequestParam( value = "gender",required = false)String gender){
        Map<String,Object> map=new HashMap<>();
        List<AgeCountVO> genderAgeCount=service.GenderAgeCount(gender);
        map.put("GAClist",genderAgeCount);
        return map;
    }
    @PostMapping("/joinsUser")
    @ResponseBody
    public Map<String,Object> JoinsUser(){
        List<JoinsCountVO> JClist= service.JClist();
        Map<String,Object> map=new HashMap<>();
        map.put("JClist",JClist);

        return map;
    }
    @PostMapping("/newPayment")
    @ResponseBody
    public Map<String,Object> NewPayment(@RequestParam(value="usercode",required = false)Integer usercode){
        Map<String,Object> map=new HashMap<>();
        // 완료 System.out.println(usercode);
        if (usercode!=null){
            int usercodevlaue=usercode.intValue();
            AdminsVO Avo=service.selectAdminRole(usercodevlaue);
        // 완료 System.out.println("Avo"+Avo);
            map.put("Avo", Avo);
        }
        List<QnAVO> QnaList=service.getQnaList();
        List<AdminPaymentVO>APaylist=service.getNewPayment();
        map.put("APaylist",APaylist);
        map.put("qnalist",QnaList);
        // 확인완료 System.out.println(QnaList);
        // 확인완료 System.out.println("최근 결제내역확인용"+APaylist);
        return map;
    }
    @PostMapping("/yearsTop5Marathon")
    @ResponseBody
    public Map<String,Object> YearsTop5Marathon(@RequestParam(value = "year",required = false)Integer year){
        Map<String,Object> map=new HashMap<>();
        int yearvlaue=0;
        if (year!=null){
             yearvlaue=year.intValue();

        }
        List<YearsTop5MarathonVO>YT5Mlist=service.getYearsTop5list(yearvlaue);
        System.out.println(YT5Mlist);
        map.put("YT5Mlist",YT5Mlist);
        return map;
    }
    @PostMapping("/amountCharts")
    @ResponseBody
    public Map<String,Object> AmountCharts(){
        Map<String,Object> map=new HashMap<>();
        List<AdminPaymentVO>APcountList=service.getCountAPlist();
        map.put("APlist", APcountList);

        return map;

    }

    @PostMapping("/reportDetail")
    @ResponseBody
    public Map<String,Object>reportDetail(@RequestParam("report_code")int report_code){
        Map<String,Object> map=new HashMap<>();
        ReportVO rvo=service.getReportDetail(report_code);
        ReportReplyVO RRvo=service.getReportReplys(report_code);
        System.out.println(RRvo);
        map.put("rvo",rvo);
        map.put("reply",RRvo);
        return map;
    }
    @PostMapping("/ReportReply")
    @ResponseBody
    public Map<String,Object>ReportReply(ReportVO rvo,@RequestParam("loginCode")int usercode){
        Map<String,Object> map=new HashMap<>();
        System.out.println(rvo);
        System.out.println(usercode);
        ReportReplyVO result = service.updateReport(rvo,usercode);
        map.put("rvo",result);
        return map;
    }
    //페이지이동
    @GetMapping("/CertificateList")
    public String CertificateList(){
        return "adminPages/CertificateList";
    }
    @PostMapping("/loadCertificateList")
    @ResponseBody
    public Map<String,Object> loadCertificateList(PagingVO pvo,
                                                  @RequestParam(value="usercode",required = false)Integer usercodeValue,
                                                  @RequestParam(value="page",defaultValue = "1")int page){
        System.out.println("K1"+pvo.getSearchKey2());
        System.out.println("K2"+pvo.getSearchKey());
        System.out.println("V"+pvo.getSearchWord());
        Map<String,Object> map=new HashMap<>();
        if(usercodeValue!=null){
            int usercode=usercodeValue.intValue();
            AdminsVO Avo=service.selectAdminRole(usercode);
            map.put("Avo", Avo);

        }
        pvo.setNowPage(page);
        int Record=15;
        pvo.setOnePageRecord(Record);
        int totalRecord;
        if (pvo.getSearchWord()!=null&&!pvo.getSearchWord().isEmpty()){
            totalRecord=service.getCertificaterecode(pvo);
        }else if(pvo.getSearchKey2()!=null&&!pvo.getSearchKey2().isEmpty()){
            totalRecord=service.getCertificaterecode(pvo);
        }else{
            totalRecord=service.getCertificateTotalRecord(pvo);
        }
        pvo.setTotalRecord(totalRecord);
        int totalPage=(int) Math.ceil((double)totalRecord/Record);
        pvo.setTotalPage(totalPage);
        pvo.setOffset((pvo.getNowPage()-1)*pvo.getOnePageRecord());
        List<CertificateVO> Cvo;
        if(pvo.getSearchWord()!=null&&!pvo.getSearchWord().isEmpty()){
            Cvo=service.selectWithSearchCertificateList(pvo);
        }else if(pvo.getSearchKey2()!=null&&!pvo.getSearchKey2().isEmpty()){
            Cvo=service.selectWithSearchCertificateList(pvo);
        }else{
            Cvo=service.selectAllCertificateList(pvo);
        }
        map.put("Cvo",Cvo);
        map.put("pvo",pvo);


        return map;
    }
    @PostMapping("/certificateDetail")
    @ResponseBody
    public Map<String,Object> certificateDetail(@RequestParam("certificate_code")int certificate_code){
        Map<String,Object> map=new HashMap<>();
        CertificateVO Cvo=service.getCertificateDetail(certificate_code);
        map.put("Cvo",Cvo);
        System.out.println("크루확인"+Cvo);
        return map;
    }
    @PostMapping("/recordPointUpdate")
    @ResponseBody
    public Map<String,Object> recordPointUpdate(@RequestParam("certificate_code")int certificate_code,
                                                @RequestParam("selectedValue")int record,
                                                @RequestParam(value = "crew_member_code", required = false, defaultValue = "0")int crewMemberCode){
        Map<String,Object> map=new HashMap<>();
        if (crewMemberCode!=0){
            int crew_member_code=crewMemberCode;
            int a=service.updatecrewRecordPoint(record,certificate_code,crew_member_code);
            map.put("a",a);
        }else{
            int a =service.updateRecordPoint(record,certificate_code);
            map.put("a",a);
        }
        return map;
    }

    @GetMapping("/PaymentList")
    public String GoPaymentList(){

        return "adminPages/PaymentList";
    }
    @PostMapping("/PaymentList")
    @ResponseBody
    public Map<String,Object>PaymentList(PagingVO pvo,
                                         @RequestParam(value="usercode",required = false)Integer usercodeValue,
                                         @RequestParam(value = "page",defaultValue = "1")int page){
        Map<String,Object> map=new HashMap<>();
        System.out.println("검색어"+pvo.getSearchWord());
        System.out.println("분류"+pvo.getSearchKey());
        System.out.println("정렬"+pvo.getSort());
        System.out.println("뭘로정렬할지"+pvo.getSchedule());
        if (usercodeValue!=null){
            int usercode=usercodeValue.intValue();
            AdminsVO Avo=service.selectAdminRole(usercode);
            map.put("Avo", Avo);
        }
        System.out.println("접속자"+usercodeValue);
        pvo.setNowPage(page);
        int Record=15;
        pvo.setOnePageRecord(Record);
        int totalRecord;
        if (pvo.getSearchWord()!=null&&!pvo.getSearchWord().isEmpty()){
            totalRecord=service.getSearchPaymentRecord(pvo);
        }else{
            totalRecord=service.getPaymentRecord(pvo);
        }
        pvo.setTotalRecord(totalRecord);
        int totalPage=(int) Math.ceil((double)totalRecord/Record);
        pvo.setTotalPage(totalPage);
        pvo.setOffset((pvo.getNowPage()-1)*pvo.getOnePageRecord());
        System.out.println("페이징"+pvo);
        List<PaymentVO> Payvo;
        if (pvo.getSearchWord()!=null&&!pvo.getSearchWord().isEmpty()){
            Payvo=service.getPaymentSearchList(pvo);
        }else{
            Payvo=service.getPaymentList(pvo);
        }
        System.out.println("제발"+Payvo);
        map.put("pvo",pvo);
        map.put("Payvo",Payvo);
        return map;
    }
    @GetMapping("/QnaList")
    public String QnaList(){
        return "adminPages/QnaList";
    }
    @PostMapping("/QnaLists")
    @ResponseBody
    public Map<String,Object>QnaLists(PagingVO pvo,
                                      @RequestParam(value = "usercode",required = false)Integer usercodeValue,
                                      @RequestParam(value="page",defaultValue = "1")int page){
        Map<String,Object> map=new HashMap<>();
        if(usercodeValue!=null){
            int usercode=usercodeValue.intValue();
            AdminsVO Avo=service.selectAdminRole(usercode);
            map.put("Avo", Avo);
        }
        pvo.setNowPage(page);
        int Record=15;
        pvo.setOnePageRecord(Record);
        int totalRecord;
        if (pvo.getSearchWord()!=null&&!pvo.getSearchWord().isEmpty()){
            totalRecord=service.getSearchQnaRecord(pvo);
        }else if (pvo.getSearchKey2()!=null&&!pvo.getSearchKey2().isEmpty()){
            totalRecord=service.getSearchQnaRecord(pvo);
        }else{
            totalRecord=service.getQnaRecord();
        }
        pvo.setTotalRecord(totalRecord);
        pvo.setOffset((pvo.getNowPage()-1)*pvo.getOnePageRecord());
        List<QnAVO> QnaList=new ArrayList<>();
            if (pvo.getSearchWord()!=null&&!pvo.getSearchWord().isEmpty()){
                QnaList=service.getSearchQnaLists(pvo);
            }else  if (pvo.getSearchKey2()!=null&&!pvo.getSearchKey2().isEmpty()){
                QnaList=service.getSearchQnaLists(pvo);
            }else{
                QnaList=service.getQnaLists(pvo);
            }
            map.put("QnaList",QnaList);
            map.put("pvo",pvo);
        System.out.println(QnaList);
        return map;
    }
    @PostMapping("/qnaDetail")
    @ResponseBody
    public Map<String,Object> qnaDetail(@RequestParam(value = "qna_code",required = false)int qna_code){
        Map<String,Object> map=new HashMap<>();
        QnAVO qvo=service.getQnaDetail(qna_code);
        AnswerVO AnswerVO=service.getAnswer(qna_code);
        map.put("qvo",qvo);
        map.put("AnswerVO",AnswerVO);
        return map;
    }

    @PostMapping("/insertAnswer")
    @ResponseBody
    public Map<String,Object> insertAnswer(@RequestParam("qna_code")int qna_code,
                                           @RequestParam("usercode")int usercode,
                                           @RequestParam("content")String content){
        Map<String,Object> map=new HashMap<>();
        service.insertAnswer(qna_code,usercode,content);


        return map;
    }
    @PostMapping("/updateAnswer")
    @ResponseBody
    public Map<String,Object> updateAnswer(@RequestParam("qna_code")int qna_code,
                                           @RequestParam("usercode")int usercode,
                                           @RequestParam("content")String content){
        Map<String,Object> map=new HashMap<>();
        service.updateAnswer(qna_code,usercode,content);

        return map;
    }
 //관리자페이지 게시물관리
    @GetMapping("/boardList")
    public String boardList(){return "adminPages/boardList";}


    @PostMapping("/BoardList")
    @ResponseBody
    public Map<String,Object> boardLists(
            PagingVO pvo,@RequestParam(value = "usercode",required = false) Integer usercode,
            @RequestParam(value = "page",defaultValue = "1")int page){

        System.out.println("K1"+pvo.getSearchKey());
        System.out.println("W"+pvo.getSearchWord());

        Map<String, Object> map = new HashMap<>();
        if (usercode != null) {
            int usercodeValue = usercode.intValue();
            AdminsVO adminRole = service.selectAdminRole(usercodeValue);
            map.put("Avo", adminRole);
        }
        System.out.println("V2");
        pvo.setNowPage(page);
        int record = 15;
        pvo.setOnePageRecord(record);

        int totalRecord;

        // 검색어와 검색 키를 확인하여 총 레코드 수를 계산합니다.
        // 검색어와 검색 키를 확인하여 총 레코드 수를 계산합니다.
        if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
            if (pvo.getSearchKey() != null && pvo.getSearchKey().equals("marathon_name")) {
                // 마라톤명으로 검색
                totalRecord = service.getSearchBoardRecord(pvo);
            } else if (pvo.getSearchKey().equals("is_active") || pvo.getSearchKey().equals("is_deleted")) {
                // 활성화 또는 삭제 여부 검색
                totalRecord = service.getSearchBoardRecord(pvo);
            } else {
                totalRecord = service.getBoardTotalRecord(); // 유효하지 않은 검색 키인 경우 전체 레코드 수
            }
        } else {
            totalRecord = service.getBoardTotalRecord(); // 전체 게시글 수
        }

        System.out.println("V3");


        pvo.setTotalRecord(totalRecord);
        int totalPage = (int) Math.ceil((double) totalRecord / record);
        pvo.setTotalPage(totalPage);
        pvo.setOffset((pvo.getNowPage() - 1) * pvo.getOnePageRecord());

        List<MarathonListVO> BoardList;

        // 검색 조건에 따른 처리
        if (pvo.getSearchKey() != null && pvo.getSearchWord() != null) {
            BoardList = service.selectBoardWithSearch(pvo); // 마라톤명 검색
        } else {
            BoardList = service.selectAllBoard(pvo); // 모든 게시글 검색
        }

        System.out.println("V4");
        map.put("list", BoardList);
        map.put("pvo", pvo);
        System.out.println(pvo);
        System.out.println(BoardList);

        return map;
    }

    @GetMapping("/marathon/marathonDetail/{marathonCode}")
    public String marathonDetail(@PathVariable("marathonCode") int marathonCode) {
        return "marathon/marathonDeatail";
    }

    @GetMapping("/boardEdit/marathonCode/{marathonCode}")
    public String editMarathon(@PathVariable("marathonCode") int marathonCode, Model model) {
        MarathonListVO marathonDetail = marathonservice.getMarathonDetail(marathonCode);  // 마라톤 정보 가져오기


        System.out.println("마라톤 코드: " + marathonCode); // 로그로 마라톤 코드 확인
        model.addAttribute("marathonDetail", marathonDetail);  // 마라톤 정보를 모델에 추가
        model.addAttribute("latitude", marathonDetail.getLat()); // 위도
        model.addAttribute("longitude", marathonDetail.getLon()); // 경도

        return "adminPages/boardEdit";  // 수정 페이지 경로 설정
    }

    @PostMapping("/marathon/update")
    public String updateMarathon(
            @RequestParam("marathonCode") int marathonCode,
            @RequestParam("marathonName") String marathonName,
            @RequestParam("event_date") String eventDate,
            @RequestParam("addr") String addr,
            @RequestParam("total_distance") String totalDistance,
            @RequestParam("entry_fee") String entryFee,
            @RequestParam("registration_start_date") String registrationStartDate,
            @RequestParam("registration_end_date") String registrationEndDate,
            @RequestParam("marathonContent") String marathonContent,
            @RequestParam("latitude") String latitude, // 위도 추가
            @RequestParam("longitude") String longitude, // 경도 추가
            @RequestParam(value = "posterImage", required = false) MultipartFile posterImage,
            HttpServletRequest request, Model model) {

        // 이미지 파일 업로드 처리
        String posterPath = null;
        if (posterImage != null && !posterImage.isEmpty()) {
            try {
                // 서버 상대 경로 설정
                String uploadDir = request.getServletContext().getRealPath("/img/marathonPoster/");

                // 업로드 디렉토리가 없으면 생성
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                // 파일 이름 중복 방지를 위해 새로운 파일 이름 생성 (현재 시간 기반)
                String newFilename = System.currentTimeMillis() + "_" + posterImage.getOriginalFilename();

                // 이미지 파일 저장 경로 설정
                File file = new File(uploadDir + newFilename);
                posterImage.transferTo(file);

                // 저장된 파일 경로를 저장 (웹에서 접근 가능한 경로로 변경)
                posterPath =   newFilename;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // MarathonListVO 객체에 데이터 설정
        MarathonListVO marathon = new MarathonListVO();
        marathon.setMarathon_code(marathonCode);
        marathon.setMarathon_name(marathonName);
        marathon.setEvent_date(eventDate);
        marathon.setAddr(addr);
        marathon.setTotal_distance(totalDistance);
        marathon.setEntry_fee(entryFee);
        marathon.setRegistration_start_date(registrationStartDate);
        marathon.setRegistration_end_date(registrationEndDate);
        marathon.setMarathon_content(marathonContent);
        marathon.setLat(latitude); // 위도 설정
        marathon.setLon(longitude); // 경도 설정

        if (posterPath != null) {
            marathon.setPoster_img(posterPath); // 이미지 파일 경로 설정
        }

        // 마라톤 정보 업데이트 서비스 호출
        marathonservice.updateMarathon(marathon);

        // 수정 후 마라톤 상세 페이지로 리다이렉트
        return "redirect:/marathon/marathonDetail/"  + marathonCode + "?success";
    }

    @PostMapping("/delete/{marathonCode}")
    @ResponseBody
    public MarathonListVO deleteMarathon(@PathVariable("marathonCode") int marathonCode) {
        MarathonListVO marathon = marathonservice.getMarathonByCode(marathonCode);
        if (marathon != null) {
            boolean isDeleted = marathonservice.deleteMarathon(marathonCode);
            if (isDeleted) {
                System.out.println(isDeleted);
                return marathon;  // 삭제된 마라톤 정보를 반환
            }
        }
        return null;  // 삭제 실패 또는 마라톤을 찾지 못한 경우
    }
    // 글 작성 페이지로 이동하는 메서드 (GET 방식)
    @GetMapping("/writePost")
    public String showWritePostPage(Model model) {
        MarathonListVO marathonListVO = new MarathonListVO();
        // 필요한 데이터 설정 또는 서비스 호출
        model.addAttribute("marathonList", marathonListVO);
        return "adminPages/boardWrite";
    }

    @PostMapping("/writePostSubmit")
    public String submitWritePost(
            @ModelAttribute MarathonListVO marathonListVO,
            @RequestParam(value = "posterImage", required = false) MultipartFile posterImage,
            HttpServletRequest request) {

        // 이미지 파일 업로드 처리 (이 부분은 동일)
        String posterPath = null;

        if (posterImage != null && !posterImage.isEmpty()) {
            try {
                String uploadDir = request.getServletContext().getRealPath("/img/marathonPoster/");
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                String newFilename = System.currentTimeMillis() + "_" + posterImage.getOriginalFilename();
                File file = new File(uploadDir + newFilename);
                posterImage.transferTo(file);
                posterPath = newFilename;
            } catch (IOException e) {
                e.printStackTrace();
                return "파일 업로드 실패";
            }
        }

        // DB에 저장할 때 이미지 경로 설정
        if (posterPath != null) {
            marathonListVO.setPoster_img(posterPath);
        }
        // 위도와 경도 설정
        marathonListVO.setLat(request.getParameter("latitude")); // 위도
        marathonListVO.setLon(request.getParameter("longitude")); // 경도

        // DB에 저장하는 로직 호출
        marathonservice.saveMarathon(marathonListVO);

        // 글 작성 후 목록으로 리다이렉트
        return "redirect:/adminPages/boardList";
    }
    //미리톤 게시글 엑셀로 담기
    @PostMapping("/boardListDownload")
    @ResponseBody
    public  Map<String,Object> boardListDownload(){
        Map<String, Object> map = new HashMap<>();
        List<MarathonListVO> list = service.selectMarathons(); // 마라톤 목록을 가져오는 메서드 호출
        map.put("list", list);
        return map;
    }


}
