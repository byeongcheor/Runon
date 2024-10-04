package com.ict.finalproject.controller;

import com.ict.finalproject.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@Controller
public class CartController {
    @Autowired
    CartService service;

    //장바구니 이동
    @GetMapping("order/cart")
    public String cart(){

        return "order/cart";
    }
    //주문완료후 주문확인서
    @GetMapping("order/ordersheet")
    public String ordersheet(){

        return "order/ordersheet";
    }

}
