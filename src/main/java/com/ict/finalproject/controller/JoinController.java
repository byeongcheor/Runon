package com.ict.finalproject.controller;


import com.ict.finalproject.service.JoinService;
import com.ict.finalproject.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Slf4j
public class JoinController {

    @Autowired
    private JoinService service;

    @GetMapping("/JoinForm")
    public String joinForm() {
        return "login&join/JoinForm";
    }



    //아이디 중복검사
    @GetMapping("/idDoubleCheck")
    public ModelAndView idDoubleCheck(String username) {

        //db 조회
        int result = service.idDoubleCheck(username);
        ModelAndView mav = new ModelAndView();
        mav.addObject("result", result);
        mav.addObject("username", username); //뷰페이지에서 필요함
        mav.setViewName("login&join/idDoubleCheck");
        return mav;
    }
    @PostMapping("/joins")
    public String joinsProcess(MemberVO vo) {
        System.out.println(vo.toString());
        int success=service.joinProcess(vo);

        if (success==1) {
            return "login&join/joinOk";
        }
        return "login&join/joinfalse";


    }
    @GetMapping("/nickCheck")
    @ResponseBody
    public int nickCheck(String nickname) {
        int result=service.nickCheck(nickname);

        return result;
    }
}
