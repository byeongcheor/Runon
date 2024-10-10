package com.ict.finalproject.controller;

import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {




    @GetMapping("/login&join/loginForm")
    public String login() {


        return "login&join/loginForm";
    }



}
