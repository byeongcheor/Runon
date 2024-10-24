package com.ict.finalproject;


import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.JoinService;
import com.ict.finalproject.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    @GetMapping("/callback")
    public String handleCallback(HttpServletRequest request, Model model) {
        // 클라이언트로부터 요청을 받고 필요한 로직을 수행
        String token = request.getHeader("Authorization");
        // 클라이언트 측에 필요한 데이터를 모델로 전달
        model.addAttribute("token", token);

        // 처리 후 특정 페이지로 이동
        return "callback";

    }
}
