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

    @Autowired
    MateService service;

    @GetMapping("/mate")
    public String matchingList(HttpServletRequest request, Model model){//
        int user_code = 2;//유저코드
        List<MateVO> marathon_code_list = service.marathon_code_list(user_code);
        List<MateVO> ranking = service.ranking();
        model.addAttribute("marathon_code_list",marathon_code_list);
        model.addAttribute("ranking",ranking);
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
    public String  matching(int marathonValue,String ageValue,String genderValue,String participationCountValue,int mateCountValue){
        int user_code = 2;//유저코드
        String yn="Y";
        try {
            int matching_room_code = service.matching_select(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
            if(matching_room_code==0){
                service.matching_insert_room(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
                matching_room_code = service.matching_select(marathonValue,ageValue,genderValue,participationCountValue,mateCountValue);
            }


        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }


        return yn;
    }
}
