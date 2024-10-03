package com.ict.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@Controller
public class LoginController {


    @GetMapping("/login&join/loginForm")
    public String login() {


        return "login&join/loginForm";
    }

}
