package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.*;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MateVO;
import com.ict.finalproject.vo.PointVO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Slf4j
@Controller
public class CartController {
    @Autowired
    CartService service;
    private PointService pointService; // 포인트 서비스 추가
    private OrderService orderService;
    JWTUtil jwtUtil;
    String username ="";
    int    usercode = 0;

    @PostMapping("/cartUser")
    @ResponseBody
    public String cartUser(@RequestParam("Authorization") String token) {
        token=token.substring("Bearer ".length());
        System.out.println("1111111");
        try {
            username = jwtUtil.setTokengetUsername(token);
            System.out.println("Username from Token: " + username);
        } catch (Exception e) {
            System.out.println("Error parsing token: " + e.getMessage());
            e.printStackTrace(); // 전체 스택 트레이스 확인
        }
        return username;
    }

    @GetMapping("order/cart")
    public String cart(CartVO vo, HttpServletRequest request, Model model){//
        try {
            usercode = service.usercodeSelect(username);
            List<CartVO> userselect = service.userselect(usercode);
            // 장바구니 항목 조회
            List<CartVO> cartItems = service.getCartItemsByUserCode(usercode);
            System.out.println(userselect);
            model.addAttribute("cartItems", cartItems); // 모델에 장바구니 항목 추가
            model.addAttribute("vo",vo);
            model.addAttribute("userselect",userselect);

        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return "order/cart";
    }




    //주문내역
    @GetMapping("order/ordersheet")
    public String ordersheet(){

        return "order/ordersheet";
    }












}
