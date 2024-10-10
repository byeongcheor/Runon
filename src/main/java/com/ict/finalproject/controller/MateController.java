package com.ict.finalproject.controller;
import java.util.Date;
import java.util.List;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.MateService;
import com.ict.finalproject.vo.MateVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/mate")
public class MateController {
    @Autowired
    MateService service;
    JWTUtil jwtUtil;
    String user_name ="";
    int    user_code = 0;

    @PostMapping("/test")
    @ResponseBody
    public String test(@RequestParam("Authorization") String token) {
        System.out.println("테스트"+token);
        if (token!=null&&!token.isEmpty()){
        token=token.substring("Bearer ".length());
        System.out.println("123123123");
        try {
            user_name = jwtUtil.setTokengetUsername(token);
            System.out.println("Username from Token: " + user_name);
        } catch (Exception e) {
            System.out.println("Error parsing token: " + e.getMessage());
            e.printStackTrace(); // 전체 스택 트레이스 확인
        }
        return user_name;}
        return null;
    }
    @GetMapping("/mate")
    public String matchingList(MateVO vo, HttpServletRequest request, Model model){//
        try {
            user_code = service.usercodeSelect(user_name);
            List<MateVO> ranking = service.ranking();
            List<MateVO> userselect = service.userselect(user_code);
            vo.setMatch_yn(service.match_yn(user_code));
            System.out.println(userselect);
            model.addAttribute("ranking",ranking);
            model.addAttribute("vo",vo);
            model.addAttribute("userselect",userselect);

        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return "mate/mate";
    }

    @GetMapping("/profileList")
    public ModelAndView profileList() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mate/profileList");
        return mav;
    }

    @PostMapping("/more")
    @ResponseBody
    public List<MateVO> more(int more){
        List<MateVO> list = service.more(more);
        return list;
    }
    @PostMapping("/matching")
    @ResponseBody
    public int  matching(int marathonValue,String participationCountValue,int mateCountValue, Model model) {
        //participationCountValue 다시 봐야됨
        //int user_code = 4;//유저코드
        int matching_room_code=0;
        try {
            matching_room_code = service.matching_select(marathonValue, participationCountValue, mateCountValue);
            if (matching_room_code == 0) {
                service.matching_insert_room(marathonValue, participationCountValue, mateCountValue);//방 만들기
                matching_room_code = service.matching_select(marathonValue, participationCountValue, mateCountValue);
            }
            service.applicant_insert(matching_room_code, user_code);//방입장
            service.matching_room_personnel_update_plus(matching_room_code);//현재인원수 증가

        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return matching_room_code;
    }

    @PostMapping("/match_view")
    @ResponseBody
    public List<MateVO>  matching(int matching_room_code, Model model) {
        //int user_code = 4;//유저코드
        List<MateVO> room_list = null;
        try {
            room_list = service.match_view(matching_room_code);

        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return room_list;
    }
    @PostMapping("/match_out")
    @ResponseBody
    public int  match_out(int matching_room_code) {
        // int user_code = 4;//유저코드
        int a=0;
        try {
            service.match_out(matching_room_code, user_code);
            service.matching_room_personnel_update_minus(matching_room_code);
            service.matching_room_personnel_zero_delete();
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return a;
    }

    @PostMapping("/accept")
    @ResponseBody
    public int  accept(int matching_room_code) {
        // int user_code = 4;//유저코드
        int a=0;
        try {
            service.accept(matching_room_code, user_code);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        //수락하기 하면 2명이상이고 최대인원수가 안차도 모두 수락을 눌렀을 때 완전매칭이 된다.
        return a;
    }
    // 수락거절
    @PostMapping("/accept_n")
    @ResponseBody
    public int  accept_n(int matching_room_code) {
        // int user_code = 4;//유저코드
        int a=1;
        try {
            service.accept_n(matching_room_code, user_code);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        //수락하기 하면 2명이상이고 최대인원수가 안차도 모두 수락을 눌렀을 때 완전매칭이 된다.
        return a;
    }

    @PostMapping("/profile_click")
    @ResponseBody
    public int  profile_click(int profileValue ,int usercode) {
        //int user_code = 4;//유저코드
        int profile=0;
        try {
            service. profile_click(profileValue, usercode);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        //수락하기 하면 2명이상이고 최대인원수가 안차도 모두 수락을 눌렀을 때 완전매칭이 된다.
        return profile;
    }

    @PostMapping("/mate_complite")
    @ResponseBody
    public int  mate_complite(int matching_room_code) {
        // int user_code = 4;//유저코드
        int a=1;
        try {
            service.mate_complite(matching_room_code, user_code);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        //수락하기 하면 2명이상이고 최대인원수가 안차도 모두 수락을 눌렀을 때 완전매칭이 된다.
        return a;
    }

    @PostMapping("/marathon_code")
    @ResponseBody
    public List<MateVO> marathon_code(){
        // int user_code = 4;//유저코드
        List<MateVO> list = service.marathon_code_list(user_code);
        return  list;
    }

    @PostMapping("/hide7days")
    @ResponseBody
    public void hide7days(@RequestParam("Authorization")String token, int num){
        service.hide7daysAdd(user_code,num);
    }

    @PostMapping("/neverShow")
    @ResponseBody
    public void neverShow(@RequestParam("Authorization")String token, int num){
        service.neverShow(user_code,num);
    }

    @PostMapping("/mate_popup_date_select")
    @ResponseBody
    public Date  mate_popup_date_select(@RequestParam("Authorization")String token) {
        Date mate_popup_date= service.mate_popup_date_select(user_code);
    return mate_popup_date;
    }
}
