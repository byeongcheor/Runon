package com.ict.finalproject.controller;

import com.ict.finalproject.service.MarathonService;
import com.ict.finalproject.service.OrderService;
import com.ict.finalproject.vo.OrderVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Slf4j
@Controller
public class OrderController {
    @Autowired
    OrderService service;
    @Autowired
    MarathonService marathonservice;



    // 주문 생성
    @PostMapping("/create")
    public OrderVO createOrder(@RequestBody OrderVO order) {
        service.createOrder(order);
        return order; // 생성된 주문 정보를 반환
    }

//    // 주문 내역 조회
//    @GetMapping("order/ordersheet")
//    public String getOrderHistory(@AuthenticationPrincipal UserDetails userDetails, Model model) {
//        String username = userDetails.getUsername(); // 로그인한 사용자 정보 가져오기
//        List<OrderVO> orderHistory = service.getOrderHistoryByUsername(username); // username으로 주문 내역 조회
//
//        // 각 주문의 marathon_code를 사용하여 marathon_name을 추가
//        //for (OrderVO order : orderHistory) {
//           // MarathonListVO marathon = marathonListService.getMarathonByCode(order.getMarathon_code());
//          //  if (marathon != null) { // Null 체크 추가
//           //     order.setMarathon_name(marathon.getMarathon_name()); // OrderVO에 marathon_name 추가
//          //  } else {
//           //     order.setMarathon_name("Unknown Marathon"); // 또는 적절한 기본 값 설정
//           // }
//      //  }
//
//       // model.addAttribute("orderHistory", orderHistory); // JSP로 데이터 전달
//
//        return "order/ordersheet"; // JSP 경로
//    }




}
