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
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/mate")
public class MateController {

    @Autowired
    MateService service;

    @GetMapping("/mate")
    public String matchingList(HttpServletRequest request, Model model){//
        try {
            int user_code = 2;//유저코드
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

    @GetMapping("/profileList")
    public ModelAndView profileList() {
        ModelAndView mav = new ModelAndView();
        // 이 경로는 /WEB-INF/views/mate/profileList.jsp에 매핑됨
        mav.setViewName("mate/profileList");
        return mav;
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
        int user_code = 3;//유저코드
        List<MateVO> room_list = null;
        try {
            int matching_room_code = service.matching_select(marathonValue, ageValue, genderValue, participationCountValue, mateCountValue);
            if (matching_room_code == 0) {
                service.matching_insert_room(marathonValue, ageValue, genderValue, participationCountValue, mateCountValue);
                matching_room_code = service.matching_select(marathonValue, ageValue, genderValue, participationCountValue, mateCountValue);
            }
            service.applicant_insert(matching_room_code, user_code);
            room_list = service.room_select(matching_room_code);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return room_list;
    }



}
