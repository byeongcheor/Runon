package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class testController {
    @Autowired
    JWTUtil jwtUtil;

    @PostMapping("test")
    @ResponseBody
    public String test(@RequestParam("Authorization")String token) {
        token=token.substring("Bearer ".length());
        String username=jwtUtil.setTokengetUsername(token);
        System.out.println(username);
        return username;


    }
}
