package com.ict.finalproject.controller;

import com.ict.finalproject.service.PaymentService;
import com.ict.finalproject.vo.OrderVO;
import com.ict.finalproject.vo.PaymentVO;
import com.ict.finalproject.vo.PaymentdetailVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PaymentController {
    @Autowired
    private PaymentService service;


    @ResponseBody
    @PostMapping("/payment/insertpayment")
    public Map<String, Object> insert(@RequestBody Map<String, Object> requestData) {
        System.out.println(requestData);

         String orderId = (String) requestData.get("orderId");
        int usercode = (int) requestData.get("usercode");
        int totalAmount = (int) requestData.get("total_amount");  // 총액
        int discountAmount = (int) requestData.get("discount_amount");  // 할인 금액
        List<Integer> cart_codes = (List<Integer>) requestData.get("cart_codes");  // 카트 코드 리스트

        PaymentdetailVO PDvo=new PaymentdetailVO();
        PDvo.setOrderId(orderId);
        PDvo.setCart_codes(cart_codes);
        System.out.println("확인:"+PDvo);
        //카트코드로 오더코드 가격들 구해와서 payment_detail_tbl에 order_code,payment_code,orderId담기
        service.setPayment(PDvo,usercode,cart_codes);

        Map<String, Object> map = new HashMap<>();
        return map;
    }
 /*   @GetMapping("/success")
    public String success(HttpServletRequest request, Model model) throws Exception {
        return "order/success";
    }
*/

    @PostMapping("/payment/saveOrder")
    public Map<String, Object> saveOrder(@RequestBody Map<String, Object> requestData) {
        String orderId = (String) requestData.get("orderId");
        int usercode = (int) requestData.get("usercode");
        int totalAmount = (int) requestData.get("total_Amount");
        String method = (String) requestData.get("method");
        System.out.println("결제방식"+method);
        System.out.println("유저코드"+usercode);
        System.out.println("주문번호"+orderId);
        System.out.println("결제금액"+totalAmount);
        service.orderSuccess(method,usercode,orderId,totalAmount);

        Map<String, Object> map = new HashMap<>();
        return map;

    }
}
