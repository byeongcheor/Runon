package com.ict.finalproject.controller;
import java.util.Date;
import java.util.List;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.MateService;
import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.MateVO;
import com.ict.finalproject.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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

    @PostMapping("/go_mypage")
    @ResponseBody
    public String go_mypage(@RequestParam("Authorization")String token,HttpSession session) {
        if(token.equals("A")) return user_name= "A";
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        // 서비스 호출 (int 값을 파라미터로 전달)
        int user_code = service.usercodeSelect(userName);  // 주입이 아닌 메서드 파라미터로 전달
        session.setAttribute("Authorization", token);
        session.setAttribute("user_code", user_code);
        return "success";
    }

    @PostMapping("/go_mate")
    @ResponseBody
    public String go_mate(@RequestParam("Authorization")String token,HttpSession session) {
        if(token.equals("A")) return user_name= "A";

        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);

        // 서비스 호출 (int 값을 파라미터로 전달)
        int user_code = service.usercodeSelect(userName);  // 주입이 아닌 메서드 파라미터로 전달
        session.setAttribute("user_code", user_code);

        return "success";
    }

    @GetMapping("/mate")
    public String mate(MateVO vo,Model model,HttpSession session){//
        try {
            Integer user_code = (Integer) session.getAttribute("user_code");
            List<MateVO> userselect = service.userselect(user_code);
            List<MateVO> ranking = service.ranking();
            vo.setMatch_yn(service.match_yn(user_code));

            model.addAttribute("ranking",ranking);
            model.addAttribute("vo",vo);
            model.addAttribute("userselect",userselect);
            model.addAttribute("user_code",user_code);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return "mate/mate";
    }
    @PostMapping("/go_profileList")
    @ResponseBody
    public String go_profileList(@RequestParam("Authorization") String token,
                                 @RequestParam("usercode") int usercode,
                                 @RequestParam("gender") String gender,
                                 @RequestParam("match_yn") String match_yn,
                                 @RequestParam("num") int num,
                                 HttpSession session) {
        session.setAttribute("user_code", usercode);
        session.setAttribute("gender", gender);
        session.setAttribute("match_yn", match_yn);
        session.setAttribute("num", num);
        return "success";
    }


    @GetMapping("/profileList")
    public String crewManage(HttpSession session, Model model) {
        Integer create_crew_code = (Integer) session.getAttribute("create_crew_code");
        Integer user_code = (Integer) session.getAttribute("user_code");
        String gender = (String) session.getAttribute("gender");
        String match_yn = (String) session.getAttribute("match_yn");
        Integer num = (Integer) session.getAttribute("num");

        model.addAttribute("user_code", user_code);
        model.addAttribute("gender", gender);
        model.addAttribute("match_yn", match_yn);
        model.addAttribute("num", num);
        return "mate/profileList"; // 이동할 JSP 페이지
    }


    @PostMapping("/more")
    @ResponseBody
    public List<MateVO> more(int more){
        List<MateVO> list = service.more(more);
        return list;
    }
    @PostMapping("/matching")
    @ResponseBody
    public int  matching(@RequestParam("Authorization")String token,int marathonValue,String participationCountValue,int mateCountValue, Model model) {
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
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
    public List<MateVO>  matching(@RequestParam("Authorization")String token,int matching_room_code, Model model) {
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
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
    public int  match_out(@RequestParam("Authorization")String token,int matching_room_code) {
        // int user_code = 4;//유저코드
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
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
    public int  accept(@RequestParam("Authorization")String token,int matching_room_code) {
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
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
    public int  accept_n(@RequestParam("Authorization")String token,int matching_room_code) {
        // int user_code = 4;//유저코드
        int a=1;
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
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
    public int  profile_click(int profileValue, int usercode) {
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
    public int  mate_complite(@RequestParam("Authorization")String token,int matching_room_code) {
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
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
    public List<MateVO> marathon_code(@RequestParam("Authorization")String token){
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
        List<MateVO> list = service.marathon_code_list(user_code);
        return  list;
    }

    @PostMapping("/hide7days")
    @ResponseBody
    public void hide7days(@RequestParam("Authorization")String token, int num){
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
        service.hide7daysAdd(user_code,num);
    }

    @PostMapping("/neverShow")
    @ResponseBody
    public void neverShow(@RequestParam("Authorization")String token, int num){
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);
        service.neverShow(user_code,num);
    }

    @PostMapping("/mate_popup_date_select")
    @ResponseBody
    public Date  mate_popup_date_select(@RequestParam("Authorization")String token) {
        token = token.substring("Bearer ".length());
        String userName = jwtUtil.setTokengetUsername(token);
        int user_code = service.usercodeSelect(userName);  // 주입이 아닌 메서드 파라미터로 전달
        Date mate_popup_date= service.mate_popup_date_select(user_code);
        return mate_popup_date;
    }
}

