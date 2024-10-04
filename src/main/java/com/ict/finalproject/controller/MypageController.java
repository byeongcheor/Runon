package com.ict.finalproject.controller;

import com.ict.finalproject.dto.CustomUserDetails;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.MypageService;
import com.ict.finalproject.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Controller
public class MypageController {
    @Autowired
    MypageService service;
    @Autowired
    MemberService memberservice;
    private int usercode = 30;

    @GetMapping("mypage/myHome")
    public String myHome(Model model, HttpServletRequest request){


        return "mypage/myHome";
    }
}
