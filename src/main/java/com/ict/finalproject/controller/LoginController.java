package com.ict.finalproject.controller;

import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.JoinService;
import com.ict.finalproject.service.LoginService;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    LoginService service;

    @Autowired
    JWTUtil jwtUtil;
    @Autowired
    MemberService memberService;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private MemberDAO memberDAO;


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

        if (vo!=null) {
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

        }
        result=3;
        map.put("result",result);
        return map;  //정지상태(1)인데 아직 기한이 남았을때


    }
    @GetMapping("/login&join/FindId")
    public String FindId(){

        return "login&join/FindId";
    }
    @PostMapping("/login&join/findId")
    @ResponseBody
    public Map<String,Object> findId(@RequestParam("name")String name,
                                     @RequestParam("tel")String tel){
        Map<String,Object> map=new HashMap<>();
        List<MemberVO>usernames=service.FindIds(name,tel);
        map.put("usernames",usernames);

        return map;
    }

    @PostMapping("/login&join/changePw")
    @ResponseBody
    public Map<String,Object>changePw(@RequestParam("selectedRadio")String username){
        Map<String,Object> map=new HashMap<>();
        MemberVO mvo=   memberDAO.findByUsername(username);
        String token = jwtUtil.createJwt(username,mvo.getRole(), 60*60*24*30*1000L);
        System.out.println(token);
        map.put("token",token);
        return map;
    }
    @GetMapping("/loginjoin/changepw/{token}")
    public String updatePw(@PathVariable("token")String token, Model model){
        System.out.println(token);
        try {
            String username=jwtUtil.setTokengetUsername(token);
            model.addAttribute("username", username);
        }catch (Exception e){

            return "login&join/changefail";
        }
        return "login&join/ChangePw";
    }

    @PostMapping("/login&join/updatepw")
    @ResponseBody
    public Map<String,Object> updatepw(@RequestParam("username")String username,
                                       @RequestParam("password")String password){
        Map<String,Object> map=new HashMap<>();
        String newpassword=bCryptPasswordEncoder.encode(password);
        System.out.println(newpassword);
        int result= service.updatePassword(username,newpassword);
        map.put("result",result);
        return map;

    }
}
