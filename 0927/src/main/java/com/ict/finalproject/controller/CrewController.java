package com.ict.finalproject.controller;

import com.ict.finalproject.service.CrewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
public class CrewController {
    @Autowired
    CrewService service;

    @GetMapping("crew/crewList")
    public ModelAndView crewList(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/crew/crewList");
        return mav;
    }
}
