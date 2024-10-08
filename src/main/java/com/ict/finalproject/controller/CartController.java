package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.*;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.PointVO;
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
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@Controller
public class CartController {
    @Autowired
    CartService service;
    @Autowired
    private JWTUtil jwtUtil;
    @Autowired
    private PointService pointService; // 포인트 서비스 추가
    @Autowired
    private OrderService orderService;

    //장바구니 이동
    @GetMapping("order/cart")
    public String cart(){

        return "order/cart";
    }

    //주문내역
    @GetMapping("order/ordersheet")
    public String ordersheet(){

        return "order/ordersheet";
    }

    // 장바구니 페이지 표시
    @GetMapping("/cart")
    public String showCart(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        String username = userDetails.getUsername(); // 로그인한 사용자 정보 가져오기
        List<CartVO> cartItems = service.getCartItemsByUsername(username); // username으로 장바구니 아이템 조회
        // 사용자 포인트 조회
        PointVO userPoints = pointService.getUserPointsByUsername(username); // PointService에서 포인트 조회

        // 모델에 장바구니 아이템과 사용자 포인트 추가
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("userPoints", userPoints);

        return "order/cart"; // JSP 경로
    }










}
