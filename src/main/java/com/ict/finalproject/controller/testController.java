package com.ict.finalproject.controller;

import com.ict.finalproject.service.testService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@RestController
public class testController {

    @Autowired
    testService testservice;


//    @PostMapping("/login")
//    public String getUserInfo(@RequestHeader("Authorization") String token) {
//        System.out.println(token);
//
//        String username = SecurityContextHolder.getContext().getAuthentication().getName();
//        log.info("나는"+username);
//        return null;
//    }
    @GetMapping("/test")
    public String test(@RequestParam("username")String username){
        System.out.println(username);
        return "403뚫고컨트롤러접속성공";
    }


}
