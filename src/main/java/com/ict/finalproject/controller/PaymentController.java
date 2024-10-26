package com.ict.finalproject.controller;

import com.ict.finalproject.service.PaymentService;
import com.ict.finalproject.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
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
        //System.out.println("확인:"+PDvo);
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
    @ResponseBody
    public int saveOrder(@RequestBody Map<String, Object> requestData) {
        String orderId = (String) requestData.get("orderId");
        int usercode = (int) requestData.get("usercode");
        int totalAmount = (int) requestData.get("total_Amount");
        String method = (String) requestData.get("method");
        String paymentKey = (String) requestData.get("paymentKey");
        System.out.println("결제방식"+method);
        System.out.println("유저코드"+usercode);
        System.out.println("주문번호"+orderId);
        System.out.println("결제금액"+totalAmount);
        System.out.println("주문고유키"+paymentKey);
        int result=service.orderSuccess(method,usercode,orderId,totalAmount,paymentKey);


        return result ;
    }
    @PostMapping("/payment/complete")
    public ModelAndView complete(@RequestParam("orderId")String orderId,
                                 @RequestParam("totalAmount")int totalAmount,
                                 @RequestParam("method")String method,
                                 @RequestParam("usercode")int usercode) {

       /* System.out.println("결제방식"+method);
        System.out.println("유저코드"+usercode);
        System.out.println("주문번호"+orderId);
        System.out.println("결제금액"+totalAmount);*/
        service.updatepoint(usercode,orderId);
        ModelAndView mav=new ModelAndView();
        mav.addObject("orderId",orderId);
        mav.addObject("totalAmount",totalAmount);
        mav.addObject("method",method);
        mav.addObject("usercode",usercode);
        mav.setViewName("order/complete");

        return  mav;
    }
    @PostMapping("/payment/completed")
    @ResponseBody
    public Map<String,Object>complete(@RequestParam("orderId")String orderId){
        Map<String,Object> map=new HashMap<>();
        //System.out.println(orderId);
        List<CompleteVO>Cvo=new ArrayList<>();
        Cvo=service.selectCvoList(orderId);
        map.put("Cvo",Cvo);
        return map;
    }
    @PostMapping("/payment/cancelpayment")
    @ResponseBody
    public Map<String,Object>cancelpayment(@RequestParam("paymentdetail_codes")List<Integer> codes){
        System.out.println(codes);
        Map<String,Object> map=new HashMap<>();
        List<CompleteVO> Pdvo=service.getPDVO(codes);
        System.out.println(Pdvo);
        map.put("Pdvo",Pdvo);
        return map;
    }
    @PostMapping("/payment/refund")
    @ResponseBody
    public Map<String,Object>refund(RefundVO rvo){
        Map<String,Object> map=new HashMap<>();
        System.out.println(rvo);
        int result =service.refundpay(rvo);
        map.put("result",result);
        return map;
    }
}
