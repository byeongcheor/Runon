package com.ict.finalproject.controller;

import com.ict.finalproject.service.MypageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
public class MypageController {
    @Autowired
    MypageService service;

    @GetMapping("mypage/mypageHome")
    public ModelAndView mypageHome(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/mypageHome");
        return mav;
    }
}
