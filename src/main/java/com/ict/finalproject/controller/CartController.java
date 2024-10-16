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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/order")
public class CartController {
    @Autowired
    CartService service;
    @Autowired
    PointService pointService; // 포인트 서비스 추가
    @Autowired
    OrderService orderService;


    @GetMapping("/cart")
    public String cart() {
        return "order/cart";
    }
    @PostMapping("/cart")
    @ResponseBody
    public Map<String,Object> cart(CartVO vo){

        System.out.println("컨트롤러 오는거 확인"+vo.getUsercode());
        Map<String,Object> map = new HashMap<>();
        try {
            int usercode=vo.getUsercode();
            // 장바구니 항목 조회
            List<CartVO> cartItems = service.getCartItemsByUserCode(usercode);
            map.put("cartItems", cartItems);
        } catch (Exception e) {
            // 에러가 발생한 경우 로그 출력
            e.printStackTrace();
        }
        return map;
    }
    @PostMapping("/cartupdate")
    @ResponseBody
    public int cartUpdate(@RequestParam(value = "action",required = false)String action,
                                         @RequestParam(value = "cart_code",required = false)Integer cart_codes){

        if (cart_codes!=null){
            cart_codes=cart_codes.intValue();
        }
        int result =service.updatecart(action,cart_codes);
        return result;
    }
    //삭제시 db에서 없데이트해서 안보이게 하기
    @PostMapping("/deleted")
    @ResponseBody
    public int cartDelted(@RequestBody Map<String, Object> requestData ){
        System.out.println(requestData);
        List<Integer> items = (List<Integer>) requestData.get("items");
        service.deletedcart(items);

        return 0;
    }

    //주문내역
    @GetMapping("/ordersheet")
    public String ordersheet(){

        return "order/ordersheet";
    }












}
