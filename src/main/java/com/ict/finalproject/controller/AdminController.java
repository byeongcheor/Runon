package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.AdminPagesService;
import com.ict.finalproject.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.lang.reflect.Member;
import java.sql.SQLOutput;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/adminPages")
public class AdminController {
    @Autowired
    AdminPagesService service;
    @Autowired
    JWTUtil jwtUtil;

    @GetMapping("/adminHome")
    public String admin(Model model){
        return "adminPages/adminHome";

    }
    @GetMapping("memberlist")
    public String memberlist(){

        return "adminPages/memberlist";
    }
   /* @PostMapping("/selectmlist")
    @ResponseBody
    public Map<String,Object> adminPages(@RequestParam("page")int page, PagingVO pvo){
        System.out.println("컨트롤러확인");
        Map<String, Object> map = new HashMap<String, Object>();
        pvo.setNowPage(page);
        int Record = 15;
        pvo.setOnePageRecord(Record);
        int totalRecord = service.getTotalRecord();
        pvo.setTotalRecord(totalRecord);
        int totalpage = (int) Math.ceil((double) totalRecord / Record);
        pvo.setTotalPage(totalpage);
        pvo.setOffset((pvo.getNowPage() - 1) * pvo.getOnePageRecord());
        List<MemberVO> memList = service.selectAllUser(pvo);
        System.out.println("리스트확인");
        map.put("list", memList);
        map.put("pvo", pvo);
        return map;

    }*/
   @PostMapping("/selectmlist")
   @ResponseBody
   public Map<String, Object> adminPages(
           @RequestParam(value = "page", defaultValue = "1") int page,
           @RequestParam(value = "searchType", required = false) String searchKey,
           @RequestParam(value = "searchValue", required = false) String searchWord,
           PagingVO pvo) {
       System.out.println("W"+searchWord);
       System.out.println("K"+searchKey);
       System.out.println("컨트롤러 확인");
       if(searchWord != null){
           if (searchKey.equals("is_disabled") && searchWord.equals("Y")){
               searchWord="1";
               System.out.println("왔는지 확인");

           }else if (searchKey.equals("is_disabled") &&searchWord.equals("N")){
               searchWord="0";
           }
       }
       Map<String, Object> map = new HashMap<>();
       pvo.setNowPage(page);
       int Record = 15; // 페이지당 레코드 수
       pvo.setOnePageRecord(Record);
       if (searchWord != null && !searchWord.isEmpty()) {
           pvo.setSearchWord(searchWord);
           pvo.setSearchKey(searchKey);
       }


       // 검색 여부에 따라 전체 레코드 수 설정
       int totalRecord;
       if (pvo.getSearchWord() != null && !pvo.getSearchWord().isEmpty()) {
           totalRecord = service.getTotalRecordWithSearch(pvo); // 검색된 레코드 수
       } else {
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
       } else {
           memList = service.selectAllUser(pvo); // 전체 회원 목록 조회
       }

       map.put("list", memList);
       map.put("pvo", pvo);

       return map;
   }


    @PostMapping("/uListDownload")
    @ResponseBody
    public Map<String,Object> uListDownload(){
        Map<String, Object> map = new HashMap<String, Object>();
        List<MemberVO> memList = service.selectMembers();
        map.put("list", memList);
        return map;
    }
//    @PostMapping("/adminCheck")
//    @ResponseBody
//    public Map<String,Object> adminCheck(@RequestParam("token")String token){
//        Map<String, Object> map = new HashMap<String, Object>();
//        if(!token.isEmpty() && token!=null&&token!=""){
//            String role =jwtUtil.getRole(token);
//            map.put("role", role);
//            return map;
//        }
//        map.put("role",0);
//        return map;
//
//    }

    @PostMapping("userdetail")
    @ResponseBody
    public Map<String,Object> userdetail(@RequestParam("usercode") int usercode){
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
        map.put("mvo", mvo);
        map.put("recordlist", recordlist);
        map.put("rlist", rlist);
        map.put("payVo", payVo);
        return map;
    }

    @PostMapping("/deluser")
    @ResponseBody
    public int deluser(@RequestParam("usercode") int usercode){
        //System.out.println("오는값확인"+usercode);확인
        int result=service.insertAndDel(usercode);
        System.out.println(result);
        return result;
    }
    @PostMapping("/disableUser")
    @ResponseBody
    public int disableuser(@RequestParam("usercode") int usercode,
                           @RequestParam("disableday")int disableday){
        int result= service.setDisableUserTime(usercode,disableday);

        return result;
    }
    @PostMapping("/enableUser")
    @ResponseBody
    public int enableUser(@RequestParam("usercode")int usercode){
        System.out.println(usercode);
        System.out.println("확인용1");
        int result =service.setEnableUser(usercode);
        System.out.println("왜안오ㅏ"+result);
        return result;
    }
    //검색
//    @PostMapping("searchUser")
//    @ResponseBody
//    public Map<String,Object> searchUser(@RequestParam("searchType")String type,
//                                         @RequestParam("searchValue")String value){
//        Map<String,Object> map=new HashMap<>();
//        List<MemberVO> mlist=service.searchUser(type,value);
//        map.put("list", mlist);
//        return map;
//    }
    @PostMapping("/selectExcel")
    @ResponseBody
    public Map<String,Object> selectExcel(@RequestBody Map<String,Object> Rusercodes){
        List<String> usercodes=(List<String>) Rusercodes.get("usercodes");
        List<MemberVO> selectedMembers=service.selectedMembers(usercodes);
        Map<String,Object> map=new HashMap<>();
        map.put("list", selectedMembers);
        return map;


    }




}
