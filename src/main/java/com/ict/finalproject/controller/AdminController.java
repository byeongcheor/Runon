package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.AdminPagesService;
import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.PagingVO;
import com.ict.finalproject.vo.RecordVO;
import com.ict.finalproject.vo.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLOutput;
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

    @GetMapping("/adminHome")
    public String admin(Model model){
        return "adminPages/adminHome";

    }
    @GetMapping("memberlist")
    public String memberlist(){

        return "adminPages/memberlist";
    }
    @PostMapping("/selectmlist")
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
        //크루전적
        MemberVO mvo=service.selectOneUser(usercode);
        //신고당한횟수확인이랑 해당 신고리스트로 이동
        List<ReportVO> rlist = service.getUserReport(usercode);
        map.put("mvo", mvo);
        map.put("recordlist", recordlist);
        map.put("rlist", rlist);
        return map;
    }
}
