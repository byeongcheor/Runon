package com.ict.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/adminPages")
public class AdminController {

    @GetMapping("/adminHome")
    public String admin(){

        return "adminPages/adminHome";
    }
}
