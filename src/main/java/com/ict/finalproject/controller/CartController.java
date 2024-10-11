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
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/order")
public class CartController {
    @Autowired
    CartService service;
    private PointService pointService; // 포인트 서비스 추가
    private OrderService orderService;
    JWTUtil jwtUtil;
    String username ="";
    int    usercode = 0;

    @PostMapping("/test")
    @ResponseBody
    public String test(@RequestParam("Authorization")String token) {
        token=token.substring("Bearer ".length());
        try {
            username = jwtUtil.setTokengetUsername(token);
            usercode = service.usercodeSelect(username); // usercode 가져오기
            System.out.println("User code: " + usercode);
        } catch (Exception e) {
            System.out.println("Error parsing token: " + e.getMessage());
            e.printStackTrace();
        }
        return username;
    }

    @GetMapping("cart")
    public String cart(CartVO vo, Model model){//
        try {
            // 장바구니 항목 조회
            List<CartVO> cartItems = service.getCartItemsByUserCode(usercode);
            model.addAttribute("cartItems", cartItems); // 장바구니 항목을 모델에 추가

            // 회원의 포인트 정보 가져오기
            PointVO pointInfo = pointService.getPointByUsercode(usercode);
            model.addAttribute("userPoints", pointInfo); // 포인트 정보를 모델에 추가

        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return "order/cart";
    }


    //주문내역
    @GetMapping("ordersheet")
    public String ordersheet(){

        return "order/ordersheet";
    }












}
