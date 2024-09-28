package com.ict.finalproject.controller;

import com.ict.finalproject.service.CrewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
public class CrewController {
    @Autowired
    CrewService service;
    //크루모집페이지폼이동
    @GetMapping("crew/crewList")
    public String crewList(){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("crew/crewList");
        return "crew/crewList";
    }
    //크루생성페이지폼
    @GetMapping("crew/crewCreate")
    public ModelAndView crewCreate(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("crew/crewCreate");
        return mav;
    }
}
