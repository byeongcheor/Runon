package com.ict.finalproject.controller;
import java.util.List;

import com.ict.finalproject.service.MateService;
import com.ict.finalproject.vo.MateVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mate")
public class MateController {
    int user_code = 4;
    @Autowired
    MateService service;

    @GetMapping("/mate")
    public String matchingList(HttpServletRequest request, Model model){//
        try {
            //int user_code = 4;//유저코드
            List<MateVO> marathon_code_list = service.marathon_code_list(user_code);
            List<MateVO> ranking = service.ranking();
            model.addAttribute("marathon_code_list",marathon_code_list);
            model.addAttribute("ranking",ranking);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return "mate/mate";
    }
    @PostMapping("/more")
    @ResponseBody
    public List<MateVO> more(int more){
        List<MateVO> list = service.more(more);
        return  list;

    }
    @PostMapping("/matching")
    @ResponseBody
    public List<MateVO>  matching(int marathonValue,String ageValue,String genderValue,String participationCountValue,int mateCountValue, Model model) {
        //int user_code = 4;//유저코드
        List<MateVO> room_list = null;
        try {
            int matching_room_code = service.matching_select(marathonValue, ageValue, genderValue, participationCountValue, mateCountValue);
            if (matching_room_code == 0) {
                service.matching_insert_room(marathonValue, ageValue, genderValue, participationCountValue, mateCountValue);
                matching_room_code = service.matching_select(marathonValue, ageValue, genderValue, participationCountValue, mateCountValue);
            }
            service.matching_room_personnel_update_plus(matching_room_code);
            service.applicant_insert(matching_room_code, user_code);
            room_list = service.match_view(matching_room_code);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return room_list;
    }

    @PostMapping("/match_yn")
    @ResponseBody
    public int likeInsert(){
        //int user_code = 4;//유저코드
        int like_cnt=0;
        try {
            like_cnt = service.match_yn(user_code);

        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return like_cnt;
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
        return a;
    }

    @PostMapping("/marathon_code")
    @ResponseBody
    public List<MateVO> marathon_code(){
        // int user_code = 4;//유저코드
        List<MateVO> list = service.marathon_code_list(user_code);
        return  list;
    }
}
