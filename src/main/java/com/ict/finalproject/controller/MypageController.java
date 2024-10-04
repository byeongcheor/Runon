package com.ict.finalproject.controller;

import com.ict.finalproject.dto.CustomUserDetails;
import com.ict.finalproject.service.MypageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;


@Slf4j
@Controller
public class MypageController {
    @Autowired
    MypageService service;

   @GetMapping("mypage/myHome")
    public ModelAndView myHome(){
       System.out.println("오냐고?");
        //인증된 사용자 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        System.out.println(authentication);

        String username = null;

        if(authentication != null && authentication.getPrincipal() instanceof UserDetails){
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            username = userDetails.getUsername();
        }

        ModelAndView mav = new ModelAndView();
        mav.setViewName("mypage/myHome");
        //사용자 정보 가져오기
        return mav;
    }
}
