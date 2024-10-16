package com.ict.finalproject.controller;

import com.ict.finalproject.service.LoginService;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    LoginService service;

    @Autowired
    MemberService memberService;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @GetMapping("/login&join/loginForm")
    public String login() {


        return "login&join/loginForm";
    }
    @PostMapping("/login&join/disableCheck")
    @ResponseBody
    public Map<String,Object> disableCheck(@RequestParam("username")String username,
                                           @RequestParam("password")String password) {

        //맵퍼 Member
        int result=0;
        MemberVO vo=memberService.disableCheck(username);
        Map<String,Object> map=new HashMap<>();
        //입력한 비번값이 db랑비교해서 맞으면
//        if (bCryptPasswordEncoder.matches(password, vo.getPassword())) {
        //정지 되었는지 확인
        if (vo.getIs_disabled().equals("1")) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime dateTime = LocalDateTime.parse(vo.getDisabled_date(), formatter);
            LocalDateTime now = LocalDateTime.now();
            //정지상태(1)이고 정지 기한이 아직 안지났으면
            if (dateTime.isBefore(now)) {
                result = memberService.enableUser(username);
                map.put("result", result);
                return map;
            }
            else {
                map.put("disabled_date", vo.getDisabled_date());
                map.put("disabled_start_date", vo.getDisabled_start_date());
                map.put("result",result);
                return map;
            }
        }
//        } 정지 기한이 아니면
        else {
            result=3;
            map.put("result",result);
            return map;
        }
        //정지상태(1)인데 아직 기한이 남았을때


    }





}
