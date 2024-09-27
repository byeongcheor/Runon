package com.ict.finalproject.controller;

import com.ict.finalproject.service.testService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class testController {

    @Autowired
    testService testservice;

    @GetMapping("/test")
    public ModelAndView test() {
        ModelAndView mav = new ModelAndView();
        String userid=testservice.selectAll();
        mav.addObject("userid",userid);
        mav.setViewName("test");
        return mav;
    }
}
