package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.AxiosApiService;
import com.ict.finalproject.vo.AxiosApiVO;
import com.ict.finalproject.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@RestController
@Slf4j
public class AxiosApiController {
    @Autowired
    AxiosApiService service;
    @Autowired
    JWTUtil jwtUtil;

    @PostMapping("/axiosApi")
        public String axiosApi(@RequestParam("refreshToken") String refreshToken){
            System.out.println("ㅗㅑ" + refreshToken);
            String rToken=refreshToken.replaceAll("Bearer ","");
            System.out.println("ㅗafㅑ" + rToken);
            AxiosApiVO vo=service.getTokenVO(rToken);
                if (vo!=null){
            String delete_date= vo.getDeleted_date();
            DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime deletedDate=LocalDateTime.parse(delete_date,formatter);
            LocalDateTime now=LocalDateTime.now();
                if(now.isBefore(deletedDate)){

                int usercode=vo.getUsercode();
                MemberVO mvo =service.getUserVO(usercode);
                String token = "Bearer "+jwtUtil.createJwt(mvo.getUsername(),mvo.getRole(), 60*60*1000L);
                System.out.println("내번호"+token);
                return token;

            }
            }else {

                System.out.println(vo);
                return null;
            }System.out.println(vo);
        return null;
        }


}
