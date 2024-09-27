package com.ict.finalproject.controller;

import com.ict.finalproject.service.testService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
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
    @GetMapping("/user-info")
    public String getUserInfo(@RequestHeader("Authorization") String token) {
        System.out.println(token);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("나는"+username);
        return null;
    }

}
