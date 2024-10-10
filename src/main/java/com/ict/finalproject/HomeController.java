package com.ict.finalproject;


import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.JoinService;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.Map;

@Controller
public class HomeController {
    @Autowired
    JWTUtil jwtUtil;
    @Autowired
    JoinService joinService;

    @GetMapping("/")
    public String home(){

        return "home";
    }


    @PostMapping("/setToKengetUsers")
    @ResponseBody
    public Map<String,Object> setToKengetUsers(@RequestParam("ToKen")String ToKen){
        Map<String,Object> map = new HashMap<String,Object>();
        String username=jwtUtil.setTokengetUsername(ToKen);
        MemberVO mvo = joinService.getUsers(username);
        map.put("mvo",mvo);
        return map;
    }

}
