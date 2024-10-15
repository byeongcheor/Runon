package com.ict.finalproject.controller;

import com.ict.finalproject.service.CrewService;
import com.ict.finalproject.service.MarathonService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
public class MarathonController {
    @Autowired
    MarathonService service;

    @GetMapping("marathon/marathonList")
    public ModelAndView marathonList(){
        ModelAndView mav =new ModelAndView();
        mav.setViewName("marathon/marathonList");

        return mav;
    }
    @GetMapping("/marathon/marathonDetail")
    public String marathonDetail(){

        return "marathon/marathonDetail";
    }
}