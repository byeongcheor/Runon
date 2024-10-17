package com.ict.finalproject.controller;

import com.ict.finalproject.service.MarathonListService;
import com.ict.finalproject.service.OrderService;
import com.ict.finalproject.vo.CartVO;
import com.ict.finalproject.vo.MarathonListVO;
import com.ict.finalproject.vo.OrderVO;
import com.ict.finalproject.vo.PointVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    OrderService service;
    @Autowired
    MarathonListService marathonListService;

    @PostMapping("/orderForm")
    public String orderForm(@RequestParam("items[]") List<Integer> items, Model model){
        System.out.println("선택된 cart_code들: " + items);
        List<CartVO>Ovo=service.SetOrder(items);

        model.addAttribute("Ovo",Ovo);
        return "order/orderForm";
    }
    @PostMapping("/selectmypoint")
    @ResponseBody
    public Map<String,Object>selectmypoint(@RequestParam("usercode")int usercode){
        Map<String,Object>map=new HashMap<>();
        PointVO pvo =service.getMyPoint(usercode);
        System.out.println(pvo);
        map.put("pvo",pvo);
        return map;
    }


}
