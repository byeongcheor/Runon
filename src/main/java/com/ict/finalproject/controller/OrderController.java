package com.ict.finalproject.controller;

import com.ict.finalproject.service.MarathonListService;
import com.ict.finalproject.service.MypageService;
import com.ict.finalproject.service.OrderService;
import com.ict.finalproject.service.PaymentService;
import com.ict.finalproject.vo.*;
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
    @Autowired
    MypageService mypageService;
    @Autowired
    PaymentService paymentService;

    @PostMapping("/orderForm")
    public String orderForm(@RequestParam("items[]") List<Integer> items,@RequestParam("usercode")int usercode, Model model){
        System.out.println("선택된 cart_code들: " + items);
        List<CartVO>Cvo=service.SetOrder(items);
        int total_amount=0;
        for (CartVO cart : Cvo) {
            total_amount += cart.getPrice()*cart.getQuantity();
        }
        PaymentVO vo=new PaymentVO();
        vo.setTotal_amount(total_amount);
        vo.setUsercode(usercode);
        System.out.println("vo확인"+vo);
        //확인완료System.out.println(total_amount);
        int result=paymentService.createPayment(vo);
        System.out.println(result);
        model.addAttribute("Cvo",Cvo);
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

    @PostMapping("/selectMyForm")
    @ResponseBody
    public Map<String,Object>selectMyForm(@RequestParam("usercode")int usercode){
        Map<String,Object>map=new HashMap<>();
        MarathonFormVO MFvo=service.selectMyForm(usercode);

        map.put("MFvo",MFvo);

        return map;
    }


    @PostMapping("/updateForm")
    @ResponseBody
    public Map<String,Object>updateForm(MarathonFormVO MFvo){
        Map<String,Object>map=new HashMap<>();
        System.out.println(MFvo);
        mypageService.updateMarathonForm(MFvo);
        return map;
    }
}
